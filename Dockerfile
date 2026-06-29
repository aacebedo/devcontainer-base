# renovate: datasource=docker depName=alpine versioning=docker
ARG ALPINE_VERSION=3.24
ARG MISE_VERSION=2026.6.14
ARG JJUI_VERSION=0.10.6

FROM alpine:${ALPINE_VERSION}
ARG MISE_VERSION
ARG JJUI_VERSION

ENV DEVCONTAINER_USERNAME=devcontaineruser \
		DEVCONTAINER_UID=1000 \
		DEVCONTAINER_GID=1000 \
		MISE_ALL_COMPILE=false \
		MISE_LIBC=musl \
		LANG="en_US.UTF-8" \
		LC_ALL="en_US.UTF-8"

SHELL ["/bin/sh", "-euxo", "pipefail", "-c"]

# Install mise
RUN <<EOF
# editorconfig-checker-disable-next-line
wget -nv -O /usr/local/bin/mise "https://github.com/jdx/mise/releases/download/v${MISE_VERSION}/mise-v${MISE_VERSION}-linux-x64-musl"
chmod +x /usr/local/bin/mise
EOF

# Install base packages
# checkov:skip=CKV2_DOCKER_1: sudo is installed as a package for the passwordless-sudo dev user, not invoked
# hadolint ignore=DL3018
RUN <<EOF
apk update && \
apk add --no-cache \
	bash \
	ca-certificates \
	git \
	gpg \
	gpg-agent \
	helix \
	sudo \
	wget \
	alpine-zsh-config \
	zsh \
	starship \
	ripgrep \
	fd \
	zoxide \
	atuin \
	jujutsu

# editorconfig-checker-disable-next-line
wget -nv -O /tmp/jjui.zip "https://github.com/idursun/jjui/releases/download/v${JJUI_VERSION}/jjui-${JJUI_VERSION}-linux-amd64.zip"
unzip -o /tmp/jjui.zip -d /usr/local/bin
rm -f /tmp/jjui.zip
chmod +x /usr/local/bin/jjui-${JJUI_VERSION}-linux-amd64
mv /usr/local/bin/jjui-${JJUI_VERSION}-linux-amd64 /usr/local/bin/jjui
EOF

# Create/configure non-root user and bootstrap mise
# hadolint ignore=SC2016
RUN <<EOF
addgroup -g "$DEVCONTAINER_GID" "$DEVCONTAINER_USERNAME"
adduser -u "$DEVCONTAINER_UID" -G "$DEVCONTAINER_USERNAME" -s /bin/zsh -D "$DEVCONTAINER_USERNAME"
echo "$DEVCONTAINER_USERNAME ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$DEVCONTAINER_USERNAME"
chmod 0440 "/etc/sudoers.d/$DEVCONTAINER_USERNAME"
echo "$DEVCONTAINER_USERNAME:100000:65536" >> /etc/subuid
echo "$DEVCONTAINER_USERNAME:100000:65536" >> /etc/subgid
echo 'eval "$(mise activate zsh)"' >> /etc/zsh/zshrc
echo 'eval "$(starship init zsh)"' >> /etc/zsh/zshrc
echo 'eval "$(atuin init zsh)"' >> /etc/zsh/zshrc
echo 'eval "$(zoxide init zsh)"' >> /etc/zsh/zshrc
EOF

WORKDIR /home/${DEVCONTAINER_USERNAME}

USER ${DEVCONTAINER_USERNAME}

# hadolint ignore=SC2155
ONBUILD RUN --mount=type=secret,id=MISE_GITHUB_TOKEN,uid=${DEVCONTAINER_UID} \
						# editorconfig-checker-disable-next-line
						--mount=type=bind,from=workspace,source=.mise/config.toml,target="/home/${DEVCONTAINER_USERNAME}/.config/mise/config.toml" \
						export MISE_GITHUB_TOKEN="$(cat /run/secrets/MISE_GITHUB_TOKEN)" && \
						export MISE_TRUSTED_CONFIG_PATHS="/home/${DEVCONTAINER_USERNAME}/.config/mise" && \
						mise bootstrap

HEALTHCHECK NONE

CMD ["/bin/zsh"]
