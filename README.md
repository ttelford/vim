# vim

My Vim configuration and plugins

## Using tmux-256color on macOS

Excerpts from: [definitive guide](https://gpanders.com/blog/the-definitive-guide-to-using-tmux-256color-on-macos/)

in `~/.tmuxrc`: `set -s default-terminal tmux-256color`

### Update termcap

#### MacPorts

First, get the `tmux-256color` termcap source from ncurses/macports:
`$ /opt/local/bin/infocmp -x tmux-256color > ~/tmux-256color.src`

Now, modify it to change the `pairs` value from `65536` to `32767` This needs
to be done due to a bug in ncurses 5.7 that interprets `pairs#65536` as
`pairs#01`.

So:  Change `pairs#0x10000` or `pairs#65536` (whichever exists - depending on
if its in hexadecimal or decimal) and replace it with `pairs#32767`.

This may change with future versions of MacOS, depending on its version of
ncurses.

Next, update the local user's version of the termcap file:

`$ /usr/bin/tic -x -o $HOME/.local/share/terminfo tmux-256color.src`

Be sure to explicitly use /usr/bin/tic to ensure that the entry is compiled
with the builtin ncurses.

Next use an environment variable to point to the termcap files (This lets us be
sure all versions of ncuses point to the same path):

Put in your .bashrc (or .zshenv)

`export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo`

And now, it should all work - including italics in vim/tmux.
