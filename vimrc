set background=dark

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
" C indentation - this is instead done with an autocmd
set cindent
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
"case insensitive matching
set ignorecase
"smart matching
set smartcase
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


if has("gui_running")
	set background=light
else
	set background=dark
endif

syn on

let c_syntax_for_h=1
let c_space_errors=1
let c_ansi_constants=1

" hi Identifier guifg=#4080ff
" hi Comment ctermfg=Grey guifg=#800080
" hi Constant ctermfg=DarkCyan guifg=#006090
" hi SpecialChar ctermfg=Cyan cterm=bold guifg=DarkCyan
" hi Delimiter ctermfg=Red cterm=bold guifg=#ff0000 gui=bold
" hi Statement ctermfg=Blue cterm=bold guifg=#0000ff gui=bold
" hi PreProc ctermfg=Grey guifg=#800000
" hi Type ctermfg=DarkGreen guifg=#008000 gui=bold
" hi Todo ctermfg=Yellow ctermbg=Blue cterm=underline,bold gui=underline,bold
" hi Operator ctermfg=Red cterm=bold guifg=#ff0000 gui=bold

" Enable incremental searching and search highlighting.
set incsearch
set hlsearch

au BufNewFile,BufRead *.cxx,*.hxx,*.cc,*.hh,*.C,*.cpp,*.hpp,*.H set cindent

" Ctags FTW
set tags=tags;$HOME
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Perforce commands.
command! -nargs=* -complete=file PEdit :!g4 edit %
command! -nargs=* -complete=file PRevert :!g4 revert %
command! -nargs=* -complete=file PDiff :!g4 diff %

" Useful commands.
command! -nargs=0 CleanWhitespace :%s/\\s\\+$//g

function! s:CheckOutFile()
	if filereadable(expand("%")) && ! filewritable(expand("%"))
		let s:pos = getpos('.')
		let option = confirm("Readonly file, do you want to checkout from p4?"
			\, "&Yes\n&No", 1, "Question")
		if option == 1
			PEdit
		endif
		edit!
		call cursor(s:pos[1:3])
	endif
endfunction
autocmd FileChangedRO * nested :call <SID>CheckOutFile()

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
autocmd VimEnter *.c,*.h,*.m,*.cxx,*.hxx,*.cc,*.hh,*.C,*.H,*.cpp,*.hpp,*.java set tw=80
autocmd VimEnter *.c,*.h,*.m,*.cxx,*.hxx,*.cc,*.hh,*.C,*.H,*.cpp,*.hpp,*.java call matchadd('ErrorMsg', '\%>'.&l:textwidth.'v.\+', -1)
"autocmd VimEnter *.c,*.h,*.m,*.cxx,*.hxx,*.cc,*.hh,*.C,*.H,*.cpp,*.hpp,*.java call matchadd('ErrorMsg', '^[ ]\+if.\+[^{|&]$', -1)
" Highlight whitespace at end of line as erroneous.
autocmd VimEnter * call matchadd('ErrorMsg', '[ \t]\+$')

autocmd VimEnter ~/perforce/* call AlternativeTabSettings()
autocmd VimEnter ~/source/* call AlternativeTabSettings()

call pathogen#infect()
set t_Co=256
let g:Powerline_symbols = 'fancy'
