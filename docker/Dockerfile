ARG REG
FROM ${REG}/golang:alpine AS builder

# Set necessary environmet variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

ENV SRC_LOC="https://raw.githubusercontent.com/tsuyo/jfrog-showcase/main/go"

# Move to working directory /build
WORKDIR /build

# Download sources
RUN \
  wget -q ${SRC_LOC}/main.go && \
  wget -q ${SRC_LOC}/go.mod && \
  wget -q ${SRC_LOC}/go.sum

# Download dependency using go mod
RUN go mod download

# Build the application
RUN go build -o main .

# Move to /dist directory as the place for resulting binary folder
WORKDIR /dist

# Copy binary from build to main folder
RUN cp /build/main .

# Build a small image
FROM scratch

COPY --from=builder /dist/main /

# Command to run
ENTRYPOINT ["/main"]