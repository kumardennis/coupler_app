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
import { corsHeaders } from "../../_shared/cors.ts";
import { createSupabase } from "../../_shared/supabaseClient.ts";

export const handler = async (req: Request) => {
  const supabase = createSupabase(req);

  try {
    const { userId, partnerShareableUuid } = await req
      .json();

    if (
      !confirmedRequiredParams([
        userId,
        partnerShareableUuid,
      ])
    ) {
      return new Response(JSON.stringify(errorResponseData), {
        headers: { "Content-Type": "application/json" },
      });
    }

    const { data: partnerData, error: partnerError } = await supabase.from(
      "users",
    ).select("id").match({ shareableUuid: partnerShareableUuid });

    if (partnerData === null || partnerData?.length === 0) {
      const responseData = {
        isRequestSuccessful: false,
        data: null,
        error: "User not found",
      };

      return new Response(JSON.stringify(responseData), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const partnerId = partnerData[0].id;

    const { data: coupleData, error: coupleError } = await supabase.from(
      "couples",
    ).select("id").or(
      `partner1_id.eq.${partnerId},partner2_id.eq.${partnerId}`,
    );

    if (coupleData !== null && coupleData?.length > 0) {
      const responseData = {
        isRequestSuccessful: false,
        data: null,
        error: "Already committed :(",
      };

      return new Response(JSON.stringify(responseData), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const { data, error } = await supabase.from("couples").insert({
      partner1_id: userId,
      partner2_id: partnerId,
      anniversary: null,
      initiatedById: userId,
    }).select();

    const responseData = {
      isRequestSuccessfull: error === null,
      data,
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
