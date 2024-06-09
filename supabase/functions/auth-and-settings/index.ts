import {
  ConnInfo,
  Handler,
  serve,
} from "https://deno.land/std@0.168.0/http/server.ts";
import { corsHeaders } from "../_shared/cors.ts";

import { handler as accept_couple } from "./accept-couple/handler.ts";
import { handler as create_couple } from "./create-couple/handler.ts";
import { handler as create_couple_special_date } from "./create-couple-special-date/handler.ts";
import { handler as create_user } from "./create-user/handler.ts";
import { handler as get_couple } from "./get-couple/handler.ts";
import { handler as get_couple_special_dates } from "./get-couple-special-dates/handler.ts";
import { handler as get_user } from "./get-user/handler.ts";
import { handler as get_user_settings } from "./get-user-settings/handler.ts";
import { handler as update_user_settings } from "./update-user-settings/handler.ts";
import { handler as update_couple_anniversary } from "./update-couple-anniversary/handler.ts";

console.log("Setting up localdev");

const handlers = {
  "accept-couple": accept_couple,
  "create-couple": create_couple,
  "create-couple-special-date": create_couple_special_date,
  "create-user": create_user,
  "get-couple": get_couple,
  "get-couple-special-dates": get_couple_special_dates,
  "get-user": get_user,
  "get-user-settings": get_user_settings,
  "update-user-settings": update_user_settings,
  "update-couple-anniversary": update_couple_anniversary,
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
