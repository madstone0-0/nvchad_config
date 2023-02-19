local M = {}

M.short = {
  n = {
    ["<C-A-c>"] = { "<cmd> qall <CR>", "Close all" },
    ["<leader>rg"] = { "<cmd> :Rg <CR>", "Search with rg" },
    ["<leader>pr"] = { "<Plug>MarkdownPreview" },
    ["<leader>ul"] = { "<cmd> :UltiSnipsEdit <CR>", "Edit snippets" },
    ["<leader>tc"] = { "<cmd> :Telescope <CR> ", "Telescope window" },
    ["<F5>"] = { "<cmd> DapContinue <CR>", "Debugger continue" },
    ["<F10>"] = { "<cmd> DapStepOver <CR>", "Debugger step over" },
    ["<S-F11>"] = { "<cmd> DapStepInto <CR>", "Debugger step into" },
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
  },

  i = {
    ["<C-l>"] = { "<c-g>u<Esc>[s1z=`]a<c-g>u", "Spell check" },
    ["jj"] = { "<Esc>", "Escape" },
  },
}

return M
