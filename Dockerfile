# add " as base " 
FROM golang:1.17.5-alpine3.14 as base
LABEL broken_env="true"
WORKDIR /app

COPY pre.sh post.sh .
RUN ./pre.sh
RUN go mod download
RUN CGO_ENABLED=0 go build \
    -ldflags "-s -w" \
    -o /out/web ./main.go
RUN ./post.sh

FROM gcr.io/distroless/static:latest
WORKDIR /app
COPY --from=base /out/web .
CMD [ "/app/web" ]