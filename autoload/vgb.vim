" vim et sw=4 sts=4 ts=4
" autoload/vgb.vim

function! SetGdbBreakCurLine(del)
	let @b = "b " . expand('%:t') . ":" . line('.')

	let brwin = bufwinnr(g:break_file)
	let curwin = bufwinnr("%")
	let curline = line('.')
	let brtag = curwin . "-" . curline

	if brwin > 0
		if  a:del == 0
			if index(g:break_list, brtag) == -1
				:exe brwin . "wincmd w"
				:exe "%g/" . @b . "/d"
				normal! G
				put b
				w
				:exe curwin . "wincmd w"
				:exe ":sign place " . g:break_id . " line=" . curline . " name=breakLine buffer=" . curwin
				call add(g:break_list, brtag)
				let g:break_id += 1
			endif
		else
			:exe brwin . "wincmd w"
			:exe "%g/" . @b . "/d"
			w
			:exe curwin . "wincmd w"

			let idx = index(g:break_list, brtag)
			if idx != -1
				call remove(g:break_list, idx)
				:exe ":sign unplace" 
			else
				echomsg "brtag not found"
			endif
		endif
	else
		" for now we will require the file to be open
		echoerr g:break_file . " not opened"
	endif
endfunction

function! vgb#add()
	call SetGdbBreakCurLine(0)
endfunction

function! vgb#remove()
	call SetGdbBreakCurLine(1)
endfunction
