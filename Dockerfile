FROM python:3.11-slim

# Instala as dependências de sistema para dlib e face_recognition
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

WORKDIR /app

COPY . .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expõe a porta padrão usada pelo gunicorn
EXPOSE 5000

# Comando para iniciar o app com gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
