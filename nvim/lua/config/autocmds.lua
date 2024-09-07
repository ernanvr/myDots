-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("MyColors", { clear = true }),
  command = [[
    highlight BufferLineFill guibg=#000
  ]],
})

vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
  group = vim.api.nvim_create_augroup("tmux", { clear = true }),
  callback = function()
    os.execute("tmux set status off")
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  group = vim.api.nvim_create_augroup("tmux", { clear = true }),
  callback = function()
    os.execute("tmux set status on")
  end,
})

-- if has_key(environ(), 'TMUX')
--   augroup tmux_something
--     autocmd VimResume  * call system('tmux set status off')
--     autocmd VimEnter   * call system('tmux set status off')
--     autocmd VimLeave   * call system('tmux set status on')
--     autocmd VimSuspend * call system('tmux set status on')
--   augroup END
-- endif
