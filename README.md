# dotvim

> This is my [vim](https://neovim.io). There are many like it, but this one is mine. My vim is my best friend. It is my life. I must master it as I must master my life. Without me, my vim is useless. Without my vim, I am useless.

## History
* [Est. 2011](https://github.com/davelens/dotvim/commits/master/?since=2011-05-01&until=2011-05-31)
* Switched from Vim to Neovim in september 2019, after experiencing how much quicker it was dealing with very large files
* Switched to a full Lua config in september 2024, after experiencing LSP functionality for Elixir in particular
* Archived my old vimrc [here](https://github.com/davelens/dotvim.old)

## Installation
All steps assume you'll clone the repo into `~/.dotvim`:

```sh
git clone git@github.com:davelens/dotvim.git ~/.dotvim 
~/.dotvim/scripts/install.sh
```
Once that's done, you can start Neovim using `dvim`.

### Why "dvim"?
I like having my `nvim` command to remain stock Neovim, so the install script will create a `dvim` executable in `~/.local/bin/`. 
The script will complain if `~/.local/bin` is not in your path yet.

As for the `d`:
> **D**ave, **d**otvim, **d**evelopment,...

### Nerd fonts
The script will install both the `DroidSansMono` and `Hack` [nerd fonts](https://www.nerdfonts.com/). These are necessary to have access to certain icons and glyphs, though you'll need to configure your terminal app of choice to actually start using them.

### Uninstall
```sh
~/.dotvim/scripts/uninstall.sh
```
