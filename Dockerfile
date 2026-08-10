# renovate: datasource=docker depName=ubuntu versioning=docker
ARG UBUNTU_VERSION=resolute
# renovate: datasource=github-releases depName=jdx/mise
ARG MISE_VERSION=2026.8.0
# renovate: datasource=github-releases depName=helix-editor/helix versioning=calendar
ARG HELIX_VERSION=25.07.1
# renovate: datasource=github-releases depName=starship/starship
ARG STARSHIP_VERSION=1.26.0
# renovate: datasource=github-releases depName=ajeetdsouza/zoxide
ARG ZOXIDE_VERSION=0.10.0
# renovate: datasource=github-releases depName=atuinsh/atuin
ARG ATUIN_VERSION=18.19.0
# renovate: datasource=github-releases depName=jj-vcs/jj
ARG JUJUTSU_VERSION=0.44.0
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

# Install base packages and generate locale before switching shell or setting LC_ALL,
# so bash never starts with a locale env var that points to non-existent locale files.
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
EOF

RUN <<'EOF'
mkdir -p /etc/mise/conf.d
cat > /etc/mise/conf.d/001_common_config.toml <<'TOML'
[hooks]
cd = [
    "/usr/local/bin/mise-check-bootstrap",
    "/usr/local/bin/mise-check-install",
]
TOML

cat > /usr/local/bin/mise-check-bootstrap <<'SH'
#!/usr/bin/env bash
set -euo pipefail

[ -z "${MISE_PROJECT_ROOT:-}" ] && exit 0
[ "${MISE_SILENCE_STATUS_CHECKS:-0}" = "1" ] && exit 0

if ! mise bootstrap status --missing >/dev/null 2>&1; then
  printf '\033[33m[mise] Bootstrap not complete. Run: mise bootstrap\033[0m\n' >&2
fi
SH

cat > /usr/local/bin/mise-check-install <<'SH'
#!/usr/bin/env bash
set -euo pipefail

[ -z "${MISE_PROJECT_ROOT:-}" ] && exit 0
[ "${MISE_SILENCE_STATUS_CHECKS:-0}" = "1" ] && exit 0

if ! mise install --dry-run-code >/dev/null 2>&1; then
  printf '\033[33m[mise] Some tools not installed. Run: mise install\033[0m\n' >&2
fi
SH

chmod 0755 /usr/local/bin/mise-check-bootstrap /usr/local/bin/mise-check-install
EOF

COPY <<"EOF" /etc/starship.toml
add_newline = false
command_timeout = 5000
# editorconfig-checker-disable
format = """
[ $os$hostname ](bg:014 fg:235 bold)[ $username ](bg:239 fg:254 bold)[ $directory ](bg:blue fg:black bold)$fill(([ $git_branch ($git_commit )](bg:yellow fg:240 bold))[( $git_status )($git_metrics )](bg:239 bold))([ $nix_shell ](bold bg:032))([ $python ](bold bg:029))[](fg:239)[ $time](bg:239 fg:254 bold)
$character"""
# editorconfig-checker-enable

[directory]
fish_style_pwd_dir_length = 3
format = "󰉋 $path"
home_symbol = "󰋜 ~"
truncation_length = 3
truncation_symbol = "…/"

[fill]
style = "fg:240"
symbol = "-"

[git_branch]
format = "($symbol $branch)"
symbol = ""

[git_commit]
format = '(\($hash$tag\))'
only_detached = false
tag_disabled = false

[git_metrics]
added_style = "fg:green bg:239 bold"
deleted_style = "fg:red bg:239 bold"
disabled = false
format = "([[+$added]($added_style) [-$deleted]($deleted_style)](bg:239 bold))"
ignore_submodules = true

[git_status]
format = '(\[$all_status$ahead_behind\])'
ignore_submodules = true

[hostname]
format = "($ssh_symbol$hostname)"
ssh_only = false

[os]
disabled = false
format = "$symbol"

[os.symbols]
Ubuntu = " "

[python]
detect_extensions = []
detect_files = []
format = "$symbol$virtualenv $version"
symbol = "󰌠 "

[time]
disabled = false
format = " $time "
style = "bg:239 fg:254"
time_format = "%R"

[username]
format = "( $user)"
show_always = true
EOF

# Create/configure non-root user and bootstrap mise
# hadolint ignore=SC2016
RUN <<EOF
# Ubuntu noble ships with a built-in 'ubuntu' user/group at UID/GID 1000;
# rename them instead of creating new ones to avoid GID/UID collision.
groupmod -n "${DEVCONTAINER_USERNAME}" ubuntu
usermod -l "${DEVCONTAINER_USERNAME}" -d "/home/${DEVCONTAINER_USERNAME}" -m -s /bin/zsh ubuntu
echo "${DEVCONTAINER_USERNAME} ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${DEVCONTAINER_USERNAME}"
chmod 0440 "/etc/sudoers.d/${DEVCONTAINER_USERNAME}"
echo "${DEVCONTAINER_USERNAME}:100000:65536" >> /etc/subuid
echo "${DEVCONTAINER_USERNAME}:100000:65536" >> /etc/subgid

touch "/root/.zshrc"

cat >> /etc/zsh/zshrc <<'ZSHRC'
source /usr/local/share/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
source <(fzf --zsh)
eval "$(mise activate zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
source /usr/local/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
source /usr/local/share/zsh/plugins/zsh-extract/extract.plugin.zsh

alias -- eza='eza --icons auto --git'
alias -- cat='bat'
alias -- ls='eza'
alias -- less='eza'
alias -- j='jj'
alias -- jbc='jj b create'
alias -- jbm='jj b move'
alias -- jd='jj describe'
alias -- je='jj edit'
alias -- jf='jj git fetch'
alias -- jl='jj log -r ::'
alias -- jp='jj git push'
alias -- jr='jj rebase'
alias -- js='jj split'
alias -- la='eza -a'
alias -- ll='eza -l'
alias -- lla='eza -la'
alias -- ls=eza
alias -- lt='eza --tree'
alias -- lzt=lazygit
alias -- rm='gtrash put --home-fallback'

bindkey '^[[1;5D' backward-word    # Ctrl+Left
bindkey '^[[1;5C' forward-word     # Ctrl+Right
ZSHRC

touch "/home/${DEVCONTAINER_USERNAME}/.zshrc"
EOF

WORKDIR /home/${DEVCONTAINER_USERNAME}

# hadolint ignore=DL3066
USER ${DEVCONTAINER_USERNAME}

# editorconfig-checker-disable
# hadolint ignore=SC2155
ONBUILD RUN --mount=type=secret,id=MISE_GITHUB_TOKEN,uid=${DEVCONTAINER_UID} \
    --mount=type=bind,source=.,target=/workspace \
    export MISE_GITHUB_TOKEN="$(cat /run/secrets/MISE_GITHUB_TOKEN)" && \
    export MISE_TRUSTED_CONFIG_PATHS="/workspace" && \
    cd /workspace && \
    mise bootstrap
# editorconfig-checker-enable

HEALTHCHECK NONE

CMD ["/bin/zsh"]
