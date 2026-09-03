# renovate: datasource=docker depName=ubuntu versioning=docker
ARG UBUNTU_VERSION=resolute
# renovate: datasource=github-releases depName=jdx/mise
ARG MISE_VERSION=2026.9.1
# renovate: datasource=github-releases depName=helix-editor/helix versioning=calendar
ARG HELIX_VERSION=25.07.1
# renovate: datasource=github-releases depName=starship/starship
ARG STARSHIP_VERSION=1.26.0
# renovate: datasource=github-releases depName=ajeetdsouza/zoxide
ARG ZOXIDE_VERSION=0.10.0
# renovate: datasource=github-releases depName=atuinsh/atuin
ARG ATUIN_VERSION=18.21.0
# renovate: datasource=github-releases depName=jj-vcs/jj
ARG JUJUTSU_VERSION=0.45.1
# renovate: datasource=github-releases depName=idursun/jjui
ARG JJUI_VERSION=0.10.8
# renovate: datasource=github-releases depName=BurntSushi/ripgrep
ARG RIPGREP_VERSION=15.2.0
# renovate: datasource=github-releases depName=sharkdp/fd
ARG FD_VERSION=10.4.2
# renovate: datasource=github-releases depName=eza-community/eza
ARG EZA_VERSION=0.23.5
# renovate: datasource=github-releases depName=umlx5h/gtrash
ARG GTRASH_VERSION=0.0.6
# renovate: datasource=github-releases depName=sharkdp/bat
ARG BAT_VERSION=0.26.1

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
ARG EZA_VERSION
ARG GTRASH_VERSION
ARG BAT_VERSION

COPY --chmod=0644 99_apt_no_recommends /etc/apt/apt.conf.d/99_apt_no_recommends

# checkov:skip=CKV2_DOCKER_1: sudo is installed as a package for the passwordless-sudo dev user, not invoked
# hadolint ignore=DL3008
RUN <<EOF
apt-get update
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
    neovim \
    fzf \
    zsh \
    ssh \
    passwd \
    unzip
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
rm -rf /var/lib/apt/lists/*
EOF

# hadolint ignore=DL3064
ENV DEVCONTAINER_USERNAME=devcontaineruser \
    DEVCONTAINER_UID=1000 \
    DEVCONTAINER_GID=1000 \
    LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    STARSHIP_CONFIG=/etc/starship.toml

SHELL ["/bin/bash", "-eux", "-o", "pipefail", "-c"]

# Install binary without apt
# hadolint ignore=SC1127
RUN <<EOF
# Install tools not available in Ubuntu repos
# editorconfig-checker-disable
wget -qO- "https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-x86_64-linux.tar.xz" | tar xJf - -C /usr/local/bin --strip-components=1 --wildcards "*/hx"
wget -qO- "https://github.com/starship/starship/releases/download/v${STARSHIP_VERSION}/starship-x86_64-unknown-linux-gnu.tar.gz" | tar xzf - -C /usr/local/bin
wget -qO- "https://github.com/ajeetdsouza/zoxide/releases/download/v${ZOXIDE_VERSION}/zoxide-${ZOXIDE_VERSION}-x86_64-unknown-linux-musl.tar.gz" | tar xzf - -C /usr/local/bin
wget -qO- "https://github.com/atuinsh/atuin/releases/download/v${ATUIN_VERSION}/atuin-x86_64-unknown-linux-musl.tar.gz" | tar xzf - --strip-components=1 -C /usr/local/bin
wget -qO- "https://github.com/jj-vcs/jj/releases/download/v${JUJUTSU_VERSION}/jj-v${JUJUTSU_VERSION}-x86_64-unknown-linux-musl.tar.gz" | tar xzf - --strip-components=1 -C /usr/local/bin
wget -qO- "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl.tar.gz" | tar xzf - --strip-components=1 -C /usr/local/bin
wget -qO- "https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-x86_64-unknown-linux-musl.tar.gz" | tar xzf - --strip-components=1 -C /usr/local/bin --wildcards "*/fd"
wget -qO- "https://github.com/eza-community/eza/releases/download/v${EZA_VERSION}/eza_x86_64-unknown-linux-gnu.tar.gz" | tar xzf - -C /usr/local/bin
wget -qO- "https://github.com/umlx5h/gtrash/releases/download/v${GTRASH_VERSION}/gtrash_Linux_x86_64.tar.gz" | tar xzf - -C /usr/local/bin
wget -qO- "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz" | tar xzf - -C /usr/local/bin --strip-components=1 --wildcards "*/bat"

