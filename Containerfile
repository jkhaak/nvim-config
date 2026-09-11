ARG BASE_IMAGE=ghcr.io/jkhaak/devc-base:latest
FROM ${BASE_IMAGE}

LABEL org.containers.image.source="https://github.com/jkhaak/nvim-config"
LABEL org.containers.image.description="Personal Neovim development environment"

ENV LANG=fi_FI.UTF-8
ENV LC_ALL=fi_FI.UTF-8
ENV LANGUAGE=fi_FI.UTF-8
ENV COLORTERM=truecolor

RUN sudo dnf install -y --setopt=install_weak_deps=False --setopt=tsflags=nodocs \
    fd-find \
    fish \
    glibc-langpack-en \
    glibc-langpack-fi \
    ripgrep \
    wl-clipboard \
    && dnf clean all

RUN brew update \
    && brew install -y \
    gofumpt \
    gopls \
    jujutsu \
    just \
    neovim \
    node \
    staticcheck \
    tree-sitter \
    tree-sitter-cli \
    tree-sitter-go \
    && brew cleanup --prune=all \
    && rm -rf "$(brew --cache)"

# fix some possible permission issues
RUN mkdir -p \
    /home/dev/.cache \
    /home/dev/.config \
    /home/dev/.local \
    /home/dev/.ssh

COPY --chown=dev:dev init.lua /home/dev/.config/nvim/init.lua
COPY --chown=dev:dev nvim-pack-lock.json /home/dev/.config/nvim/nvim-pack-lock.json

# Install plugins from lockfile
RUN nvim --headless --noplugin \
    -c "lua vim.pack.update(nil, {force=true, target='lockfile'})" \
    -c "qa"

WORKDIR /workspace
CMD ["nvim"]
