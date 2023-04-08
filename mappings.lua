local M = {}

local function compile_cpp()
  local src_path = vim.fn.expand "%:p:~"
  local src_noext = vim.fn.expand "%:t:r"
  local build_path = vim.fn.expand "%:p:h:h:h:~" .. "/build/"

  local _flag = "-g"
  local command = string.format("silent exec '!g++ %s %s -o %s >> build.log'", _flag, src_path, build_path .. src_noext)

  print(command)
  if vim.fn.expand "%:e" == "cpp" then
    vim.api.nvim_command(command)
  else
    print "Not C++ source file"
  end
end

M.short = {
  n = {
    ["<C-A-c>"] = { "<cmd> qall <CR>", "Close all" },
    ["<leader>rg"] = { "<cmd> :Rg <CR>", "Search with rg", silent = true },
    -- ["<leader>s"] = { string.format("<cmd> :source %s<CR>", vim.fn.stdpath "config" .. "/init.lua"), silent = true },
    ["<up>"] = { "<cmd> :resize -2<CR>", noremap = true },
    ["<down>"] = { "<cmd> :resize +2<CR>", noremap = true },
    ["<left>"] = { "<cmd> :vertical resize -2<CR>", noremap = true },
    ["<right>"] = { "<cmd> :vertical resize +2<CR>", noremap = true },
    [";"] = { ":", "enter cmdline", opts = { nowait = true } },

    ["<leader>ll"] = { require("lsp_lines").toggle, "Toggle lsp_lines" },
    ["<leader>lg"] = { "<cmd> :Legendary <CR>", "Legendary", silent = true },
    ["<leader>pr"] = { "<Plug>MarkdownPreview", silent = true },
    ["<leader>ul"] = { "<cmd> :UltiSnipsEdit! <CR>", "Edit snippets", silent = true },
    ["<leader>tc"] = { "<cmd> :Telescope <CR> ", "Telescope window" },
    ["<leader>tt"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "toggle transparency",
    },
    -- ["<leader>x"] = { "<cmd> :BufDel <CR>", "BufDel", noremap = false },
    ["<F5>"] = { "<cmd> DapContinue <CR>", "Debugger continue" },
    ["<F10>"] = { "<cmd> DapStepOver <CR>", "Debugger step over" },
    ["<F9>"] = { "<cmd> DapStepInto <CR>", "Debugger step into" },
    ["<F12>"] = { "<cmd> DapStepOut <CR>", "Debugger step out" },
    ["<leader>tb"] = { "<cmd> DapToggleBreakpoint <CR>", "Debugger toggle breakpoint" },
    ["<leader>dr"] = { "<cmd> DapToggleRepl <CR>", "Debugger toggle repl" },
    ["<leader>dl"] = {
      function()
        require("dap").run_last()
      end,
      "Debugger run last config",
    },
    ["<leader>dh"] = {
      function()
        require("dap.ui.widgets").hover()
      end,
      "Debugger ui hover",
    },
    ["<leader>dt"] = { "<cmd>DapTerminate <CR>", "Debugger terminate" },
    ["<leader>te"] = {
      function()
        require("neotest").run.run { strategy = "dap" }
      end,
      "Test nearest",
    },

    ["<leader>oj"] = { "<cmd> :FSSplitBelow<CR>", "FSSplitBelow" },
    ["<leader>cv"] = { "<cmd> :Vista!!<CR>", "Vista!!" },

    ["<leader>co"] = {
      function()
        compile_cpp()
      end,
      "Compile cpp",
      slient = true,
      noremap = false,
    },

    -- ["<leader>t"] = { "<cmd> :TroubleToggle<CR>", "TroubleToggle", silent = true, noremap = true },
    ["<leader>q"] = {
      "<cmd> :TroubleToggle workspace_diagnostics<CR>",
      "TroubleToggle",
      silent = true,
    },

    ["<leader>rr"] = { "<cmd> :RunCode<CR>", "Run Code", slient = true },
    ["<leader>cr"] = { "<cmd> :VimtexCompile <CR>", "Compile latex", silent = true },

    ["<leader>un"] = { "<cmd> :UndotreeToggle<CR>", "Toggle undo tree", silent = true },

    ["<F3>"] = { "<cmd> :set spell!<CR>", "Toggle spell check" },
  },

  i = {
    ["<C-l>"] = { "<c-g>u<Esc>[s1z=`]a<c-g>u", "Spell check" },
    ["jj"] = { "<Esc>", "Escape" },
  },
}

return M
