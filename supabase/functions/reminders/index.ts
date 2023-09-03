import {
  ConnInfo,
  Handler,
  serve,
} from "https://deno.land/std@0.168.0/http/server.ts";
import { corsHeaders } from "../_shared/cors.ts";

console.log("Setting up localdev");

const handlers = {
  "create-reminder-survey-score": await import(
    "./create-reminder-survey-score/handler.ts"
  )
    .then((it) => it.handler),

  "get-reminder-survey-scores": await import(
    "./get-reminder-survey-scores/handler.ts"
  )
    .then((it) => it.handler),

  "get-reminder-couple-needs": await import(
    "./get-reminder-couple-needs/handler.ts"
  )
    .then((it) => it.handler),

  "upsert-reminder-couple-needs": await import(
    "./upsert-reminder-couple-needs/handler.ts"
  )
    .then((it) => it.handler),
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
