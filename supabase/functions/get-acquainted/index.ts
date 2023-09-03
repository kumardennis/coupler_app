import {
  ConnInfo,
  Handler,
  serve,
} from "https://deno.land/std@0.168.0/http/server.ts";
import { corsHeaders } from "../_shared/cors.ts";

console.log("Setting up localdev");

const handlers = {
  "create-acquainted-session": await import(
    "./create-acquainted-session/handler.ts"
  )
    .then((it) => it.handler),

  "create-acquainted-session-survey": await import(
    "./create-acquainted-session-survey/handler.ts"
  )
    .then((it) => it.handler),

  "get-acquainted-current-session": await import(
    "./get-acquainted-current-session/handler.ts"
  )
    .then((it) => it.handler),

  "get-acquainted-previous-sessions": await import(
    "./get-acquainted-previous-sessions/handler.ts"
  )
    .then((it) => it.handler),

  "get-acquainted-session-survey": await import(
    "./get-acquainted-session-survey/handler.ts"
  )
    .then((it) => it.handler),

  "update-acquainted-session": await import(
    "./update-acquainted-session/handler.ts"
  )
    .then((it) => it.handler),

  "update-acquainted-session-survey": await import(
    "./update-acquainted-session-survey/handler.ts"
  )
    .then((it) => it.handler),

  "update-acquainted-survey": await import(
    "./update-acquainted-survey/handler.ts"
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
