" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

filetype plugin indent on
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"My stuff---------------------------------------------------------------------------------------
let mapleader = " "

set exrc
set relativenumber
set nu
set hidden
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set nohlsearch
set scrolloff=8
set incsearch

set clipboard=unnamed
set path +=**
set wildmenu

"filebrowser
let g:netrw_banner=0 "disable banner
let g:netrw_liststyle=3 "tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide=',\|\s\)\zs\.\S\+'
let g:netrw_altv=1  "open splits to the right

nnoremap <leader>d "_dd
nnoremap <leader>e :Vex<CR>

" create a tag file for python files
nnoremap <leader>t :!python3 ~/scripts/ptags.py *py<CR>

"hardcore mode
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <PageUp> <Nop>
nnoremap <PageDown> <Nop>


"Snippets
"
"inserts a snippet. Takes current line as name of snippet_file
"execute first line from snippet as a recording
inoremap <Leader>ss <Esc>0v$F:h"sd"_x:Snippet <C-r>s<CR>0v$h"sd"_dd@s
command! -nargs=1 Snippet :read ~/dotfiles/.snippets/<args>

"create a Snippet
vnoremap <Leader>s :w ~/dotfiles/.snippets/
vnoremap <Leader>s! :w! ~/dotfiles/.snippets/

"get snippet without executefirst line
nnoremap <Leader>s :Snippet 


"<F9> to start python script
:map <F9> :!python %<CR>
