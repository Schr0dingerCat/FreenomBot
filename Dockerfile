
FROM golang:alpine AS build-env
ENV GO11MODULE=on \
    GOPROXY=https://goproxy.cn,direct
RUN mkdir /app
WORKDIR /app/
RUN apk add --update --no-cache ca-certificates git
COPY go.mod .
COPY go.sum .
COPY resources .
RUN go mod download
COPY . .
RUN go build -o app

FROM alpine:latest
#ADD config.toml /root/app/
COPY --from=build-env /app/app /root/app/
#ADD resources/ /root/app/
#COPY 只会复制目录下的内容，不会复制目录本身
COPY --from=build-env /app/resources/ /root/app/resources/

WORKDIR /root/app/

EXPOSE 8080

ENTRYPOINT ["/root/app/app"]