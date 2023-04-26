# :hatching_chick: LuaNvim

**Neovim config made in Lua**

![Neovim with LaTeX](./nvim_latex.png) 

## :gear: Features
> Configurable under `~/.config/nvim/lua/core/`

- Preview LaTeX using Zathura
- Preview Markdown, UML, etc. in default browser

## :hammer_and_wrench: Setup

### Required

- Neovim
- Git

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

Clone the repository to `$HOME/.config/nvim`

```console
git clone https://github.com/steguiosaur/nvim.git ~/.config/nvim
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

> There were several Language Servers that will automatically install. To disable, go
to `~/.config/nvim/lua/lsp/mason.lua` and edit the listed servers.

The config does not guarantee a solid configuration on LSP for the reason it is new.
If you consider to move on a configuration that just works even on Android, you might
want to visit this config:

- [steguiosaur/nvim](https://github.com/steguiosaur/nvim)
