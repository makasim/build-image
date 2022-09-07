ARG GO_ALPINE_IMAGE
ARG ALPINE_IMAGE

FROM ${GO_ALPINE_IMAGE} as golang
FROM ${ALPINE_IMAGE}

#golang
COPY --from=golang /usr/local/go/ /usr/local/go/
RUN mkdir -p /go
ENV PATH="/go/bin:/usr/local/go/bin:$PATH"
ENV GOPATH /go
RUN go version

RUN apk update

# GENERIC
RUN apk add --no-cache \
    git \
    curl \
    make \
    bash \
    gzip \
    unzip \
    tar \
    netcat-openbsd \
    postgresql-client

ARG DOCKER_VERSION
RUN apk add --no-cache "docker-cli"

ARG DOCKER_COMPOSE_VERSION
RUN mkdir -p /usr/local/lib/docker/cli-plugins
RUN curl -SL "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/lib/docker/cli-plugins/docker-compose
RUN chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
RUN docker compose version

ARG GOLANGCI_VERSION
RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | \
    sh -s -- -b $GOPATH/bin "${GOLANGCI_VERSION}" \
    && golangci-lint version

ARG STATICCHECK_VERSION
RUN go install "honnef.co/go/tools/cmd/staticcheck@${STATICCHECK_VERSION}"

ARG GOTEST_VERSION
RUN go install  "github.com/rakyll/gotest@${GOTEST_VERSION}"
ENV GOTEST=gotest

RUN go install  "golang.org/x/perf/cmd/benchstat@latest"

ARG DBMATE_VERSION
RUN uname -s
RUN uname -m
RUN curl -fsSL -o /usr/bin/dbmate "https://github.com/amacneil/dbmate/releases/download/${DBMATE_VERSION}/dbmate-linux-amd64" \
    && chmod +x /usr/bin/dbmate \
    && dbmate --version

ARG TASK_VERSION
RUN TAG=$TASK_VERSION sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin \
    && task --version
