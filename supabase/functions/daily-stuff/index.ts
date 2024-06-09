import {
  ConnInfo,
  Handler,
  serve,
} from "https://deno.land/std@0.168.0/http/server.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { handler as get_daily_question } from "./get-daily-question/handler.ts";
import { handler as get_daily_quote } from "./get-daily-quote/handler.ts";
import { handler as get_answered_daily_questions } from "./get-answered-daily-questions/handler.ts";
import { handler as create_answered_daily_question } from "./create-answered-daily-question/handler.ts";

console.log("Setting up localdev");

const handlers = {
  "get-daily-question": get_daily_question,
  "get-daily-quote": get_daily_quote,
  "get-answered-daily-questions": get_answered_daily_questions,
  "create-answered-daily-question": create_answered_daily_question,
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
    return new Response(JSON.stringify({ error: err }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 200,
    });
  }
}

serve(localdevHandler);
