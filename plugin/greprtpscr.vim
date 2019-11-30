if exists('g:loaded_greprtpscr')
  finish
endif
let g:loaded_greprtpscr = 1


command! -bar -nargs=1 -count=0 GrepRtp call greprtpscr#GrepRtp(<q-args>)
command! -bar -nargs=1 -count=0 GrepScr call greprtpscr#GrepScr(<q-args>)

" BUG: `:GrepRtp <query>` always produces the following line:
" || /home/jyscao/.SpaceVim/build/vader: No such file or directory (os error 2)
