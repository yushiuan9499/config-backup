vim.keymap.set("v", "<leader>dw", ":lua require('dapui').elements.watches.add(vim.fn.expand('<cword'))<CR>")
vim.keymap.set("n", "<leader>dw", ":lua require('dapui').elements.watches.add(vim.fn.input('Watch Expression: '))<CR>")
return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    keys = {
    -- add a keymap to browshttps://github.com/cmu-db/bustub.gite plhttps://github.com/cmu-db/bustub.gitugin files
    -- stylua: ignore
    {
        "<f5>",
        function()
            local dap = require("dap")
            if vim.fn.expand("%:e") == "cpp" and dap.session() == nil then
                vim.cmd("!g++ -g % -o %<")
            end
            dap.continue()
        end,
        desc = "launch/continue gdb",
    },
      {
        "<f9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "toggle breakpoint",
      },
      {
        "<f10>",
        function()
          require("dap").step_over()
        end,
        desc = "step over",
      },
      {
        "<f11>",
        function()
          require("dap").step_into()
        end,
        desc = "step into",
      },
      {
        "<C-f11>",
        function()
          require("dap").step_out()
        end,
        desc = "step out",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "open repl",
      },
      {
        "<leader>dq",
        function()
          require("dap").terminate()
        end,
        desc = "terminate",
      },
    },
    config = function()
      local dap = require("dap")
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "/home/yushiuan9499/.vscode/extensions/ms-vscode.cpptools-1.22.11-linux-x64/debugAdapters/bin/OpenDebugAD7",
        options = {
          detached = false,
        },
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = vim.fn.expand("%:p:r"),
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
          externalConsole = true,
          MIMode = "gdb",
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "enable pretty printing",
              ignoreFailures = false,
            },
          },
          console = "externalConsole",
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    opts = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      return {
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)
        filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
        -- Experimental Features:
        virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
      }
    end,
  },
}
