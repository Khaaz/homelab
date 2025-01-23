FROM golang:latest

ENV DOMAIN="l.ab"

# Clone minica
WORKDIR /app
RUN git clone https://github.com/jsha/minica.git

# Build the Go executable
WORKDIR /app/minica
RUN go build

# Create cert folder (volume)
WORKDIR /app/certs

CMD ["sh", "-c", "/app/minica/minica -ca-key root.key -ca-cert root.crt --domains $DOMAIN,*.$DOMAIN"]