![Nvole Vole in suit](./Vole.png)

## :gear: Features

- Completion and diagnostics on several languages
- Code formatter with `prettier`
- Preview LaTeX using Zathura
- Preview Markdown, UML, etc. in default browser
- Snippets with `LuaSnip`
- Customized LaTeX snippets for quick math mode
- Compatibility with Termux - Android terminal emulator

![Neovim with LaTeX](./nvim_latex.png)

## :hammer_and_wrench: Setup

### Installation

To get started, install git and neovim:

> Debian based distribution

```shell
apt install git neovim
```

> Arch based distribution

```shell
pacman -S git neovim
```

Clone the repository to `$HOME/.config/nvim`:
> create backup of your config before installing

```console
git clone https://github.com/steguiosaur/nvole.git ~/.config/nvim
```

Install plugins by running `nvim` in the terminal. It will automatically install
the package manager on initial startup. Type `Lazy install` in command mode to
install plugins.
> Plugins listed at `~/.config/nvim/lua/core/lazy.lua`

```shell
:Lazy install
```

### Language Server Installation

This config uses [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) to manage
Language Server configurations. To install language servers, type `:Mason` in command
mode and look for the language server that suits your needs.

> There were several Language Servers that will automatically install.
To disable, goto `~/.config/nvim/lua/lsp/mason.lua` and edit the listed servers.

Add the installed server on `add_server` table on `~/.config/nvim/lua/lsp/mason.lua`.

## Troubleshoot

#### Mason ERROR Log: `Current platform is unsupported` in Termux

The config does not guarantee several Language Server to work on `aarch64` architecture.
Manual server installation is needed to make LSP work. We'll take `clangd` and
`rust-analyzer` as an example:

- Install `clangd` using node package manager (requires `nodejs`): `npm install clangd`
- Install `rust-analyzer` using the built-in package manager: `apt install rust-analyzer`

In some cases, the binary is not available on any package managers. The alternative
option for this is to clone the language server repository and compile the said
server before adding it to `$PATH`.

If you are considering to move on a configuration that just works even on Android,
you might want to visit this config even though it is rarely supported nowadays:

- [steguiosaur/nvim](https://github.com/steguiosaur/nvim) - uses coc.nvim for
managing language servers

#### `latexindent` formatter not working

Install `libxcrypt-compat` using the package manager.
