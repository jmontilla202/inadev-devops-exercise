FROM golang:1.21

WORKDIR /app

COPY /src/* ./

EXPOSE 8080

CMD ["/wapi"]
