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

interface CreateUserStudentResponseModel {
  isRequestSuccessful: boolean;
  error: any;
  data:
    | {
      createdStudentUserData: User | null;
      createdStudentRecordData: any[] | null;
    }
    | { user: User | null }
    | null;
}

export const handler = async (req: Request) => {
  const supabase = createSupabase(req);

  try {
    const { email, password, phone, firstName, lastName } = await req
      .json();

    if (
      !confirmedRequiredParams([
        email,
        password,
        phone,
        firstName,
        lastName,
      ])
    ) {
      return new Response(JSON.stringify(errorResponseData), {
        headers: { "Content-Type": "application/json" },
      });
    }

    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      phone,
    });

    if (error !== null) {
      const responseData: CreateUserStudentResponseModel = {
        isRequestSuccessful: false,
        data: data,
        error: error,
      };

      return new Response(JSON.stringify(responseData), {
        headers: { "Content-Type": "application/json" },
      });
    }

    const createdStudentRecord = await supabase
      .from("users")
      .insert({
        firstName,
        lastName,
        name: `${firstName} ${lastName}`,
        userUid: data.user?.id,
      })
      .select();

    const createdStudentRecordData = createdStudentRecord.data;

    const responseData: CreateUserStudentResponseModel = {
      isRequestSuccessful: true,
      data: { createdStudentUserData: data.user, createdStudentRecordData },
      error: {
        createdStudentUserError: error,
        createdStudentRecordError: createdStudentRecord.error,
      },
    };

    if (createdStudentRecordData) {
      const createdUserSettings = await supabase
        .from("user_settings")
        .insert({
          userId: createdStudentRecordData[0].id,
          darkMode: false,
          blueAccent: false,
        })
        .select();
    }

    return new Response(JSON.stringify(responseData), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (err) {
    const responseData: CreateUserStudentResponseModel = {
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
