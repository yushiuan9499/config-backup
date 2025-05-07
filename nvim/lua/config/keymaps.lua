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
-- 定义运行 SQLite 的逻辑
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
-- 編譯verilog 並執行
vim.api.nvim_set_keymap(
  "n",
  "<leader>cv",
  ':!verilator "%:p" --exe testbench.cpp --cc --build --trace && gnome-terminal -- bash -c "./obj_dir/V%:t:r; exec bash"<CR>',
  { noremap = true, silent = true, desc = "Compile and run verilog file" }
)

-- 用來搜尋選取的文字
function _G.searchSelection()
  -- 取得選取的文字的範圍
  local _, lineS, colS = unpack(vim.fn.getpos("'<"))
  local _, lineE, colE = unpack(vim.fn.getpos("'>"))
  local lines = vim.fn.getline(lineS, lineE)

  -- 如果只有一行的話，就只取選取的範圍
  if #lines == 1 then
    lines[1] = string.sub(lines[1], colS, colE)
  else
    -- 如果有多行的話，就取選取的範圍，並且把第一行和最後一行的文字做修正
    lines[#lines] = string.sub(lines[#lines], 1, colE)
    lines[1] = string.sub(lines[1], colS)
  end
  local query = table.concat(lines, " "):gsub(" ", "+"):gsub("\n", "") -- 把空白換成加號，並且把換行符號去掉
  query = query:gsub('"', '\\"') -- 把雙引號換成跳脫字元
  if query:sub(1, 8) == "https://" or query:sub(1, 7) == "http://" then
    -- 如果是網址的話，就直接開啟網址
    vim.fn.system('firefox --new-tab "' .. query .. '"')
  else
    -- 如果不是網址的話，就用 google 搜尋
    vim.fn.system('firefox --new-tab "https://www.google.com/search?q=' .. query .. '"')
  end
end
vim.api.nvim_set_keymap(
  "v",
  "<leader><CR>",
  ":lua searchSelection()<CR>",
  { noremap = true, silent = true, desc = "Search for selected text in browser" }
)
-- save the copilot chat content
vim.api.nvim_set_keymap(
  "n",
  "<C-s>",
  ':lua vim.ui.input({ prompt = "Enter content to save: " }, function(input) if input and input ~= "" then vim.cmd("CopilotChatSave " .. vim.fn.escape(input, " ")) else vim.notify("Input cannot be empty", vim.log.levels.ERROR) end end)<CR>',
  { noremap = true, silent = true, desc = "Save Copilot Chat content" }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-o>",
  ":CopilotChatLoad ",
  { noremap = true, silent = true, desc = "Load Copilot Chat content" }
)
-- CopilotChatOpen short cut
vim.api.nvim_set_keymap(
  "n",
  "<leader>Gc",
  ":CopilotChatOpen<CR>",
  { noremap = true, silent = true, desc = "Open Copilot Chat" }
)
