import {
  ConnInfo,
  Handler,
  serve,
} from "https://deno.land/std@0.168.0/http/server.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { handler as create_reminder_survey_score } from "./create-reminder-survey-score/handler.ts";
import { handler as get_reminder_survey_scores } from "./get-reminder-survey-scores/handler.ts";
import { handler as get_reminder_couple_needs } from "./get-reminder-couple-needs/handler.ts";
import { handler as upsert_reminder_survey_score } from "./upsert-reminder-couple-needs/handler.ts";

console.log("Setting up localdev");

const handlers = {
  "create-reminder-survey-score": create_reminder_survey_score,

  "get-reminder-survey-scores": get_reminder_survey_scores,

  "get-reminder-couple-needs": get_reminder_couple_needs,

  "upsert-reminder-couple-needs": upsert_reminder_survey_score,
} as Record<string, Handler>;

function localdevHandler(req: Request, connInfo: ConnInfo) {
  // This is needed if you're planning to invoke your function from a browser.
  if (req.method === "OPTIONS") {
    return new Response("OK", { headers: corsHeaders });
  }

  const url = new URL(req.url);
  const urlParts = url.pathname.split("/");
  const handlerName = urlParts[urlParts.length - 1];
  const handler = handlers[handlerName];

  console.log(`${handlerName} ${req.url}`);
  try {
    return handler(req, connInfo);
  } catch (err) {
    return new Response(
      JSON.stringify({ error: err }),
      {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 200,
      },
    );
  }
}

serve(localdevHandler);
