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
function! s:get_grepcmd() abort
  if executable('rg')
    let grepcmd = 'rg --vimgrep '
  elseif executable('ag')
    let grepcmd = 'ag -s --vimgrep '
  elseif executable('grep')
    let grepcmd = 'grep -HnIr '
    echomsg 'using GNU grep; install rg or ag for better performance'
  else
    let grepcmd = ''
    echoerr 'no supported grepping tools found; please install rg or ag'
  endif 
  return grepcmd
endfunction



" ------------------------------
" Runtimepath
" ------------------------------

function! s:get_runtimepaths() abort
  return substitute(s:capture_command('echon &runtimepath'), ',', ' ', 'g')
endfunction

function! greprtpscr#GrepRtp(pattern) abort
  let grepcmd = s:get_grepcmd()
  let rtpdirs = s:get_runtimepaths()
  let fullcmd = grepcmd . a:pattern . ' ' . rtpdirs
  let grepres = systemlist(fullcmd)
  call filter(grepres, 'v:val =~# "\\.vim"')
  " TODO: filter for .vim (i.e. with literal dot)
  execute 'lgetexpr grepres | lopen'
endfunction



" ------------------------------
" Scriptnames
" ------------------------------

" Adapted from tpope's scriptease#scriptnames_qflist()
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
  let grepcmd = s:get_grepcmd()
  let scripts = s:get_scripts()
  let fullcmd = grepcmd . a:pattern . ' ' . scripts
  let grepres= systemlist(fullcmd)
  execute 'lgetexpr grepres | lopen'
endfunction
