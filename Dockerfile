FROM golang:1.21

WORKDIR /app

COPY /src/wtw ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /wtw

EXPOSE 8080

CMD ["/wtw"]
