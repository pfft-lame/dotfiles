# AGENTS.md — dotfiles

## Structure

**GNU Stow** dotfiles managed with `--target="$HOME"` (set in `.stowrc`). Each top-level directory maps to a stow package that mirrors the desired `$HOME` layout.

- `nvim/.config/nvim/` — Neovim config (lazy.nvim, LSP via `vim.lsp`)
- `zsh/.zshrc` — Zsh config (starship prompt, zinit plugin manager)
- `tmux/.tmux.conf` — Tmux (prefix `C-Space`, Tokyo Night theme, tpm, continuum/resurrect)
- `ghostty/.config/ghostty/` — Ghostty terminal (tokyonight, custom GLSL shaders)
- `starship/.config/starship.toml` — Prompt config
- `kanata_mac/` / `kanata_linux/` — Keyboard remapping (macOS via LaunchDaemon, Linux via Hyprland)
- `Hyprland/`, `waybar/`, `rofi/`, `swaync/`, `wlogout/` — Linux desktop (Hyprland ecosystem)
- `aerospace/` — macOS tiling WM
- `kitty/`, `btop/`, `cava/`, `fastfetch/` — Misc terminal tools
- `opencode/.config/opencode/` — OpenCode config (theme: tokyo, plugin: `@opencode-ai/plugin`)
- `.misc/mac/` — macOS LaunchDaemon plists (kanata, Karabiner DriverKit)

## Key commands

```sh
stow -v <package>        # Symlink a package to $HOME
stow -v -D <package>     # Unlink a package
stow -v -R <package>     # Restow (clean+install)
```

No Makefile or other task runner. All packages are stowable independently.

## Neovim specifics

- Entrypoint: `nvim/.config/nvim/init.lua` -> loads `core/` then lazy.nvim imports `plugins/`
- Uses `vim.lsp.enable()` (Neovim 0.11+ native LSP) — **not** `mason-lspconfig`
- LSP servers: `lua_ls`, `gopls`, `ts_ls`, `svelte`, `clangd`, `tailwindcss`, `eslint`, etc.
- Custom Lua snippets in `snippets/` (typescript, go, svelte via luasnip)
- Leader key: `Space`
- `init.lua` has dead comment referencing `plugins.lsp` (no such module) — safe to ignore

## Platform notes

- Dual macOS/Linux setup. Linux packages start with `Hyprland/`, macOS with `aerospace/`
- Kanata on macOS runs as a LaunchDaemon (root); plists in `.misc/mac/` need manual copy to `/Library/LaunchDaemons/`
- Zsh config (`zsh/.zshrc`) is the primary shell on macOS; Fish config also exists under `fish/`
- `GOPATH=$HOME/go`, `EDITOR="nvim"`, aliases use `lsd`, `pnpm`, `lazygit`, `zoxide`
