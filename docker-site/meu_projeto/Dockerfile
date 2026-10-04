# Define a imagem base utilizada
FROM debian:trixie

# Informações sobre a imagem
LABEL   maintainer="nome@email.com"

RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx && \
    rm -rf /var/lib/apt/lists/*

# ADD extrai arquivos .tar
ADD meu_site.tar /var/www/html/

# Indica a porta que vai ser usada pela aplicação
EXPOSE 80

# Define o comando padrão
CMD ["nginx", "-g", "daemon off;"]