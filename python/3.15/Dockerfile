# https://hub.docker.com/_/python
FROM python:3.15-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    vim curl wget ca-certificates procps git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www

# contenedor de trabajo: se queda vivo para entrar con make ssh-py315
CMD ["sleep", "infinity"]
