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
    ["<leader>pr"] = { "<Plug>MarkdownPreview", silent = true },
    ["<leader>ul"] = { "<cmd> :UltiSnipsEdit <CR>", "Edit snippets", silent = true },
    ["<leader>tc"] = { "<cmd> :Telescope <CR> ", "Telescope window" },
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
      "Debugger run las config",
    },
    ["<leader>dh"] = {
      function()
        require("dap.ui.widgets").hover()
      end,
      "Debugger ui hover",
    },
    ["<leader>dt"] = { "<Plug>DapTerminate", "Debugger terminate" },

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

    ["<leader>t"] = { "<cmd> :TroubleToggle<CR>", "TroubleToggle", silent = true, noremap = true },
    ["<leader>q"] = {
      "<cmd> :TroubleToggle workspace_diagnostics<CR>",
      "TroubleToggle",
      silent = true,
    },
  },

  i = {
    ["<C-l>"] = { "<c-g>u<Esc>[s1z=`]a<c-g>u", "Spell check" },
    ["jj"] = { "<Esc>", "Escape" },
  },
}

return M
