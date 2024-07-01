FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN env GOOS=linux CGO_ENABLED=0 go build -o webapp ./...

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/webapp .

EXPOSE 9900

CMD ["./webapp"]
