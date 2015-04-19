# My dotfiles

## Installation

```
git clone git://github.com/elle/dotfiles ~/.dotfiles
cd ~/.dotfiles
rake install
```

What this script does is backing up existing config files by renaming them.
And then symlinking to the files in this repo that live in `~/.dotfiles`

Vim plugins are managed through vundle. You'll need to install vundle to get them.

```
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Then run `:BundleInstall` in vim.

`.gitconfig` includes my `git` user name and email. You will need to update it
to your name and email.
