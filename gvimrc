"se gfn=PragmataPro:h18
se gfn=M+\ 1mn\ regular:h15
"se gfn=Courier:h12

set go-=T
"set bg=dark
"if has("macunix")
"	if &background == "dark"
"		hi normal guibg=black
"		set transp=8
"	endif
"endif

if &diff
	set columns=162
else
	set columns=112
endif
