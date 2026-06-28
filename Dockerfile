# renovate: datasource=docker depName=alpine versioning=docker
ARG ALPINE_VERSION=3.24

FROM alpine:${ALPINE_VERSION}
ARG MISE_VERSION=2026.6.14

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
wget -nv -O /usr/local/bin/mise \
	"https://github.com/jdx/mise/releases/download/v${MISE_VERSION}/mise-v${MISE_VERSION}-linux-x64-musl"
chmod +x /usr/local/bin/mise
EOF

# System-wide mise configuration
COPY <<"EOF" /etc/mise/conf.d/01-bootstrap.toml
[settings]
experimental = true

[bootstrap.packages]
"apk:alpine-zsh-config" = "latest"
"apk:bash" = "latest"
"apk:build-base" = "latest"
"apk:ca-certificates" = "latest"
"apk:curl" = "latest"
"apk:gcompat" = "latest"
"apk:git" = "latest"
"apk:gpg" = "latest"
"apk:gpg-agent" = "latest"
"apk:libc6-compat" = "latest"
"apk:libcap-setcap" = "latest"
"apk:libgcc" = "latest"
"apk:libstdc++" = "latest"
"apk:helix" = "latest"
"apk:openssh-client-default" = "latest"
"apk:sudo" = "latest"
"apk:wget" = "latest"
"apk:zsh" = "latest"
"apk:starship" = "latest"
"apk:ripgrep" = "latest"
"apk:fd" = "latest"
"apk:zoxide" = "latest"
"apk:atuin" = "latest"
"apk:jujutsu" = "latest"
"apk:podman" = "latest"

[bootstrap.mise_shell_activate]
zprofile = "activate"

[tasks.bootstrap]
run = '''
#!/usr/bin/env sh
set -euxo pipefail
export JJUI_VERSION="0.10.6"
wget -nv -O /tmp/jjui.zip \
	"https://github.com/idursun/jjui/releases/download/v${JJUI_VERSION}/jjui-${JJUI_VERSION}-linux-amd64.zip"
unzip -o /tmp/jjui.zip -d /usr/local/bin
mv /usr/local/bin/jjui-${JJUI_VERSION}-linux-amd64 /usr/local/bin/jjui
chmod +x /usr/local/bin/jjui
'''
EOF

# Create/configure non-root user and bootstrap mise
# hadolint ignore=SC2016
RUN <<EOF
mise bootstrap
addgroup -g "$DEVCONTAINER_GID" "$DEVCONTAINER_USERNAME"
adduser -u "$DEVCONTAINER_UID" -G "$DEVCONTAINER_USERNAME" -s /bin/zsh -D "$DEVCONTAINER_USERNAME"
echo "$DEVCONTAINER_USERNAME ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$DEVCONTAINER_USERNAME"
chmod 0440 "/etc/sudoers.d/$DEVCONTAINER_USERNAME"
echo "$DEVCONTAINER_USERNAME:100000:65536" >> /etc/subuid
echo "$DEVCONTAINER_USERNAME:100000:65536" >> /etc/subgid
echo 'eval "$(starship init zsh)"' >> /etc/zsh/zprofile
echo 'eval "$(atuin init zsh)"' >> /etc/zsh/zprofile
echo 'eval "$(zoxide init zsh)"' >> /etc/zsh/zprofile
EOF

WORKDIR /home/${DEVCONTAINER_USERNAME}

USER ${DEVCONTAINER_USERNAME}

HEALTHCHECK NONE

CMD ["/bin/zsh", "--login"]
