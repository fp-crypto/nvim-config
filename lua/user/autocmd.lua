vim.cmd [[

  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  augroup END

  augroup _yaml
    autocmd!
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  augroup END

  augroup _solidity
    autocmd!
    autocmd BufNewFile,BufRead *.sol setlocal ts=4 sts=4 sw=4 expandtab
  augroup END

]]
