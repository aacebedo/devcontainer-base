# renovate: datasource=docker depName=alpine versioning=docker
ARG ALPINE_VERSION=3.23

FROM alpine:${ALPINE_VERSION} AS builder

# renovate: datasource=github-releases depName=jdx/mise extractVersion=^v(?<version>.*)$
ARG MISE_VERSION=2026.1.5

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

ENV DEVCONTAINER_USERNAME=devcontaineruser \
		DEVCONTAINER_UID=1000 \
		DEVCONTAINER_GID=1000 \
		MISE_ALL_COMPILE=false \
		MISE_EXPERIMENTAL=1

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
			gcompat \
			sudo \
			zsh \
			git \
			gpg-agent \
			gpg \
			ca-certificates \
		&& update-ca-certificates

COPY --from=builder --chmod=0755 /tmp/mise /usr/local/bin/mise

# Create/configure non-root user
# hadolint ignore=SC2016
RUN addgroup -g "$DEVCONTAINER_GID" "$DEVCONTAINER_USERNAME" && \
		adduser -u "$DEVCONTAINER_UID" -G "$DEVCONTAINER_USERNAME" -s /bin/zsh -D "$DEVCONTAINER_USERNAME" && \
		echo "$DEVCONTAINER_USERNAME ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$DEVCONTAINER_USERNAME" && \
		chmod 0440 "/etc/sudoers.d/$DEVCONTAINER_USERNAME" && \
		echo "$DEVCONTAINER_USERNAME:100000:65536" >> /etc/subuid && \
		echo "$DEVCONTAINER_USERNAME:100000:65536" >> /etc/subgid && \
		echo 'eval "$(mise activate zsh)"' >> /etc/zsh/zprofile

WORKDIR /home/${DEVCONTAINER_USERNAME}

USER ${DEVCONTAINER_USERNAME}

SHELL ["/bin/zsh"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
CMD [ "sh", "-c", "command -v zsh" ]
