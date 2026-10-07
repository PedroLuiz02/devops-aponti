from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "<h1>Aplicativo Flask rodando no Docker</h1>"

app.run(host="0.0.0.0", port=5050)