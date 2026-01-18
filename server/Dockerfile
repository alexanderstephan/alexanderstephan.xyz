FROM golang:1.25-alpine as build-env
WORKDIR /app
COPY . ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -tags netgo -ldflags '-w -extldflags "-static"' -o site ./main.go

FROM scratch
WORKDIR /app
COPY --from=build-env /app/site .
EXPOSE 80
CMD ["./site"]
