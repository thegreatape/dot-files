set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

set autowriteall

" Get correct $PATH from .bashrc
set shell=bash

" Disable .swp file creation
set noswapfile

Plugin 'tpope/vim-repeat'

" RTF copying for Keynote copy + paste
Plugin 'vagmi/rtf-highlight'

" Jade templating
Plugin 'vim-scripts/jade.vim'

" Javascript
Plugin 'pangloss/vim-javascript'

" Markdown
Plugin 'tpope/vim-markdown'
augroup mkd
  autocmd!
  autocmd BufRead *\.markdown,*\.md,*\.txt set ai formatoptions=tcroqn2 comments=n:>
  autocmd BufRead *\.markdown,*\.md,*\.txt setlocal formatoptions=l
  autocmd BufRead *\.markdown,*\.md,*\.txt setlocal lbr
  autocmd BufRead *\.markdown,*\.md,*\.txt map j gj
  autocmd BufRead *\.markdown,*\.md,*\.txt map k gk
  autocmd BufRead *\.markdown,*\.md,*\.txt setlocal smartindent
  autocmd BufRead *\.markdown,*\.md,*\.txt setlocal nolist
  autocmd BufRead *\.markdown,*\.md,*\.txt nnoremap <buffer> <leader>sp :setlocal spell! spelllang=en_gb<cr>
  autocmd BufRead *\.markdown,*\.md,*\.txt iabbrev <buffer> cblock {% raw FOO %}<cr>{% highlight %}<cr>{% endraw %}<cr>{% endhighlight %}<esc>?FOO<cr>cw
augroup END

" prose
Plugin 'junegunn/goyo.vim'
Plugin 'reedes/vim-pencil'
let g:pencil#wrapModeDefault = 'soft'
map gp :Goyo <bar> :TogglePencil <CR>

" Ruby and Rails
Plugin 'vim-ruby/vim-ruby'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-rails'
Plugin 'tmhedberg/matchit'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'

" SCSS
au BufRead,BufNewFile *.scss set filetype=scss
" Guardfiles and axlsx are just ruby
au BufRead,BufNewFile *.axlsx set filetype=ruby
au BufRead,BufNewFile Guardfile set filetype=ruby
" treat hamlbars and hamlc the same as haml
au BufRead,BufNewFile *.hamlc set ft=haml
au BufRead,BufNewFile *.hamlbars set ft=haml

" Clojure
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "2"}
Plugin 'jpalardy/vim-slime'
xmap <leader>f <Plug>SlimeRegionSend
nmap <leader>f <Plug>SlimeParagraphSend

Plugin 'tpope/vim-classpath'
Plugin 'tpope/vim-fireplace.git'
Plugin 'guns/vim-clojure-static.git'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'

let g:rbpt_colorpairs = [
  \ ['blue',        '#FF6000'],
  \ ['cyan',        '#00FFFF'],
  \ ['darkgreen',   '#00FF00'],
  \ ['LightYellow', '#c0c0c0'],
  \ ['blue',        '#FF6000'],
  \ ['cyan',        '#00FFFF'],
  \ ['darkgreen',   '#00FF00'],
  \ ['LightYellow', '#c0c0c0'],
  \ ['blue',        '#FF6000'],
  \ ['cyan',        '#00FFFF'],
  \ ['darkgreen',   '#00FF00'],
  \ ['LightYellow', '#c0c0c0'],
  \ ['blue',        '#FF6000'],
  \ ['cyan',        '#00FFFF'],
  \ ['darkgreen',   '#00FF00'],
  \ ['LightYellow', '#c0c0c0'],
  \ ]
let g:rbpt_max = 16

