import {
  ConnInfo,
  Handler,
  serve,
} from "https://deno.land/std@0.168.0/http/server.ts";
import { corsHeaders } from "../_shared/cors.ts";

console.log("Setting up localdev");

const handlers = {
  "accept-couple": await import(
    "./accept-couple/handler.ts"
  )
    .then((it) => it.handler),

  "create-couple": await import(
    "./create-couple/handler.ts"
  )
    .then((it) => it.handler),

  "create-couple-special-date": await import(
    "./create-couple-special-date/handler.ts"
  )
    .then((it) => it.handler),

  "create-user": await import(
    "./create-user/handler.ts"
  )
    .then((it) => it.handler),

  "get-couple": await import(
    "./get-couple/handler.ts"
  )
    .then((it) => it.handler),

  "get-couple-special-dates": await import(
    "./get-couple-special-dates/handler.ts"
  )
    .then((it) => it.handler),

  "get-user": await import(
    "./get-user/handler.ts"
  )
    .then((it) => it.handler),

  "get-user-settings": await import(
    "./get-user-settings/handler.ts"
  )
    .then((it) => it.handler),

  "update-user-settings": await import(
    "./update-user-settings/handler.ts"
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
