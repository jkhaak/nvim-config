default:
    just --list

build-base:
    podman build \
        --build-arg BASE_IMAGE=ghcr.io/jkhaak/devc-base:latest \
        -t ghcr.io/jkhaak/nvim-config:base .

build-mistral-vibe:
    podman build \
        --build-arg BASE_IMAGE=ghcr.io/jkhaak/devc-mistral-vibe:latest \
        -t ghcr.io/jkhaak/nvim-config:mistral-vibe .

build: build-base build-mistral-vibe
