# .vim/
> This is my [vimrc](https://github.com/davelens/dotvim/blob/master/vimrc). There are many like it, but this one is mine. My vimrc is my best friend. It is my life. I must master it as I must master my life. Without me, my vimrc is useless. Without my vimrc, I am useless.

#### Install
```sh
git clone git@github.com:davelens/dotvim.git ~/.dotvim 
cd ~/.dotvim && ./install.sh
```

#### Uninstall
```sh
cd ~/.dotvim && ./uninstall.sh
```

## Changelog
As of march 2020 I created [a separate changelog](https://github.com/davelens/dotvim/blob/master/CHANGELOG.md) 
for my .vimrc which I'll attempt to maintain, in order to explain some of my
reasoning to my future self.

## Neovim
In september 2019 I made the switch to Neovim with its release of 0.4. Mostly
because I was dealing with large files at the time. In Rails, files like i18n
files or data logs are so much more responsive in neovim compared to stock Vim. 

Thankfully, both Vim and Neovim are mostly **backwards compatible**, and I try 
to do the same with my vimrc.

## Plugins
Much like yourself, I use a plethora of
[tpope](https://github.com/tpope/)'s plugins, and a handful of others. If you
look at [my plugin configuration file](https://github.com/davelens/dotvim/blob/master/vim/plugin/configurations.vim)
you'll see I'm a big fan of plugins that do their job with little to no
configuration, but enable plenty of experimentation.
[fzf](https://github.com/junegunn/fzf) is a prime example of this.

My plugin manager of choice is [vim-plug](https://github.com/junegunn/vim-plug). 
Lightweight, with a good DSL. 

## Autocompletion
### Vim
Vim will use [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe) (YCM for 
short), a plugin that requires a pre-compiled component.  [See their 
installation instructions](https://github.com/Valloric/YouCompleteMe#installation) 
to get this sorted.

#### YCM on macos < 10.10
If you're on a version of macos lower than 10.10, chances are that the YCM component failed to compile. I got this fixed with [a helpful SO answer](http://stackoverflow.com/questions/29529455/missing-c-header-debug-after-updating-osx-command-line-tools-6-3#answer-29576048).

### Neovim
With the advent of [Microsoft's
LSP](https://microsoft.github.io/language-server-protocol/) I've been on the
fence to set one up for Ruby and JavaScript, though I haven't taken the 
time to do this properly yet.

Neovim will use [coc.nvim](https://github.com/neoclide/coc.nvim) for now. I'm 
not entirely convinced of its merit yet (I get the sense it's too bloated for
my tastes), but it sports easy configuration. The alternative would be to use 
[ALE](https://github.com/dense-analysis/ale) along with 
[Deoplete](https://github.com/Shougo/deoplete.nvim) + [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim). As for an LSP server for Ruby, I've gotten the best results so far 
with [Solargraph](https://solargraph.org/).

## Statusline
If you're on macos, [my plugin configuration file](https://github.com/davelens/dotvim/blob/master/vim/plugin/configurations.vim) will attempt to automatically download a patched `Droid Sans Mono` font 
that includes Powerline icons. If your statusline shows questionmarks instead of 
specific icons, you'll need to configure your terminal to use a Powerline font 
as the non-ASCII font.

If you don't wish to make use of the fancy powerline icons, comment out the 
following line in [configurations.vim](https://github.com/davelens/dotvim/blob/master/vim/plugin/configurations.vim).

```vimscript
let g:airline_powerline_fonts = 1
```
