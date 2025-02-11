
FROM alpine:latest

RUN apk update
RUN apk add --no-cache gcc musl-dev curl

CMD ["sh", "-c", "cd project && darwin run_blueprint build/ --mode folder build_linux"]
