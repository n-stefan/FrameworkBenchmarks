FROM golang:1.12

ENV GO111MODULE on
WORKDIR /go-std

COPY ./src /go-std

RUN go get github.com/valyala/quicktemplate/qtc
RUN go get -u github.com/mailru/easyjson/...
RUN go mod download

RUN go generate ./templates
RUN easyjson -pkg
RUN go build -ldflags="-s -w" -o app .

CMD ./app -db mgo -prefork -db_connection_string "tfb-database"
