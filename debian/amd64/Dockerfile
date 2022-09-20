ARG DEBIAN_IMAGE
ARG GO_DEBIAN_IMAGE

FROM ${GO_DEBIAN_IMAGE} as golang
FROM ${DEBIAN_IMAGE}

#golang
COPY --from=golang /usr/local/go/ /usr/local/go/
RUN mkdir -p /go
ENV PATH="/go/bin:/usr/local/go/bin:$PATH"
ENV GOPATH /go
RUN go version
RUN echo $PATH

RUN apt-get update

# GENERIC
RUN apt-get install -y --no-install-recommends --no-install-suggests \
    git \
    curl \
    make \
    bash \
    gzip \
    unzip \
    tar \
    netcat-openbsd \
    postgresql-client \
    gcc libc6-dev g++

ARG DOCKER_VERSION
RUN apt-get install -y --no-install-recommends --no-install-suggests \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

RUN mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update 
RUN apt-get install -y --no-install-recommends --no-install-suggests \
        docker-ce-cli # docker-ce  containerd.io 

ARG DOCKER_COMPOSE_VERSION
RUN mkdir -p /usr/local/lib/docker/cli-plugins
RUN curl -SL "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/lib/docker/cli-plugins/docker-compose
RUN chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
RUN docker compose version

ARG GOVULNCHECKV
RUN go install "golang.org/x/vuln/cmd/govulncheck@${GOVULNCHECKV}"

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
RUN curl -fsSL -o /usr/bin/dbmate "https://github.com/amacneil/dbmate/releases/download/${DBMATE_VERSION}/dbmate-linux-amd64" \
    && chmod +x /usr/bin/dbmate \
    && dbmate --version

ARG TASK_VERSION
RUN TAG=$TASK_VERSION sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin \
    && task --version

ARG REFLEX_VERSION
RUN go install "github.com/cespare/reflex@${REFLEX_VERSION}"
