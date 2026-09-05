ARG BASE_IMAGE=ghcr.io/jkhaak/devc-base:latest
FROM ${BASE_IMAGE}

LABEL org.containers.image.source="https://github.com/jkhaak/nvim-config"
LABEL org.containers.image.description="Personal Neovim development environment"

ENV LANG=fi_FI.UTF-8
ENV LC_ALL=fi_FI.UTF-8
ENV LANGUAGE=fi_FI.UTF-8
ENV COLORTERM=truecolor

RUN sudo dnf install -y \
    glibc-langpack-en \
    glibc-langpack-fi \
    && dnf clean all

RUN brew update \
    && brew install -y \
    fd \
    fish \
    gofumpt \
    gopls \
    jujutsu \
    neovim \
    ripgrep \
    staticcheck

COPY --chown=dev:dev init.lua /home/dev/.config/nvim/init.lua
COPY --chown=dev:dev nvim-pack-lock.json /home/dev/.config/nvim/nvim-pack-lock.json

# Install plugins from lockfile
RUN nvim --headless --noplugin \
    -c "lua vim.pack.update(nil, {force=true, target='lockfile'})" \
    -c "qa"

WORKDIR /workspace
CMD ["nvim"]
