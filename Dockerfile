ARG ALPINE_VERSION=3.23

FROM alpine:${ALPINE_VERSION} AS builder

# renovate: datasource=github-releases depName=jdx/mise extractVersion=^v(?<version>.*)$
ARG MISE_VERSION=2025.12.13

# Install base packages (including runtime environments)
# hadolint ignore=DL3018
RUN apk update && \
		apk add --no-cache \
		wget

# Install mise
RUN wget --progress=dot:giga -O /tmp/mise \
		# editorconfig-checker-disable-next-line
		"https://github.com/jdx/mise/releases/download/v${MISE_VERSION}/mise-v${MISE_VERSION}-linux-x64-musl"

FROM alpine:${ALPINE_VERSION} AS final

# renovate: datasource=github-releases depName=jdx/mise extractVersion=^v(?<version>.*)$
ARG MISE_VERSION=2025.12.13
# renovate: datasource=github-releases depName=golang/go extractVersion=^go(?<version>.*)$
ARG GO_VERSION=1.23.2
# renovate: datasource=github-tags depName=astral-sh/uv extractVersion=^(?<version>.*)$
ARG UV_VERSION=0.9.21
# renovate: datasource=node-version
ARG NODE_VERSION=25.2.1

ENV DEVCONTAINER_USER=devcontaineruser \
		DEVCONTAINER_UID=1000 \
		DEVCONTAINER_GID=1000 \
		MISE_ALL_COMPILE=false

# Install base packages (including runtime environments)
# hadolint ignore=DL3018
RUN apk update && \
		apk upgrade && \
		apk add --no-cache \
		bash \
		build-base \
		libc6-compat \
		libcap-setcap \
		libgcc \
		libstdc++ \
		sudo \
		zsh \
		python3 \
		gpg-agent \
		gpg \
		zsh \
		gcompat \
		ca-certificates \
		&& update-ca-certificates

COPY --from=builder --chmod=0755 /tmp/mise /usr/local/bin/mise

# Create/configure non-root user
# hadolint ignore=SC2016
RUN addgroup -g "$DEVCONTAINER_GID" "$DEVCONTAINER_USER" && \
		adduser -u "$DEVCONTAINER_UID" -G "$DEVCONTAINER_USER" -s /bin/zsh -D "$DEVCONTAINER_USER" && \
		echo "$DEVCONTAINER_USER ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$DEVCONTAINER_USER" && \
		chmod 0440 "/etc/sudoers.d/$DEVCONTAINER_USER" && \
		echo "$DEVCONTAINER_USER:100000:65536" >> /etc/subuid && \
		echo "$DEVCONTAINER_USER:100000:65536" >> /etc/subgid && \
		echo 'eval "$(mise activate zsh)"' >> /etc/zsh/zprofile && \
		install -D -m 0666 /dev/null /etc/mise/config.toml

WORKDIR /home/${DEVCONTAINER_USERNAME}

USER ${DEVCONTAINER_USERNAME}

RUN MISE_NODE_MIRROR_URL="https://unofficial-builds.nodejs.org/download/release/" \
		MISE_NODE_FLAVOR="musl" \
		MISE_GLOBAL_CONFIG_FILE=/etc/mise/config.toml \
		mise use -g \
			node@${NODE_VERSION} \
			uv@${UV_VERSION} \
			go@${GO_VERSION}

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
CMD [ "sh", "-c", "command -v zsh" ]
