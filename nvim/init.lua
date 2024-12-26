-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 啟用游標行
vim.opt.cursorline = true

-- 設置高亮顏色
vim.cmd("highlight CursorLine guibg=#484891")
vim.cmd("highlight CursorLineNr guifg=#9AFF02")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
