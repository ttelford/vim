" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
	finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch		" do incremental searching

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on
	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!
		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78
		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		autocmd BufReadPost *
					\ if line("'\"") > 0 && line("'\"") <= line("$") |
					\   exe "normal g`\"" |
					\ endif
	augroup END
else
	set autoindent		" always set autoindenting on
endif " has("autocmd")

setlocal spell spelllang=en_us

set autoindent
set matchtime=2
set shiftwidth=4
set showmatch
set smartindent
set smarttab
set t_Co=256
set tabpagemax=30
set tabstop=4
set background=dark
"May need these for 256-color too:
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dm


" Set !? for the interrobang digraph
digraph !? 8253 " Interrobang
digraph -. 8230 " U+2026=… HORIZONTAL ELLIPSIS

" Set global fileencoding to UTF-8
setglobal fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1

" Load the pathogen autoloader
execute pathogen#infect()
Helptags
autocmd BufReadPost * call SyntaxRange#Include('@begin=sh@','@end=sh@','sh','NonText')
autocmd BufReadPost * call SyntaxRange#Include('@begin=groovy@','@end=groovy@','groovy','NonText')

" Platform-specific
if has("unix")
	set nospell
else
	set encoding=utf-8
	let g:netrw_cygwin = 0
	let g:netrw_ssh_cmd  = '"c:\Program Files (x86)\PuTTY\plink.exe" -T -ssh'
	let g:netrw_scp_cmd  = '"c:\Program Files (x86)\PuTTY\pscp.exe" -scp'
	" psftp doesn't work the same way as normal sftp, so this must be hacked
	up
	"" some...
	let g:netrw_sftp_cmd = '"c:\Program Files (x86)\PuTTY\pscp.exe" -sftp'
	" Think this is unix-only
	" "let g:WMGraphviz_dot="C:\\Program Files \(x86\)\\Graphviz2\.36\\bin\\dot.exe"
endif

" TRY to do a diff expr for no whitespace...
set diffexpr=MyDiff() 
function MyDiff() 
	let opt = "" 
	if &diffopt =~ "icase" 
		let opt = opt . "-i " 
	endif 
	if &diffopt =~ "iwhite" 
		let opt = opt . "-w " 
	endif 
	" 	let mystr= "!diff -d -a --binary " . opt . v:fname_in . " " . v:fname_new . " > " . v:fname_out 
	"	echom mystr
	silent execute "!diff -d -a --binary " . opt . v:fname_in . " " . v:fname_new . " > " . v:fname_out 
endfunction 

