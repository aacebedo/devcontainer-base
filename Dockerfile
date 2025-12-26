ARG ALPINE_VERSION=3.22

FROM alpine:${ALPINE_VERSION} AS builder

# renovate: datasource=github-releases depName=jdx/mise extractVersion=^v(?<version>.*)$
ARG MISE_VERSION=2025.12.12

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

ARG USERNAME=devcontaineruser
ARG USERUID=1000
ARG USERGID=1000

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
		zsh

COPY --from=builder --chmod=0755 /tmp/mise /usr/local/bin/mise

# Create/configure non-root user
# hadolint ignore=SC2016
RUN addgroup -g "$USERGID" "$USERNAME" && \
		adduser -u "$USERUID" -G "$USERNAME" -s /bin/zsh -D "$USERNAME" && \
		echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$USERNAME" && \
		chmod 0440 "/etc/sudoers.d/$USERNAME" && \
		echo "$USERNAME:100000:65536" >> /etc/subuid && \
		echo "$USERNAME:100000:65536" >> /etc/subgid && \
		echo 'eval "$(mise activate zsh)"' >> /etc/zsh/zprofile

WORKDIR /home/${USERNAME}

USER ${USERNAME}

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
CMD [ "sh", "-c", "command -v sh" ]
