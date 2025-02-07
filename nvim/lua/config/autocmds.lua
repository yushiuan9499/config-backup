-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

function _G.read_json_file(file_path)
  local file = io.open(file_path, "r")
  if not file then
    vim.notify(
      "No file named: " .. file_path,
      vim.log.levels.ERROR, -- 使用 ERROR 級別
      { title = "ERROR: file not found" }
    )
    return nil
  end

  local content = file:read("*all")
  file:close()

  -- 使用 vim.json 解析 JSON
  local ok, parsed = pcall(vim.json.decode, content)
  if not ok then
    vim.notify("Cannot parse this file: " .. file_path, vim.log.levels.ERROR, { title = "parsing JSON failed" })
    return nil
  end

  return parsed
end
local sqls_initialized = false
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sql",
  callback = function()
    if sqls_initialized then
      return
    end
    sqls_initialized = true -- 防止重複執行

    local settings = read_json_file(vim.fn.getcwd() .. "/sql_setting.json")
    if settings then
      require("lspconfig").sqls.setup({
        settings = {
          sqls = {
            connections = {
              {
                driver = "sqlite3",
                dataSourceName = settings["database"][vim.fn.expand("%:.")],
              },
            },
          },
        },
      })
    end
  end,
})
-- when the file extension is vh, set syntax to verilog
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.vh",
  callback = function()
    vim.api.nvim_command("set syntax=verilog")
  end,
})
