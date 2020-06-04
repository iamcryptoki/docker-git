FROM alpine
LABEL maintainer "Gael Gentil <iamcryptoki@gmail.com>"

# Install Alpine packages.
RUN apk add --no-cache git openssh tzdata

# Default timezone configuration.
ENV TZ Europe/Paris
RUN cp /usr/share/zoneinfo/${TZ} /etc/localtime

# Create new non-root user.
ENV UID 2000
ENV GID 2000
RUN addgroup -S cryptoki --gid ${GID} && \
    adduser -S cryptoki --uid ${UID} -G cryptoki --home /git

# Switch to non-root user.
USER cryptoki

VOLUME /git
WORKDIR /git

ENTRYPOINT ["git"]
CMD ["--help"]