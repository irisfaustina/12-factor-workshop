// ./walkthrough/01-agent.baml
// human tools are asyn requests to human

type HumanTools = ClarificationRequest | DoneForNow

class ClarificationRequest{
  intent "request_more_information" @description ("you can request more information from me")
  message string
}
class DoneForNow {
  intent "done_for_now"
  message string @description(#"
    message to send to the user about the work that was done.
  "#)
}

function DetermineNextStep(
    thread: string 
) -> HumanTools | CalculatorTools {
    client "openai/gpt-4"

    prompt #"
        {{ _.role("system") }}

        You are a helpful assistant that can help with tasks.


        {{ _.role("user") }}

        You are working on the following thread:

        {{ thread }}

        What should the next step be?

        {{ ctx.output_format }}
    "#
}

test HelloWorld {
  functions [DetermineNextStep]
  args {
    thread #"
      {
        "type": "user_input",
        "data": "hello!"
      }
    "#
  }
}

test MathOperationWithClarification {
  functions [DetermineNextStep]
  args{
    thread #"
      [{"type":"user_input","data":"can you multiply 3 and feee9ff10"}]
    "#
  }
  @@assert(intent, {{this.intent == "request_more_information"}})
}

test MathOperationPostClarification {
  functions [DetermineNextStep]
  args{
    thread #"
      [
      {"type":"user_input","data":"can you multiply 3 and FD*(#F&& ?"},
      {"type":"tool_call","data":{"intent":"request_more_information","message":"It seems like there was a typo or mistake in your request. Could you please clarify or provide the correct numbers you would like to multiply?"}},
      {"type":"human_response","data":"lets try 12 instead"},
      ]
    "#
  }
  @@assert(intent, {{this.intent == "done_for_now"}})
  @@assert(a, {{this.b == 12}})
  @@assert(b, {{this.a == 3}})
}