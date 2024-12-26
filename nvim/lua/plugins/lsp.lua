-- 讀取 JSON 文件的函數
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
-- 在 lua/plugins/lsp.lua 中新增或修改如下內容
return {
  -- 配置 nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    vim.api.nvim_create_user_command("Null", function() end, { nargs = 0 }), -- `nargs = 1` 表示指令需要一個參數
    opts = {
      servers = {
        clangd = {}, -- 配置 clangd 伺服器
        pyright = {}, -- 配置 pyright（示例）
        solidity_ls = {}, -- 配置 solidity_ls 伺服器
        tsserver = {}, -- 配置 typescript-language-server 伺服器
        ltex = {}, -- 配置 ltex 伺服器
        -- 可以根據需要添加其他 LSP 伺服器
      },
      diagnostics = {
        virtual_text = {
          prefix = "", -- 設置虛擬文本的前綴符號
          spacing = 4, -- 設置虛擬文本的間距
          source = "if_many", -- 設置虛擬文本的顯示方式
        },
        underline = true, -- 在錯誤處顯示下劃紅線
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      },
    },
  },

  -- 配置 lsp_signature.nvim 插件，用於函數參數提示
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        hint_enable = true, -- 啟用提示
        floating_window = true, -- 使用浮動視窗顯示參數
        handler_opts = {
          border = "rounded", -- 浮動視窗邊框
        },
      })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },

  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
