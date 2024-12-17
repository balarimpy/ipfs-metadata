FROM golang:1.19 as builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download


COPY . .

RUN go build -o app .

# Stage 2: Create a minimal runtime environment
FROM gcr.io/distroless/base-debian11

WORKDIR /

COPY --from=builder /app/app /app
COPY --from=builder /app/.env /.env

EXPOSE 8080

CMD ["/app"]
