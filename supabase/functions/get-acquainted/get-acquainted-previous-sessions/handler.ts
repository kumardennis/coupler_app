// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.
import {
  ConnInfo,
  Handler,
  serve,
} from "https://deno.land/std@0.168.0/http/server.ts";
import {
  AuthError,
  User,
} from "https://esm.sh/v96/@supabase/gotrue-js@2.16.0/dist/module/index.d.ts";
import {
  confirmedRequiredParams,
  errorResponseData,
} from "../../_shared/confirmedRequiredParams.ts";
import { constants } from "../../_shared/constants.ts";
import { corsHeaders } from "../../_shared/cors.ts";
import { createSupabase } from "../../_shared/supabaseClient.ts";
import lodash from "https://cdn.skypack.dev/lodash";

const _ = lodash;

export const handler = async (req: Request) => {
  const supabase = createSupabase(req);

  try {
    const { coupleId, userId } = await req
      .json();

    if (
      !confirmedRequiredParams([
        coupleId,
        userId,
      ])
    ) {
      return new Response(JSON.stringify(errorResponseData), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    let query = supabase.from("acquainted_sessions_surveys")
      .select(
        `id, acquainted_sessions!inner(*, ${constants.acquaintedQuestionQuery}), acquainted_surveys!inner(id, predictedScore, score, created_at, coupleId, users(${constants.userQuery}))`,
      ).eq("acquainted_sessions.coupleId", coupleId).eq(
        "acquainted_surveys.coupleId",
        coupleId,
      ).eq("acquainted_sessions.hasEnded", true);

    const { data, error } = await query;

    const groupedBySessionId = _.groupBy(
      data,
      "acquainted_sessions.id",
    );

    const arrangedData: {
      acquainted_sessions: any;
      acquainted_surveys1: any;
      acquainted_surveys2: any;
    }[] = [];

    Object.keys(groupedBySessionId).forEach((key) => {
      const sessionInfo = groupedBySessionId[key][0].acquainted_sessions;
      const surveyInfo1 = groupedBySessionId[key][0].acquainted_surveys;
      const surveyInfo2 = groupedBySessionId[key][1].acquainted_surveys;

      arrangedData.push({
        acquainted_sessions: sessionInfo,
        acquainted_surveys1: surveyInfo1,
        acquainted_surveys2: surveyInfo2,
      });
    });

    console.log(arrangedData);

    const responseData = {
      isRequestSuccessfull: error === null,
      data: arrangedData,
      error,
    };

    return new Response(JSON.stringify(responseData), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (err) {
    const responseData = {
      isRequestSuccessful: false,
      data: null,
      error: err,
    };

    return new Response(JSON.stringify(responseData), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
};

// To invoke:
// curl -i --location --request POST 'http://localhost:54321/functions/v1/' \
//   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
//   --header 'Content-Type: application/json' \
//   --data '{"name":"Functions"}'
