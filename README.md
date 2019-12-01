# GrepRtpScr

Plugin for **grep**ping through your Vim's **r**un**t**ime**p**ath & **scr**iptnames



## Purpose

This plugin greps for the given query through your two vimscript
sources, `runtimepath` & `scriptnames`, then displays the results in the
location list.

As your `runtimepath` contains all `.vim` sources that are loadable,
`:GrepRtp` can help you discover and/or remind you of yet-to-be loaded
scripts and their functionalities.

And since `scriptnames` consists of all `.vim` sources that are already
loaded, `:GrepScr` can be quite useful for debugging your current Vim
instance.



## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug):
* `Plug 'jyscao/greprtpscr'`

Using [dein](https://github.com/Shougo/dein.vim):
* `call dein#add('jyscao/greprtpscr')`

Manually:
* Copy the files to your `nvim/` or `.vim/` directory



## Usage

The plugin provides 2 commands:

* `:GrepRtp` 
* `:GrepScr`

Both take a search query, which may be a regex pattern, as an argument.
The location-list will then be populated with your results.



## Demo

[![asciicast](https://asciinema.org/a/8VTauXdwR7Aqhqibfh98BUC7P.svg)](https://asciinema.org/a/8VTauXdwR7Aqhqibfh98BUC7P)

1. `:GrepRtp layers`: grep through `rtp` sources that contain `'layers'`
2. searched for `'debug'` keyword, open the corresponding [SpaceVim](https://github.com/SpaceVim/SpaceVim) layer source and checkout its functionalities
3. `:GrepScr markdown` grep through `scriptnames` sources that contain `'markdown'`
4. searched for `'preview'` keyword, which corresponds to specific markdown vim-plugin in order to debug it
