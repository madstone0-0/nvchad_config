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

local function preview()
  local ft = vim.bo.filetype
  if ft == "markdown" then
    vim.cmd "MarkdownPreview"
  elseif ft == "tex" then
    vim.cmd "VimtexCompile"
  end
end

local function ink_create()
  vim.api.nvim_command "exec '.!inkscape-figures create \"'.getline('.').'\" \"'.b:vimtex.root.'/figures/\"'"
end

local function ink_edit()
  vim.api.nvim_command "exec '!inkscape-figures edit \"'.b:vimtex.root.'/figures/\" > /dev/null 2>&1 &'"
  vim.api.nvim_command ":redraw!"
end

M.short = {
  n = {
    ["<C-A-c>"] = { "<cmd> qall <CR>", "Close all" },
    ["<leader>rg"] = { "<cmd> :Telescope live_grep<CR>", "Search with rg", silent = true },
    ["<leader>tk"] = { "<cmd> :Telescope keymaps<CR>", "Keymaps", silent = true },

    ["<up>"] = { "<cmd> :resize -2<CR>", noremap = true },
    ["<down>"] = { "<cmd> :resize +2<CR>", noremap = true },
    ["<left>"] = { "<cmd> :vertical resize -2<CR>", noremap = true },
    ["<right>"] = { "<cmd> :vertical resize +2<CR>", noremap = true },
    [";"] = { ":", "enter cmdline", opts = { nowait = true } },

    ["<leader>ll"] = {
      function()
        require("lsp_lines").toggle()
      end,
      "Toggle lsp_lines",
    },
    ["<leader>lg"] = { "<cmd> :Legendary <CR>", "Legendary", silent = true },
    ["<leader>pr"] = {
      function()
        preview()
      end,
      "Preview notes",
      -- silent = true,
    },
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
    ["<leader>ta"] = {
      function()
        require("neotest").run.run(vim.fn.expand "%")
      end,
      "Test current file",
    },
    ["<leader>ts"] = {
      function()
        require("neotest").run.stop()
      end,
      "Stop test",
    },
    ["<leader>tp"] = {
      function()
        require("neotest").output.open()
      end,
      "Show results for nearest",
    },
    ["<leader>to"] = {
      function()
        require("neotest").output_panel.toggle()
      end,
      "Toggle test output panel",
    },
    ["<leader>tm"] = {
      function()
        require("neotest").summary.toggle()
      end,
      "Toggle test summary",
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

    ["<leader>q"] = {
      "<cmd> :TroubleToggle workspace_diagnostics<CR>",
      "TroubleToggle",
      silent = true,
    },

    ["<leader>rr"] = { "<cmd> :RunCode<CR>", "Run Code", slient = true },

    ["<leader>un"] = { "<cmd> :UndotreeToggle<CR>", "Toggle undo tree", silent = true },

    ["<leader>ps"] = {
      function()
        require("persistence").load()
      end,
      "Restore session",
    },
    ["<leader>pl"] = {
      function()
        require("persistence").load { last = true }
      end,
      "Restore last session",
    },
    ["<leader>pd"] = {
      function()
        require("persistence").stop()
      end,
      "Don't restore session",
    },

    ["<F3>"] = {
      function()
        vim.cmd "setlocal spell!"
        vim.cmd "setlocal complete+=kspell!"
      end,
      "Toggle spell check",
    },

    ["<C-w>z"] = { "<cmd> WindowsMaximize<CR>" },
    [">C-w>_"] = { "<cmd> WindowsMaximizeVertically<CR>" },
    ["<C-w>|"] = { "<cmd> WindowsMaximizeHorizontally<CR>" },
    ["<C-w>="] = { "<cmd> WindowsEqualize<CR>" },

    ["<C-f>"] = {
      function()
        ink_edit()
      end,
      slient = true,
      noremap = true,
    },

    ["zR"] = {
      function()
        require("ufo").openAllFolds()
      end,
    },
    ["zM"] = {
      function()
        require("ufo").closeAllFolds()
      end,
    },
  },

  i = {
    ["<C-l>"] = { "<c-g>u<Esc>[s1z=`]a<c-g>u", "Spell check" },
    ["<C-u>"] = { "<c-g>u<c-u>" },
    ["<C-w>"] = { "<c-g>u<c-w>" },

    ["jj"] = { "<Esc>", "Escape" },
    ["<C-f>"] = {
      function()
        ink_create()
      end,
      silent = true,
      noremap = true,
    },
  },
}

return M
