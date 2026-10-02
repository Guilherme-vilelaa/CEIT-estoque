FROM python:3.11-slim

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN python -m pip install --upgrade pip

COPY requirements.txt .

RUN python -m pip install \
    --no-cache-dir \
    --default-timeout=120 \
    --retries=10 \
    -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
