import os
from fastapi import FastAPI
from openai import OpenAI

app = FastAPI()
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

@app.get("/healthz")
def healthz():
    return {"ok": True}

@app.get("/hello")
def hello():
    try:
        r = client.responses.create(model="gpt-4o-mini",
                                    input="Say 'Lumio is live'.")
        text = r.output_text
    except Exception as e:
        text = f"OpenAI error: {e}"
    return {"message": text}
