# Define a imagem base utilizada
FROM ubuntu:22.04

# Informações sobre a imagem
LABEL   maintainer="nome@email.com" \
        description="App python rodando sobre o Ubuntu"

# Define uma variável de ambiente
ENV porta=8000 \
    mensagem="App python rodando no Docker!"

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 \
    && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho
WORKDIR /app

# Copia o código do app do computador para dentro da imagem.
COPY app.py .

# Indica a porta que vai ser usada pela aplicação
EXPOSE 8000

# Define o comando padrão
CMD ["python3", "app.py"]