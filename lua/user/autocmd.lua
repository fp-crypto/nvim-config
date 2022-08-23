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
    autocmd FileType solidity setlocal ts=4 sts=4 sw=4 expandtab
  augroup end

  augroup _json
    autocmd!
    autocmd bufnewfile,bufread *.json setlocal conceallevel=0
  augroup end

  augroup _docker
    autocmd!
    autocmd bufnewfile,bufread Dockerfile setlocal conceallevel=0
  augroup end

]]
