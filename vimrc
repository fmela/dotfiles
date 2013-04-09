set background=light
set nocompatible
set ruler
" tab conventions
set ts=8
set softtabstop=4
set shiftwidth=4
" expand all tabs to 4 spaces.
set noexpandtab
" set textwidth to 0 columns by default.
set tw=0
" autoindent
set ai
" indent options
set cinoptions=(0u0
" format options
set fo=tcroq
" backspace over things
set bs=2
" $ - show "$" when doing things like "cw"
" E - give an error when yanking pure whitespace
" F - when doing ":w [filename]", the current buffer will be assigned that
"     filename if it doesn't have one yet.
" W - don't overwrite a readonly file
" y - yank can be redone with `.'
" % - Vi-compatible matching for `%' command - good for C programs.
set cpoptions=$EFWy%
" show "INSERT" and "REPLACE"
set showmode
" show matching braces
set showmatch
"set this to always show status (IE. not running X)
set laststatus=2
"save automagically before things like :next and :make
set autowrite
"show partial command in status line
set showcmd
"set make program to GNU make
"set makeprg=gmake
"turn on word wrapping
"set wrap
set dict=/usr/share/dict/words
set pastetoggle=<F2>

" Autocommands
if !exists("autocommands_loaded")
	let autocommands_loaded = 1
	auto BufNewFile,BufRead *.[cChH] set cindent
	auto BufNewFile,BufRead *.cxx set cindent
	auto BufNewFile,BufRead *.hxx set cindent
	auto BufNewFile,BufRead *.cc set cindent
	auto BufNewFile,BufRead *.hh set cindent
	auto BufNewFile,BufRead *.cpp set cindent
	auto BufNewFile,BufRead *.hpp set cindent
	auto BufNewFile,BufRead *.java set cindent
endif

syn on

let c_syntax_for_h=1
let c_space_errors=1
let c_ansi_constants=1

" Enable incremental searching and search highlighting.
set incsearch
set hlsearch
" Use smart case matching.
set ignorecase
set smartcase

au BufNewFile,BufRead *.cxx,*.hxx,*.cc,*.hh,*.C,*.cpp,*.hpp,*.H set cindent

" Ctags FTW
set tags=tags;$HOME
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Make j and k behave more reasonably on wrapped lines.
nmap j gj
nmap k gk

" Make Control-E return to the last edited buffer.
nmap <C-e> :e#<CR>

" Make E toggle the NERDTree.
nmap \e :NERDTreeToggle<CR><C-w>p

" Useful commands.
command! -nargs=0 CleanWhitespace :%s/\\s\\+$//g

" Remember last cursor position
if has("autocmd")
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
		\ endif
endif

fu! AlternativeTabSettings()
	set sw=2
	set softtabstop=2
	set expandtab
endfunction

" Highlight past 80 characters as erroneous.
autocmd VimEnter *.c,*.h,*.m,*.cxx,*.hxx,*.cc,*.hh,*.C,*.H,*.cpp,*.hpp set tw=80
autocmd VimEnter *.c,*.h,*.m,*.cxx,*.hxx,*.cc,*.hh,*.C,*.H,*.cpp,*.hpp call matchadd('ErrorMsg', '\%>'.&l:textwidth.'v.\+', -1)
"autocmd VimEnter *.c,*.h,*.m,*.cxx,*.hxx,*.cc,*.hh,*.C,*.H,*.cpp,*.hpp,*.java call matchadd('ErrorMsg', '^[ ]\+if.\+[^{|&]$', -1)
" Highlight whitespace at end of line as erroneous.
autocmd VimEnter * call matchadd('ErrorMsg', '[ \t]\+$')

autocmd VimEnter ~/src/* call AlternativeTabSettings()

" Open NERDTree automatically when vim starts up if no files were specified.
" autocmd vimenter * if !argc() | NERDTree | endif

" Quit if NERDTree is the only remaining window
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set t_Co=256
let g:Powerline_symbols = 'fancy'

call pathogen#infect()
