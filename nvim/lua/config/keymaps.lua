-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- 編譯並執行 C++ 檔案
vim.api.nvim_set_keymap(
  "n",
  "<leader>cb",
  ':!g++ "%:p" -o "%:p:r" && gnome-terminal -- bash -c ""%:p:r"; exec bash"<CR>',
  { noremap = true, silent = true, desc = "Compile and run C++ file" }
)

-- 直接執行已編譯的 C++ 程式
vim.api.nvim_set_keymap(
  "n",
  "<leader>rc",
  ':!gnome-terminal -- bash -c ""%:p:r"; exec bash"<CR>',
  { noremap = true, silent = true, desc = "Run C++ file" }
)
-- 編譯並執行 Python 檔案
vim.api.nvim_set_keymap(
  "n",
  "<leader>rp",
  ':!gnome-terminal -- bash -c "python3 \\"%:p\\"; exec bash"<CR>',
  { noremap = true, silent = true, desc = "Run Python file" }
)
function _G.run_sqlite()
  local settings = read_json_file(vim.fn.getcwd() .. "/sql_setting.json")
  if settings then
    local sqlite_command = settings["database"][vim.fn.expand("%:.")]
    if sqlite_command ~= "" then
      -- 执行命令
      vim.cmd(
        string.format('!gnome-terminal -- bash -c "sqlite3 %s < %s; exec bash"', sqlite_command, vim.fn.expand("%:p"))
      )
    else
      print("No command entered.")
    end
  end
end
vim.api.nvim_set_keymap(
  "n",
  "<leader>rs",
  ":lua run_sqlite()<CR>",
  { noremap = true, silent = true, desc = "Run sqlite3 file" }
)
-- 定义运行 SQLite 的逻辑
-- 編譯verilog 並執行
vim.api.nvim_set_keymap(
  "n",
  "<leader>cv",
  ':!verilator "%:p" --exe testbench.cpp -cc && make -C obj_dir -j -f V%:t:r.mk V%:t:r && gnome-terminal -- bash -c "./obj_dir/V%:t:r; exec bash"<CR>',
  { noremap = true, silent = true, desc = "Compile and run verilog file" }
)
