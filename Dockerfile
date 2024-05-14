FROM golang:1.21

WORKDIR /app

COPY go.mod go.sum ./

RUN cd wtw/src && \
    go get github.com/gin-gonic/gin
    
COPY src/*.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /wtw

EXPOSE 8080

CMD ["/wtw"]
