FROM golang:latest

ENV DOMAIN="l.ab"
ENV ROOT_CN="Homelab"

COPY ./scripts /scripts

WORKDIR /app
# Clone minica
# RUN git clone https://github.com/jsha/minica.git
# Build from local source
COPY ./minica minica

# Build the Go executable
WORKDIR /app/minica
RUN go build

# Create cert folder (volume)
WORKDIR /app/certs

CMD ["sh", "-c", "/scripts/entrypoint.sh"]