# editorconfig-checker-disable

[private]
repo_name := shell('git ls-remote --get-url origin | sed -E "s/.*[:\\/]([^\\/]+)\\/([^\\/]+)(\\.git)?$/\\2/" | sed "s/\\.git$//"')
[private]
repo_owner := shell('git ls-remote --get-url origin | sed -E "s/.*[:\\/]([^\\/]+)\\/([^\\/]+)(\\.git)?$/\\1/"')

# editorconfig-checker-enable

[private]
docker_tag := "ghcr.io/" + repo_owner + "/" + repo_name + ":latest"
[private]
repo_url := "https://github.com/" + repo_owner + "/" + repo_name

default:
    just --list

lint:
    pre-commit run --all-files

build:
    podman build -t {{ docker_tag }} \
    --label "org.opencontainers.image.source={{ repo_url }}" \
    --label "org.opencontainers.image.description=Development container base" \
    --label "org.opencontainers.image.licenses=MIT" \
    --label "org.opencontainers.image.title={{ repo_name }}" \
    --label "org.opencontainers.image.vendor={{ repo_owner }}" .

test: build
    podman run --rm {{ docker_tag }}

security-scan: build
    #!/usr/bin/env bash
    set -euxo pipefail
    TEMP_DIR=$(mktemp -d)
    podman save {{ docker_tag }} | gzip > "$TEMP_DIR/image.tar.gz"
    trivy image --input "$TEMP_DIR/image.tar.gz" --format sarif \
      --skip-version-check --output /tmp/trivy-results.sarif
    rm -rf "$TEMP_DIR"

release: lint test security-scan
    echo $PATH
    sudo ln -sf /usr/bin/podman /usr/local/bin/docker
    semantic-release

clean:
    rm -rf .vale/.vale-config .vale/Google
