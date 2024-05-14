FROM golang:1.21

WORKDIR /app

COPY /src/wtw ./

EXPOSE 8080

CMD ["/wtw"]
