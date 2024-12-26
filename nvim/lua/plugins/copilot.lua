return {
  -- 使用本地路徑引用 Copilot 插件
  {
    "github/copilot.vim",
    suggestion = { enabled = true },
    panel = { enabled = true },
    config = function()
      vim.g.copilot_no_tab_map = true -- 禁用 Tab 鍵映射
      vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { expr = true }) -- 使用 Ctrl + j 接受建議
    end,
  },
}
