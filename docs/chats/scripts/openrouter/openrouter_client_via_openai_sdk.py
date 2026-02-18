import sys,os
from openai import OpenAI

client = OpenAI(
  base_url="https://openrouter.ai/api/v1",
  api_key=os.getenv("OPENROUTER_API_KEY"),
)

completion = client.chat.completions.create(
  model="openrouter/free",
  messages=[
    {
      "role": "user",
      "content": sys.stdin.read()
    }
  ]
)

print(completion.choices[0].message.content)
