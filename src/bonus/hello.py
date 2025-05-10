#/workshop bonus

import asyncio
from baml_client import b # type: ignore
from baml_client.types import CompanyType # type: ignore

async def main():
    print("Hello from workshop-bonus!")

    resume = await b.ExtractResume(resume_str) # type: ignore
    print(resume.experience)
    for experience in resume.experience:
        company = experience.company
        if company.company_type == "well-known"
            if look_up_company_in_db(company.name): # type: ignore
                if new_company_name: # type: ignore
                    print(company.legal_name)
                else:
                    pass
            else:
                pass
        
        print(experience.company)


if __name__ == "__main__":
    asyncio.run(main())