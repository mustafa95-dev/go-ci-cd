# Build stage
FROM golang:1.21.1-alpine3.18 AS builder

WORKDIR /app

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags='-s' -o main ./main.go

# Run stage
FROM alpine:3.18

WORKDIR /app

COPY --from=builder /app/main .

# COPY .env .

CMD [ "/app/main" ]
