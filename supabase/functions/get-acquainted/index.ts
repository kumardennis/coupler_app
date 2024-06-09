import {
  ConnInfo,
  Handler,
  serve,
} from "https://deno.land/std@0.168.0/http/server.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { handler as create_acquainted_session } from "./create-acquainted-session/handler.ts";
import { handler as get_acquainted_current_session } from "./get-acquainted-current-session/handler.ts";
import { handler as create_acquainted_session_survey } from "./create-acquainted-session-survey/handler.ts";
import { handler as get_acquainted_previous_sessions } from "./get-acquainted-previous-sessions/handler.ts";
import { handler as get_acquainted_session_survey } from "./get-acquainted-session-survey/handler.ts";
import { handler as update_acquainted_session_survey } from "./update-acquainted-session-survey/handler.ts";
import { handler as update_acquainted_session } from "./update-acquainted-session/handler.ts";
import { handler as update_acquainted_survey } from "./update-acquainted-survey/handler.ts";

console.log("Setting up localdev");

const handlers = {
  "create-acquainted-session": create_acquainted_session,

  "create-acquainted-session-survey": create_acquainted_session_survey,

  "get-acquainted-current-session": get_acquainted_current_session,

  "get-acquainted-previous-sessions": get_acquainted_previous_sessions,

  "get-acquainted-session-survey": get_acquainted_session_survey,

  "update-acquainted-session": update_acquainted_session,

  "update-acquainted-session-survey": update_acquainted_session_survey,

  "update-acquainted-survey": update_acquainted_survey,
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
