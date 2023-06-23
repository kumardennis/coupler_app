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
} from "../_shared/confirmedRequiredParams.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { createSupabase } from "../_shared/supabaseClient.ts";

serve(async (req: Request) => {
  const supabase = createSupabase(req);

  try {
    const { reminderNeedId, coupleId, frequency, timePeriod } = await req
      .json();

    if (
      !confirmedRequiredParams([
        reminderNeedId,
        coupleId,
        frequency,
        timePeriod,
      ])
    ) {
      return new Response(JSON.stringify(errorResponseData), {
        headers: { "Content-Type": "application/json" },
      });
    }

    // First get the current frequency
    const { data: oldData, error: oldError } = await supabase
      .from("couples_reminder_needs")
      .select("frequency")
      .eq("coupleId", coupleId)
      .eq("reminderNeedId", reminderNeedId);

    let oldFrequency = 0;

    if (oldError || !oldData || oldData.length === 0) {
      console.log("old frequency not found");
    } else {
      oldFrequency = oldData[0].frequency;
    }

    // Calculate the new average frequency
    const newFrequency = (oldFrequency + frequency) / 2;

    const { data, error } = await supabase.from("couples_reminder_needs")
      .upsert({
        reminderNeedId,
        coupleId,
        frequency: newFrequency,
        timePeriod,
      }).match({ coupleId, reminderNeedId }).select();

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
});

// To invoke:
// curl -i --location --request POST 'http://localhost:54321/functions/v1/' \
//   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
//   --header 'Content-Type: application/json' \
//   --data '{"name":"Functions"}'
