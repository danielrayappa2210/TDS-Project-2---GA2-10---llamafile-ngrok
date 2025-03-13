from fastapi import FastAPI, Request, Form, HTTPException
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from fastapi.staticfiles import StaticFiles
import requests
import json
import subprocess

app = FastAPI()
templates = Jinja2Templates(directory="templates")

LLAMA_URL = "http://127.0.0.1:9090/completion"

@app.get("/", response_class=HTMLResponse)
async def read_root(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

@app.post("/chat")
async def chat(prompt: str = Form(...)):
    payload = {
        "prompt": prompt,
        "temperature": 0.7,
        "max_tokens": 200
    }

    headers = {
        "Content-Type": "application/json"
    }

    try:
        response = requests.post(LLAMA_URL, data=json.dumps(payload), headers=headers)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    subprocess.Popen(["./llama.llamafile", "--server", "--nobrowser", "--host", "0.0.0.0", "--port", "9090", "--parallel", "2"])
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
