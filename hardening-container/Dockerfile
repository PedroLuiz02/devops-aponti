# Imagem leve, e com versão definida, possibilitando uma melhor reprodução
FROM node:20-alpine

WORKDIR /app

# Instala só as dependências
COPY package*.json ./
RUN npm install  --omit=dev

# Copia apenas o código da aplicação
COPY --chown=node:node app/ ./app/

# Usuário comum
USER node

EXPOSE 3000
CMD ["node", "app/server.js"]