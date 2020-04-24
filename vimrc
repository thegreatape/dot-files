set nocompatible
filetype off

" map leader to ,
let mapleader = ","
let maplocalleader="\\"

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
Plugin 'kchmck/vim-coffee-script'
Plugin 'mxw/vim-jsx'
Plugin 'tpope/vim-jdaddy'
Plugin 'isRuslan/vim-es6'

Plugin 'ruanyl/vim-fixmyjs'
let g:fixmyjs_engine = 'eslint'
let g:fixmyjs_rc_filename = ['.eslintrc.js']

augroup js
  autocmd!
  autocmd BufRead *.js,*.es6,*.jsx nmap <silent> <buffer> <leader>ja vi{gL:
  autocmd BufRead *.js,*.es6,*.jsx noremap <silent> <buffer> <leader>fj :Fixmyjs<cr>
  autocmd Filetype javascript nnoremap <leader>rf :call RunYarnTest()<cr>
augroup end

function! RunYarnTest()
  VimuxRunCommand("yarn test " . expand("%"))
endfunction

" Markdown
Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
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
  autocmd BufRead *\.markdown,*\.md,*\.txt nnoremap <buffer> <leader>ft :TableFormat<cr>
  autocmd BufRead *\.markdown,*\.md,*\.txt iabbrev <buffer> cblock {% raw FOO %}<cr>{% highlight %}<cr>{% endraw %}<cr>{% endhighlight %}<esc>?FOO<cr>cw
augroup END

" prose
Plugin 'junegunn/goyo.vim'
Plugin 'reedes/vim-pencil'
let g:pencil#wrapModeDefault = 'soft'
map gp :Goyo <bar> :TogglePencil <CR>

" Better SQL syntax highlighting
Plugin 'shmup/vim-sql-syntax'

" Python
augroup python
  autocmd!
  autocmd BufNewFile,BufRead *.py set tabstop=4
  autocmd BufNewFile,BufRead *.py set softtabstop=4
  autocmd BufNewFile,BufRead *.py set shiftwidth=4
  autocmd BufNewFile,BufRead *.py set expandtab
  autocmd BufNewFile,BufRead *.py set autoindent
  autocmd BufNewFile,BufRead *.py set fileformat=unix
  autocmd BufNewFile,BufRead *.py iabbrev pydb import ipdb; ipdb.set_trace()
augroup END

Plugin 'vim-scripts/indentpython.vim'
Plugin 'raimon49/requirements.txt.vim'

" Use the old vim regex engine (version 1, as opposed to version 2, which was
" introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
" slower with the new regex engine.
set re=1
" Ruby and Rails
Plugin 'vim-ruby/vim-ruby'
Plugin 'mtscout6/vim-cjsx'
Plugin 'tpope/vim-rails'
Plugin 'tmhedberg/matchit'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'danchoi/ruby_bashrockets.vim'

" Rust
Plugin 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1

" Linting
Plugin 'w0rp/ale'
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
" only lint on save
let g:ale_lint_on_text_changed = 'never'

" force json files to use json linting instead of javascript
au BufRead,BufNewFile *.json set filetype=json

" for active admin arb templates
autocmd BufRead,BufNewFile *.arb setfiletype ruby

" SCSS
au BufRead,BufNewFile *.scss set filetype=scss
" Guardfiles and axlsx are just ruby
au BufRead,BufNewFile *.axlsx set filetype=ruby
au BufRead,BufNewFile Guardfile set filetype=ruby
" treat hamlbars and hamlc the same as haml
au BufRead,BufNewFile *.hamlc set ft=haml
au BufRead,BufNewFile *.hamlbars set ft=haml

" Clojure

Plugin 'tpope/vim-classpath'
Plugin 'tpope/vim-fireplace.git'
Plugin 'tpope/vim-dispatch'
Plugin 'guns/vim-clojure-static.git'

" always only indent every subform with 2 spaces for these forms
let g:clojure_special_indent_words = 'deftype,defrecord,reify,proxy,extend-type,extend-protocol,letfn,fact,facts'

Plugin 'kien/rainbow_parentheses.vim'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
Plugin 'guns/vim-slamhound'
Plugin 'dgrnbrg/vim-redl'

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
  try
    return has_key(fireplace#platform(), 'connection')
  catch /Fireplace: :Connect to a REPL or install classpath.vim/
    return 0 " false
  endtry
endfunction

function! NreplStatusLine()
  if IsFireplaceConnected()
    return 'nREPL Connected'
  else
    return 'No nREPL Connection'
  endif
endfunction

function! VimuxSlime()
  call VimuxRunCommand(@v, 0)
endfunction

augroup clojure
  autocmd!

  " If text is selected, save it in the v buffer and send that buffer it to tmux
  autocmd BufEnter *.cljs,*.clj,*.cljs.hl vmap <Leader>sl "vy :call VimuxSlime()<CR>
  " Select current paragraph and send it to tmux
  autocmd BufEnter *.cljs,*.clj,*.cljs.hl nmap <Leader>sl vip<Leader>sl<CR>

  autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesActivate
  autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesLoadRound
  autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesLoadSquare
  autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesLoadBraces
  " autocmd BufEnter *.cljs,*.clj,*.cljs.hl setlocal iskeyword+=?,-,*,!,+,/,=,<,>,.,:

  " autocmd Filetype clojure call SetBasicStatusLine()
  " autocmd Filetype clojure set statusline+=\ [%{NreplStatusLine()}]  " REPL connection status

  autocmd Filetype clojure nmap <buffer> gf <Plug>FireplaceDjump
  autocmd Filetype clojure nnoremap <buffer> <leader>sh :Slamhound<cr>
  autocmd Filetype clojure nnoremap <silent> <buffer> <leader>rf :Require<cr>:RunTests<cr>
  autocmd Filetype clojure nnoremap <silent> <buffer> <leader>rl :Require<cr>:.RunTests<cr>
  autocmd Filetype clojure nnoremap <silent> <buffer> <leader>eo :Eval<cr>
  autocmd Filetype clojure nnoremap <silent> <buffer> <leader>e! :Eval!<cr>
  autocmd Filetype clojure imap <buffer> <Up> <Plug>clj_repl_uphist.
  autocmd Filetype clojure imap <buffer> <Down> <Plug>clj_repl_downhist.

  " autocmd BufLeave *.cljs,*.clj,*.cljs.hl  call SetBasicStatusLine()
augroup END

" Vimux
Plugin 'benmills/vimux'
Plugin 'thegreatape/vimux-ruby-test'
let g:vimux_ruby_file_relative_paths = 1

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

" Terraform
Plugin 'hashivim/vim-terraform'

" Ansible-specific YAML
Plugin 'chase/vim-ansible-yaml'

 " fix backspace flicker caused by elm plugin mapping
 " it to dedenting in insert mode
let g:Haskell_no_mapping = 1

" Ctags
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'vim-scripts/taglist.vim'

" Using FZF to search project tags, taken from
" https://github.com/junegunn/fzf/wiki/Examples-%28vim%29#jump-to-tags
" removed tag-generating call in s:tags(), since we want
" to use the gutentags launched version
function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! s:tags()
  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()

" gt to go to tag under cursor
nnoremap gt <C-]>
" <leader>gt to open fuzzy tag finder
nnoremap <leader>gt :Tags<cr>

" Utility plugins
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/bufkill.vim'
Plugin 'godlygeek/csapprox'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'godlygeek/tabular.git'
Plugin 'kien/ctrlp.vim.git'
Plugin 'junegunn/fzf'
Plugin 'tpope/vim-abolish'
Plugin 'tommcdo/vim-lion'
Plugin 'malkomalko/projections.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'wincent/ferret'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='zenburn'
let g:airline#extensions#ale#enabled = 1

function! AirlineInit()
  let g:airline_section_a=''
  let g:airline_section_b=airline#section#create(['%<', 'file', g:airline_symbols.space, 'readonly'])
  let g:airline_section_c=''
  let g:airline_section_y="%{airline#util#wrap(airline#extensions#branch#get_head(),0)}"
  let g:airline_section_z="%{gutentags#statusline()}"
endfunction
autocmd User AirlineToggledOn call AirlineInit()

Plugin 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" nix
Plugin 'LnL7/vim-nix'

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
"Plugin "godlygeek/csapprox"
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
set wildignore+=*vendor/*,*build/*,*bower_components/*,*node_modules/*,*-manifest.json,*.class

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

" short keycode timeout to avoid cursor shape-change lag
" when leaving insert mode
set timeout timeoutlen=1000 ttimeoutlen=10

" don't blink cursor
set guicursor=n-v-c:block-blinkwait0-blinkon0-blinkoff0,i-ci-ve:ver25,r-cr:hor20,o:hor50

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

set noruler      " disable ruler that shows line + col of cursor
set laststatus=2 " always show status line
