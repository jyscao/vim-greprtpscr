if exists("g:autoloaded_greprtpscr")
    finish
endif
let g:autoloaded_greprtpscr = 1



" ------------------------------
" Helpers
" ------------------------------

" Copy of tpope's scriptease#capture function
function! s:capture_command(excmd) abort
  try
    redir => out
    exe 'silent! '.a:excmd
  finally
    redir END
  endtry
  return out
endfunction

"NOTE: rg & grep matching is case-sensitive, while ag is case-insensitive by defalt
"NOTE: rg & ag assumes regex pattern by default, grep does not (and its -E flag produces slightly different matches)
function! s:get_grepprg() abort
  if executable('rg')
    let l:search_command = 'rg --vimgrep '
  elseif executable('ag')
    let l:search_command = 'ag -s --vimgrep '
  elseif executable('grep')
    let l:search_command = 'grep -HnIr '
    echomsg 'using GNU grep; install rg or ag for better performance'
  else
    let l:search_command = ''
    echoerr 'no supported grepping tools found; please install rg or ag'
  endif 
  return l:search_command
endfunction



" ------------------------------
" Runtimepath
" ------------------------------

function! s:get_runtimepaths() abort
  return substitute(s:capture_command('echon &runtimepath'), ',', ' ', 'g')
endfunction

function! greprtpscr#GrepRtp(pattern) abort
  let l:grepprg = s:get_grepprg()
  let l:rtp_dirs = s:get_runtimepaths()
  let l:full_command = l:grepprg . a:pattern . '.vim ' . l:rtp_dirs
  let l:result = systemlist(l:full_command)
  execute 'lgetexpr l:result | lopen'
endfunction



" ------------------------------
" Scriptnames
" ------------------------------

function! s:get_scripts() abort
  let names = s:capture_command('scriptnames')
  let scripts = ''
  for line in split(names, "\n")
    if line =~# ':'
      let filename = expand(matchstr(line, ': \zs.*'))
      let scripts .= filename . ' '
    endif
  endfor
  return scripts
endfunction

function! greprtpscr#GrepScr(pattern) abort
  let l:grepprg = s:get_grepprg()
  let l:scripts = s:get_scripts()
  let l:full_command = l:grepprg . a:pattern . ' ' . l:scripts
  let l:result = systemlist(l:full_command)
  execute 'lgetexpr l:result | lopen'
endfunction
