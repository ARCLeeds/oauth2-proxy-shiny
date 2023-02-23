# adapted from https://docs.streamlit.io/knowledge-base/tutorials/deploy/docker

FROM python:3.9-slim

RUN useradd -ms /bin/bash appuser

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

USER appuser

COPY . /app

WORKDIR /app

RUN pip3 install -r requirements.txt

EXPOSE 8501

ENV PATH "$PATH:/home/appuser/.local/bin"

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "main.py", "--server.port=8501", "--server.address=0.0.0.0"]