" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

set shell=bash\ -i

" Vundle setup
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Jade templating
Bundle 'vim-scripts/jade.vim'

" Javascript
Bundle 'pangloss/vim-javascript'

" Markdown
Bundle 'tpope/vim-markdown'
augroup mkd
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
  autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:>
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:>
  autocmd BufRead *\.markdown,*\.md,*\.txt setlocal formatoptions=l
  autocmd BufRead *\.markdown,*\.md,*\.txt setlocal lbr
  autocmd BufRead *\.markdown,*\.md,*\.txt map j gj
  autocmd BufRead *\.markdown,*\.md,*\.txt map k gk
  autocmd BufRead *\.markdown,*\.md,*\.txt setlocal smartindent
  autocmd BufRead *\.markdown,*\.md,*\.txt nnoremap <leader>sp :setlocal spell! spelllang=en_gb<cr>
augroup END

" Ruby and Rails
Bundle 'vim-ruby/vim-ruby'
Bundle 'kchmck/vim-coffee-script.git'
Bundle 'tpope/vim-rails'
" SCSS
au BufRead,BufNewFile *.scss set filetype=scss
" Guardfiles and axlsx are just ruby
au BufRead,BufNewFile *.axlsx set filetype=ruby
au BufRead,BufNewFile Guardfile set filetype=ruby
" treat hamlbars and hamlc the same as haml
au BufRead,BufNewFile *.hamlc set ft=haml
au BufRead,BufNewFile *.hamlbars set ft=haml

" Clojure
Bundle 'tpope/vim-fireplace.git'
Bundle 'tpope/vim-classpath.git'
Bundle 'guns/vim-clojure-static.git'

" Vimux
Bundle 'benmills/vimux'
Bundle 'thegreatape/vimux-ruby-test'
" Ruby test running shortcuts
autocmd Filetype ruby nnoremap <leader>rl :RunRubyFocusedTest<cr>
autocmd Filetype ruby nnoremap <leader>rf :RunAllRubyTests<cr>
autocmd Filetype ruby nnoremap <leader>rc :VimuxClosePanes<cr>
let g:VimuxOrientation = "h"
let g:VimuxHeight = "30"
let g:VimuxUseNearestPane = 1
let g:vimux_ruby_clear_console_on_run = 0

" Navigating tmux/vim splits seamlessly
Bundle 'christoomey/vim-tmux-navigator'

" Go
Bundle 'jnwhiteh/vim-golang'
au FileType go au BufWritePre <buffer> Fmt " format on save

" Less
Bundle "groenewege/vim-less"

" Ctags
Bundle 'vim-scripts/AutoTag'
Bundle 'vim-scripts/taglist.vim'

" Utility plugins
Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/bufkill.vim'
Bundle 'godlygeek/csapprox'
Bundle 'rking/ag.vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tsaleh/vim-matchit'
Bundle 'vim-scripts/ZoomWin'
Bundle 'godlygeek/tabular.git'
Bundle 'kien/ctrlp.vim.git'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-abolish'

filetype plugin indent on

" highlight zsh-theme files as shell
au BufNewFile,BufRead *.zsh-theme set filetype=zsh

" Use all-space indentation, width of 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Load colorscheme
colors zenburn

" Lose the GUI
if has("gui_running")
  set guioptions=egmrt
  set guifont=Menlo:h12
endif

" Show line numbers
set number

" zsh-style tab completion
set wildmenu
set wildmode=longest,list
set wildignore+=*/vendor/*,*/build/*

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" disable audible error bell
set visualbell

set history=2000    " keep 2000 lines of command line history
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
let maplocalleader="\\"

" map \ to reverse character search
noremap \ ,

" shortcut to edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" shortcut to source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" open ctrl-p with leader-t
let g:ctrlp_map = '<leader>t'
let g:ctrlp_cmd = 'CtrlP'

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

" Deal with trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" clear trailing spaces with <space><space>
nnoremap <silent> <space><space> :silent! %s/\s\+$//<CR>


" change cursor shape in insert mode. requires building master of
" iTerm2, at least as of 11-22-12
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  inoremap <special> <Esc> <Esc>hl
  set guicursor+=i:blinkwait0
endif

" Enable 256 colors to stop the CSApprox warning
if &term == 'xterm' || &term == 'screen'
  set t_Co=256
endif

" renaming files in-place
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

" expand %% to current buffer's path in command line mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" remap W to save
command! -bang W w<bang>

" Reopen to last position in file.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
