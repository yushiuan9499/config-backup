-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sql",
  callback = function()
    -- find settings in cwd
    local settings = read_json_file(vim.fn.getcwd() .. "/sql_setting.json")
    if settings then
      require("lspconfig").sqls.setup({
        settings = {
          sqls = {
            connections = {
              {
                driver = "sqlite3",
                dataSourceName = settings["database"][vim.fn.expand("%:.")], -- 使用輸入的資料庫路徑
              },
            },
          },
        },
      })
    end
  end,
})
