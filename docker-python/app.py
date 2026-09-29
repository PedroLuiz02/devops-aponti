# app.py - Um aplicativo python sem dependências

from http.server import BaseHTTPRequestHandler, HTTPServer
import os

porta = int(os.environ.get("porta", 8000))
mensagem = os.environ.get("mensagem", "App python rodando no Docker!")

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.end_headers()
        self.wfile.write(f"<h1>{mensagem}</h1>".encode("utf-8"))

if __name__ == "__main__":
    print(f"Servidor rodando atráves da porta {porta}", flush=True)
    HTTPServer(("0.0.0.0", porta), Handler).serve_forever()
