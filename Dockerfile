FROM golang:1.21

WORKDIR /app

COPY src/wapi /app

EXPOSE 8080

CMD ["/app/wapi"]
