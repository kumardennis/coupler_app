// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import {
  confirmedRequiredParams,
  errorResponseData,
} from "../../_shared/confirmedRequiredParams.ts";
import { constants } from "../../_shared/constants.ts";
import { corsHeaders } from "../../_shared/cors.ts";
import { createSupabase } from "../../_shared/supabaseClient.ts";

export const handler = async (req: Request) => {
  const supabase = createSupabase(req);

  try {
    const { userId, coupleId, dailyQuestionId } = await req.json();

    if (!confirmedRequiredParams([userId, coupleId])) {
      return new Response(JSON.stringify(errorResponseData), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const query = supabase
      .from("daily_questions")
      .select(
        `*, ${constants.dailyQuestionQuery}, couples_daily_questions!inner(*, users(${constants.partnerQuery}))`
      )
      // .select(
      //   `*, daily_questions(*, ${constants.dailyQuestionQuery}), couples(*, ${constants.coupleQuery})`
      // )
      .eq("couples_daily_questions.coupleId", coupleId);

    if (dailyQuestionId) {
      query.eq("id", dailyQuestionId);
    }

    const { data, error } = await query;

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
