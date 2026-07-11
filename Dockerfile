# renovate: datasource=docker depName=ubuntu versioning=docker
ARG UBUNTU_VERSION=resolute
# renovate: datasource=github-releases depName=jdx/mise
ARG MISE_VERSION=2026.7.0
# renovate: datasource=github-releases depName=helix-editor/helix versioning=calendar
ARG HELIX_VERSION=25.07.1
# renovate: datasource=github-releases depName=starship/starship
ARG STARSHIP_VERSION=1.26.0
# renovate: datasource=github-releases depName=ajeetdsouza/zoxide
ARG ZOXIDE_VERSION=0.10.0
# renovate: datasource=github-releases depName=atuinsh/atuin
ARG ATUIN_VERSION=18.17.0
# renovate: datasource=github-releases depName=jj-vcs/jj
ARG JUJUTSU_VERSION=0.43.0
# renovate: datasource=github-releases depName=idursun/jjui
ARG JJUI_VERSION=0.10.8
# renovate: datasource=github-releases depName=BurntSushi/ripgrep
ARG RIPGREP_VERSION=15.1.0
# renovate: datasource=github-releases depName=sharkdp/fd
ARG FD_VERSION=10.4.2

FROM ubuntu:${UBUNTU_VERSION}
ARG MISE_VERSION
ARG HELIX_VERSION
ARG STARSHIP_VERSION
ARG ZOXIDE_VERSION
ARG ATUIN_VERSION
ARG JUJUTSU_VERSION
ARG JJUI_VERSION
ARG RIPGREP_VERSION
ARG FD_VERSION

# Install base packages and generate locale before switching shell or setting LC_ALL,
# so bash never starts with a locale env var that points to non-existent locale files.
# checkov:skip=CKV2_DOCKER_1: sudo is installed as a package for the passwordless-sudo dev user, not invoked
# hadolint ignore=DL3008
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		bash \
		ca-certificates \
		git \
		gpg \
		gpg-agent \
		locales \
		sudo \
		wget \
		xz-utils \
		zsh \
		unzip && \
	locale-gen en_US.UTF-8 && \
	update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 && \
	rm -rf /var/lib/apt/lists/*

ENV DEVCONTAINER_USERNAME=devcontaineruser \
			DEVCONTAINER_UID=1000 \
			DEVCONTAINER_GID=1000 \
			MISE_ALL_COMPILE=false \
			MISE_LIBC=glibc \
			LANG="en_US.UTF-8" \
			LC_ALL="en_US.UTF-8"

SHELL ["/bin/bash", "-eux", "-o", "pipefail", "-c"]

# Install binary without apt
# hadolint ignore=SC1127
RUN <<EOF
# Install tools not available in Ubuntu repos
# editorconfig-checker-disable
wget -qO- "https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-x86_64-linux.tar.xz" | tar xJf - -C /usr/local --strip-components=1
wget -qO- https://github.com/starship/starship/releases/download/v${STARSHIP_VERSION}/starship-x86_64-unknown-linux-gnu.tar.gz | tar xzf - -C /usr/local/bin
wget -qO- "https://github.com/ajeetdsouza/zoxide/releases/download/v${ZOXIDE_VERSION}/zoxide-${ZOXIDE_VERSION}-x86_64-unknown-linux-musl.tar.gz" | tar xzf - -C /usr/local/bin
wget -qO- https://github.com/atuinsh/atuin/releases/download/v${ATUIN_VERSION}/atuin-x86_64-unknown-linux-musl.tar.gz | tar xzf - --strip-components=1 -C /usr/local/bin
wget -qO- "https://github.com/jj-vcs/jj/releases/download/v${JUJUTSU_VERSION}/jj-v${JUJUTSU_VERSION}-x86_64-unknown-linux-musl.tar.gz" | tar xzf - --strip-components=1 -C /usr/local/bin
wget -qO- "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl.tar.gz" | tar xzf - --strip-components=1 -C /usr/local/bin
wget -qO- "https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-x86_64-unknown-linux-musl.tar.gz" | tar xzf - --strip-components=1 -C /usr/local/bin
wget -nv -O /tmp/jjui.zip "https://github.com/idursun/jjui/releases/download/v${JJUI_VERSION}/jjui-${JJUI_VERSION}-linux-amd64.zip"
# editorconfig-checker-enable
unzip -o /tmp/jjui.zip -d /usr/local/bin
rm -f /tmp/jjui.zip
chmod +x /usr/local/bin/jjui-${JJUI_VERSION}-linux-amd64
mv /usr/local/bin/jjui-${JJUI_VERSION}-linux-amd64 /usr/local/bin/jjui

wget -nv -O /usr/local/bin/mise \
	"https://github.com/jdx/mise/releases/download/v${MISE_VERSION}/mise-v${MISE_VERSION}-linux-x64"
chmod +x /usr/local/bin/mise
EOF

# Create/configure non-root user and bootstrap mise
# hadolint ignore=SC2016
RUN <<EOF
# Ubuntu noble ships with a built-in 'ubuntu' user/group at UID/GID 1000;
# rename them instead of creating new ones to avoid GID/UID collision.
groupmod -n "$DEVCONTAINER_USERNAME" ubuntu
usermod -l "$DEVCONTAINER_USERNAME" -d "/home/$DEVCONTAINER_USERNAME" -m -s /bin/zsh ubuntu
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
