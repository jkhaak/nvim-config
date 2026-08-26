ARG BASE_IMAGE=ghcr.io/jkhaak/devc-base:latest
FROM ${BASE_IMAGE}

LABEL org.containers.image.source="https://github.com/jkhaak/nvim-config"
LABEL org.containers.image.description="Personal Neovim development environment"

RUN brew install neovim ripgrep fd

COPY --chown=dev:dev init.lua /home/dev/.config/nvim/init.lua
COPY --chown=dev:dev nvim-pack-lock.json /home/dev/.config/nvim/nvim-pack-lock.json

# Install plugins from lockfile
RUN nvim --headless --noplugin \
    -c "lua vim.pack.update(nil, {force=true, target='lockfile'})" \
    -c "qa"

COPY --chown=dev:dev --chmod=755 entrypoint.editor.sh /entrypoint.d/20-editor.sh

EXPOSE 1234
WORKDIR /workspace
