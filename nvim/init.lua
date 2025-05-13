-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- 啟用游標行
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true

-- 設置高亮顏色
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#484891" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#9AFF02", bold = true })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#5A6090" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#5A6090" })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "#796DAA" })
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=2")
vim.cmd("let g:ftplugin_sql_omni_key = '<C-x><C-o>'")
--- 為了讓CopilotChat.nvim能在nvim 0.11.1工作
vim.opt.completeopt:append({ "popup" })
