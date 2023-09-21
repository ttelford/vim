" An example for a gvimrc file.
" The commands in this are executed when the GUI is started.
"
" Maintainer: Bram Moolenaar <Bram@vim.org>
" Last change:  2001 Sep 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.gvimrc
"       for Amiga:  s:.gvimrc
"  for MS-DOS and Win32:  $VIM\_gvimrc
"     for OpenVMS:  sys$login:.gvimrc

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

set lines=40 columns=86 " Check for winsize if it's acting weird.

set spell   " Spell Checking on.
set ch=2    " Make command line two lines high

set mousehide   " Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500
	" I like highlighting strings inside C comments
	let c_comment_strings=1

	" Switch on syntax highlighting if it wasn't on yet.
	if !exists("syntax_on")
		syntax on
	endif

	" Switch on search pattern highlighting.
	set hlsearch

	" Set nice colors
	" background for normal text is light grey
	" Text below the last line is darker grey
	" Cursor is green, Cyan when ":lmap" mappings are active
	" Constants are not underlined but have a slightly lighter background
	"  highlight Normal guibg=grey90
	"  highlight Cursor guibg=Green guifg=NONE
	"  highlight lCursor guibg=Cyan guifg=NONE
	"  highlight NonText guibg=grey80
	"  highlight Constant gui=NONE guibg=grey95
	"  highlight Special gui=NONE guibg=grey95
	" winsize 86 40 " → This overrides the columns setting; using columns and
	"                   lines is reccomended instead.
	set foldcolumn=4
	setlocal spell spelllang=en_us
	set bg=light
endif

set guioptions+=T

if has("unix")
	if system('uname')=~'Darwin'
		set guifont=CaskaydiaCoveNFM-Regular:h16
	else
		set guifont=Consolas\ 14
	endif
else "Windows, for all intents...
	" GUI Font
	set guifont=Consolas:h13:cANSI
	" X11-esque copy on select:
	:vnoremap <LeftRelease> "+y<LeftRelease>"
	"  let winhelpfile='windows.hlp'
	"  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
	" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
	let &guioptions = substitute(&guioptions, "t", "", "g")
endif
