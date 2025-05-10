// Defining a data model.
// workshop bonus
class Resume {
  name string
  email string
  experience Experience[]
  skills string[]
}

// Create a function to extract the resume from a string.
class Experience {
    company Company
    title string
    start_date string?
    end_date string?
    decription string?
}

// company type to represent confidence
class Company {
    name string
    company_type "well-known" | "unknown"
    legal_name string? @description(#"
        best guess  if the company is well-known
    "#) @alias(parent_company_legalname)
}

function ExtractResume(resume: string) -> Resume {
  // Specify a client as provider/model-name
  // you can use custom LLM params with a custom client name from clients.baml like "client CustomHaiku"
  // token efficient way working with LLM to layout format
  client "openai/gpt-4o" // Set OPENAI_API_KEY to use this client.
  prompt #"
    Extract from this content:
    {{ resume }}

    {{ ctx.output_format }}

    don't use quotes around strings

    first list out companies to make sure you don't miss any
    -..
    -..
    ...

  "#
}



// Test the function with a sample resume. Open the VSCode playground to run this.
test vaibhav_resume {
  functions [ExtractResume]
  args {
    resume #"
      Vaibhav Gupta
      vbv@boundaryml.com

      Experience:
      - Founder at BoundaryML
      - CV Engineer at Google
      - CV Engineer at Microsoft

      Skills:
      - Rust
      - C++
    "#
  }
}