function! IsFireplaceConnected()
  return has_key(fireplace#platform(), 'connection')
endfunction

function! NreplStatusLine()
  if has_key(fireplace#platform(), 'connection')
    return 'nREPL Connected'
  else
    return 'No nREPL Connection'
  end
endfunction

augroup clojure
  autocmd!
  autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesActivate
  autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesLoadRound
  autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesLoadSquare
  autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesLoadBraces
  " autocmd BufEnter *.cljs,*.clj,*.cljs.hl setlocal iskeyword+=?,-,*,!,+,/,=,<,>,.,:

  autocmd BufEnter *.cljs,*.clj,*.cljs.hl call SetBasicStatusLine()
  autocmd BufEnter *.cljs,*.clj,*.cljs.hl set statusline+=\ [%{NreplStatusLine()}]  " REPL connection status
augroup END

" Vimux
Plugin 'benmills/vimux'
Plugin 'thegreatape/vimux-ruby-test'

augroup ruby
  autocmd!
  " test running shortcuts
  autocmd Filetype ruby nnoremap <leader>rl :RunRubyFocusedTest<cr>
  autocmd Filetype ruby nnoremap <leader>rf :RunAllRubyTests<cr>
  autocmd Filetype ruby nnoremap <leader>rc :VimuxClosePanes<cr>
augroup end

let g:VimuxOrientation = "h"
let g:VimuxHeight = "30"
let g:VimuxUseNearestPane = 1
let g:vimux_ruby_clear_console_on_run = 0

" Navigating tmux/vim splits seamlessly
Plugin 'thegreatape/vim-tmux-navigator'

" Elixir
Plugin 'elixir-lang/vim-elixir'
Plugin 'slashmili/alchemist.vim'

" Go
Plugin 'fatih/vim-go'
augroup go
autocmd!
autocmd Filetype go inoremap <C-n> <C-x><C-o>
augroup END

" Less
Plugin 'groenewege/vim-less'

" Elm
Plugin 'lambdatoast/elm.vim'

 " fix backspace flicker caused by elm plugin mapping
 " it to dedenting in insert mode
let g:Haskell_no_mapping = 1

" Ctags
Plugin 'vim-scripts/AutoTag'
Plugin 'vim-scripts/taglist.vim'
set tags+=./tags

" Utility plugins
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/bufkill.vim'
Plugin 'godlygeek/csapprox'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular.git'
Plugin 'kien/ctrlp.vim.git'
Plugin 'junegunn/fzf'
Plugin 'tpope/vim-abolish'
Plugin 'tommcdo/vim-lion'
Plugin 'malkomalko/projections.vim'
Plugin 'terryma/vim-multiple-cursors'

Plugin 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" searching
Plugin 'rking/ag.vim'
"nnoremap <leader>ag :
nnoremap <leader>ag :set operatorfunc=AgOperator<cr>g@
vnoremap <leader>ag :<c-u>call AgOperator(visualmode())<cr>

function! AgOperator(type)
  let saved_unamed_register = @@
  if a:type ==# 'v'
    execute "normal! `<v`>y"
  elseif a:type ==# 'char'
    execute "normal! `[v`]y"
  else
    return
  endif
  execute "Ag " . shellescape(@@)
  let @@ = saved_unamed_register
endfunction

" highlight zsh-theme files as shell
au BufNewFile,BufRead *.zsh-theme set filetype=zsh

" Use all-space indentation, width of 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Load colorscheme
colors jellybeans

" for outside high-contrast use
"colors github

" use system clipboard
set clipboard=unnamed

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
set wildignore+=*/vendor/*,*/build/*,*/bower_components/*,*/node_modules/*,*/*.class

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

" open FZF with leader-t
nnoremap <leader>t :FZF<cr>

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif


" Deal with trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

augroup whitespace
  autocmd!
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
augroup end
" clear trailing spaces with <space><space>
nnoremap <silent> <space><space> :silent! %s/\s\+$//<CR>


" change cursor shape in insert mode. requires building master of
" iTerm2, at least as of 11-22-12
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
elseif exists('$TMUX')
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
augroup lastposition
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END

call vundle#end()
filetype plugin indent on
syntax on
set hlsearch

" move line up
nnoremap - ddp

" move line down
nnoremap _ ddkP

" upper 'case' word
nnoremap <c-u> viwU

" typo proof my life
iabbrev explict explicit

" wrap current word in quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" open last buffer in below + right split
nnoremap <leader>pb :execute "rightbelow vsplit " . bufname('#')<cr>

" ' or " to wrap selection in quotes in visual mode
vnoremap ' <esc>mz`<i'<esc>`>la'<esc>`z
vnoremap " <esc>mz`<i"<esc>`>la"<esc>`z

set noruler      " disable ruler that shows line + col of cursor
set laststatus=2 " always show status line

function! SetBasicStatusLine()
  set statusline=%f   " path to file
  set statusline+=\   " separator
  set statusline+=%m  " modified flag
  set statusline+=%=  " switch to right side
  set statusline+=%y  " filetype of file
endfunction
call SetBasicStatusLine()
