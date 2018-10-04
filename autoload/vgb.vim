" vim et sw=4 sts=4 ts=4
" autoload/vgb.vim

function! s:SetGdbBreakCurLine(del)
	let cur_b = @b
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

	let @b = cur_b
endfunction

function! s:NavigateBreak(is_prev)
	let curbuf = bufwinnr('%')
	let curline = line('.')

	for brtag in g:break_list
		let split_break = split(brtag, '-')
		if split_break[0] == curbuf
			let bline = split_break[1]

			if bline >= curline 
				normal! m`
				
				if a:is_prev == 1
					call cursor(prev_bline, 0)
				else
					call cursor(bline, 0)
				endif
			else
				let prev_bline = bline
			endif
		endif
	endfor
endfunction

function! vgb#add()
	call s:SetGdbBreakCurLine(0)
endfunction

function! vgb#remove()
	call s:SetGdbBreakCurLine(1)
endfunction

function! vgb#next()
	call s:NavigateBreak(0)
endfunction

function! vgb#prev()
	call s:NavigateBreak(1)
endfunction
