# Imagem base com Python e ferramentas de compilação
FROM python:3.11-slim

# Instala dependências do sistema necessárias para dlib e face-recognition
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Cria diretório da aplicação
WORKDIR /app

# Copia todos os arquivos do projeto
COPY . .

# Instala as dependências Python
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expõe a porta usada pela API Flask
EXPOSE 5000

# Comando para iniciar o Flask (ajuste conforme seu app.py)
CMD ["python", "app.py"]
