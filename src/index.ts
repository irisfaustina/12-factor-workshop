import 'dotenv/config';
import { cli } from "./cli"
import OpenAI from 'openai';

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY, // Use environment variables for security
});

async function hello(): Promise<void> {
    console.log('hello, world!')
}

async function main() {
    await cli()
}

main().catch(console.error)