wget -nv -O /usr/local/bin/mise "https://github.com/jdx/mise/releases/download/v${MISE_VERSION}/mise-v${MISE_VERSION}-linux-x64"
chmod +x /usr/local/bin/mise

wget -nv -O /tmp/jjui.zip "https://github.com/idursun/jjui/releases/download/v${JJUI_VERSION}/jjui-${JJUI_VERSION}-linux-amd64.zip"
unzip -o /tmp/jjui.zip -d /usr/local/bin
chmod +x /usr/local/bin/jjui-${JJUI_VERSION}-linux-amd64
mv /usr/local/bin/jjui-${JJUI_VERSION}-linux-amd64 /usr/local/bin/jjui
rm -f /tmp/jjui.zip
# editorconfig-checker-enable

# Install zsh plugins
mkdir -p /usr/local/share/zsh/plugins
git clone --depth 1 https://github.com/Aloxaf/fzf-tab.git /usr/local/share/zsh/plugins/fzf-tab
git clone --depth 1 https://github.com/zsh-users/zsh-completions.git /usr/local/share/zsh/plugins/zsh-completions
git clone --depth 1 https://github.com/le0me55i/zsh-extract.git /usr/local/share/zsh/plugins/zsh-extract
mkdir -p /etc/mise/conf.d
EOF

COPY --chmod=644 starship.toml /etc/starship.toml

# Create/configure non-root user and bootstrap mise
# hadolint ignore=SC2016
RUN <<EOF
# Ubuntu noble ships with a built-in 'ubuntu' user/group at UID/GID 1000;
# rename them instead of creating new ones to avoid GID/UID collision.
groupmod -n "${DEVCONTAINER_USERNAME}" ubuntu
usermod -l "${DEVCONTAINER_USERNAME}" -d "/home/${DEVCONTAINER_USERNAME}" -m -s /bin/zsh ubuntu
echo "${DEVCONTAINER_USERNAME} ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${DEVCONTAINER_USERNAME}"
chmod 0440 "/etc/sudoers.d/${DEVCONTAINER_USERNAME}"
sed -i 's/^ubuntu:/'"${DEVCONTAINER_USERNAME}"':/g' /etc/subuid /etc/subgid

touch "/root/.zshrc"
touch "/home/${DEVCONTAINER_USERNAME}/.zshrc"
EOF

COPY --chmod=644 zshrc /etc/zsh/zshrc

WORKDIR /home/${DEVCONTAINER_USERNAME}

# hadolint ignore=DL3066
USER ${DEVCONTAINER_USERNAME}

# editorconfig-checker-disable
# hadolint ignore=SC2155
ONBUILD RUN --mount=type=secret,id=MISE_GITHUB_TOKEN \
    --mount=type=bind,source=.,target=/workspaces/project \
    export MISE_GITHUB_TOKEN="$(cat /run/secrets/MISE_GITHUB_TOKEN)" && \
    export MISE_TRUSTED_CONFIG_PATHS="/workspaces/project" && \
    cd /workspaces/project && \
    eval "$(mise env --shell zsh)" && \
    mise bootstrap -y --skip tools
# editorconfig-checker-enable

HEALTHCHECK NONE

CMD ["/bin/zsh"]
