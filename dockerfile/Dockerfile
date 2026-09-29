# Define a imagem base utilizada
FROM ubuntu:22.04

# RUN para instalar as dependências do Python e o Flask
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip install flask==3.0.*

# Informações sobre a imagem
LABEL maintainer="Pedro"
LABEL version="1.0"

# Define uma variável de ambiente
ENV FLASK_APP=aponti

# Define o diretório de trabalho
WORKDIR /app

# ADD copia arquivos para dentro da imagem
ADD aponti.py /app/aponti.py

# Indica a porta que vai ser usada pela aplicação
EXPOSE 8000

# Define um volume para dados
VOLUME ["/app/dados"]

# Define o programa principal
ENTRYPOINT ["flask"]

# Define o comando padrão
CMD ["run", "--host", "0.0.0.0", "--port", "8000"]