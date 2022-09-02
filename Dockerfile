# Container to build stress
FROM golang:1.17 AS builder

LABEL maintainer="vishnuk@google.com"

WORKDIR /

COPY main.go /.

RUN GOBIN=/ GO111MODULE=off go get   

RUN GOBIN=/ GO111MODULE=off CGO_ENABLED=0 go build --ldflags '-extldflags "-static"' -o stress

# Container to publish
FROM scratch

LABEL maintainer="vishnuk@google.com"

COPY --from=builder  /stress /

ENTRYPOINT ["/stress", "-logtostderr"]

