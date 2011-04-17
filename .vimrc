" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Initialize pathogen for loading plugins as bundles
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Use all-space indentation, width of 4 spaces
set tabstop=4
set softtabstop=4   
set shiftwidth=4
set expandtab

" Set indentation for Ruby to 2 spaces
autocmd BufRead *.rb, set tabstop=2
autocmd BufRead *.rb, set softtabstop=2
autocmd BufRead *.rb, set shiftwidth=2

" Load colorscheme
colors zenburn

" Lose the GUI
if has("gui_running")
    set guioptions=egmrt
    set guifont=Menlo:h12
endif

" Show line numbers
set number

" bash-style tab completion
set wildmode=longest,list

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" disable audible error bell
set visualbell

set history=50      " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching

" Allow flipping between dirty buffers 
set hidden

" Make searches case-insensive unless there is a capitalized char in the
" search
set ignorecase 
set smartcase

" map leader to ,
let mapleader = ","

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
 
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Markdown stuff
augroup mkd
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
  autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:>
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:>
augroup END

" Pig stuff
augroup filetypedetect 
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig 
augroup END 

" Thrift stuff
au BufRead,BufNewFile *.thrift set filetype=thrift
au! Syntax thrift source ~/.vim/bundle/thrift/thrift.vim

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
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

