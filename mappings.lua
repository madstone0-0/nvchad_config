local M = {}

local function quickfix()
  local ft = vim.bo.filetype
  if ft == "qf" then
    vim.cmd "cclose"
  else
    vim.cmd "copen"
  end
end

local function make()
  local src_path = vim.fn.expand "%:p:~"
  local src_noext = vim.fn.expand "%:t:r"
  local root = vim.fn.expand "%:p:h:h:h:~"
  local build_path = root .. "/build/"

  local compiler = { "g++", "clang++" }
  -- local flags = { "-g", "-std=c++17", "-fconcepts", "-std=c++20" }
  -- local flags = { "-g", "-std=c++20", "-fconcepts", "-fconcepts-diagnostics-depth=2" }
  local flags = { "-g", "-Wall", "-std=c++20", "-I./src/_includes/", "-I./src/" }
  -- local command = string.format(
  --   "silent exec '!%s %s %s -o %s &> build.log &'",
  --   compiler[1],
  --   table.concat(flags, " "),
  --   src_path,
  --   build_path .. src_noext
  -- )

  -- local command = string.format(
  --   "silent call system ('cd %s && (CXX=%s cmake .. && make -j4 &> %s/build.log)&')",
  --   build_path,
  --   compiler[1],
  --   root
  -- )

  -- local command = "mkdir -p build; CXX=g++ cmake -S . -B build && (make -j4 -C ./build &> ./build.log) &"
  local command =
    "mkdir -p build; CXX=clang++ cmake -G 'Ninja' -S . -B build && (ninja -C ./build &> ./build.log && echo Done) &"

  print(command)
  if vim.fn.expand "%:e" == "cpp" then
    vim.opt.makeprg = command
  end

  vim.api.nvim_command("AsyncRun -cwd=<root> " .. vim.opt.makeprg.get(vim.opt.makeprg))
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

local function lsp_lines()
  require("lsp_lines").toggle()
  vim.diagnostic.config { virtual_lines = { only_current_line = true } }
end

M.disabled = {
  n = {
    ["<C-c>"] = "",
  },
}

M.short = {
  n = {
    -- ["<Esc>"] = { ":noh <CR>", "clear highlights", silent = true },
    ["<C-A-s>"] = { "<cmd> noautocmd w<CR>", "Save without formatting", silent = true },
    ["<C-A-c>"] = { "<cmd> qall <CR>", "Close all" },
    ["<leader>rg"] = { "<cmd> :Telescope live_grep<CR>", "Search with rg", silent = true },
    ["<leader>tk"] = { "<cmd> :Telescope keymaps<CR>", "Keymaps", silent = true },
    -- ["<leader>la"] = { "<cmd> :Telescope lazy<CR>", "Lazy", silent = true, noremap = true },
    ["<leader>fm"] = {
      function()
        require("conform").format { async = true, lsp_fallback = true }
      end,
      "Format",
      silent = true,
    },
    ["<leader>x"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
      silent = true,
    },
    ["<leader>tn"] = { "<cmd> :tabnew <CR>", "New tab" },
    ["<leader>uu"] = { "<cmd> :NvChadUpdate <CR>", "Update NvChad" },
    ["<leader>ss"] = {
      function()
        -- require("lsp_signature").toggle_float_win()
        vim.lsp.buf.signature_help()
      end,
      "Toggle Signature",
      silent = true,
    },

    ["<C-A-.>"] = {
      function()
        require("nvchad.tabufline").move_buf(1)
      end,
      "Move buf to the right",
      noremap = true,
    },
    ["<C-A-,>"] = {
      function()
        require("nvchad.tabufline").move_buf(-1)
      end,
      "Move buf to the left",
      noremap = true,
    },

    ["<up>"] = { "<cmd> :resize -2<CR>", noremap = true },
    ["<down>"] = { "<cmd> :resize +2<CR>", noremap = true },
    ["<left>"] = { "<cmd> :vertical resize -2<CR>", noremap = true },
    ["<right>"] = { "<cmd> :vertical resize +2<CR>", noremap = true },
    -- [";"] ={ ":", "enter cmdline", opts = { nowait = true } },

    ["<leader>ra"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "Rename",
    },
    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "Goto definition",
    },
    ["<leader>ws"] = {
      function()
        vim.lsp.buf.workspace_symbol ""
      end,
      "Workspace symbol",
    },

    ["gh"] = { "<cmd>Lspsaga lsp_finder<CR>" },
    ["gp"] = { "<cmd>Lspsaga peek_definition<CR>" },
    -- ["gt"] = { "<cmd>Lspsaga peek_type_definition<CR>" },
    ["<leader>cv"] = { "<cmd>Lspsaga outline<CR>" },
    -- ["K"] = { "<cmd>Lspsaga hover_doc<CR>" },
    -- ["<leader>ca"] = { "<cmd>Lspsaga code_action<CR>" },
    ["<leader>cf"] = {
      function()
        quickfix()
        -- if vim.fn.getwininfo().quickfix == 0 then
        --   vim.cmd "cclose"
        -- else
        --   vim.cmd "copen"
        -- end
      end,
      "Toggle quickfix",
    },

    ["<leader>ll"] = {
      function()
        lsp_lines()
      end,
      "Toggle lsp_lines",
    },
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
    ["<leader>ct"] = { "<cmd> :ColorizerToggle <CR>", "Toggle colorizer", silent = true },
    -- ["<leader>x"] = { "<cmd> :BufDel <CR>", "BufDel", noremap = false },
    ["<F5>"] = { "<cmd> DapContinue <CR>", "Debugger continue" },
    ["<leader>dR"] = {
      function()
        require("dap").run_to_cursor()
      end,
      "Debugger run to cursor",
    },
    ["<leader>de"] = {
      function()
        require("dapui").eval(vim.fn.input "[Expression] > ")
      end,
      "Debugger Evaluate Input",
    },
    ["<leader>dx"] = {
      function()
        require("dap").terminate()
      end,
      "Debugger terminate",
    },
    ["<leader>dj"] = {
      function()
        require("dap").load_launchjs()
      end,
    },
    ["<F10>"] = { "<cmd> DapStepOver <CR>", "Debugger step over" },
    ["<F9>"] = { "<cmd> DapStepInto <CR>", "Debugger step into" },
    ["<F12>"] = { "<cmd> DapStepOut <CR>", "Debugger step out" },
    -- ["<leader>tb"] = { "<cmd> DapToggleBreakpoint <CR>", "Debugger toggle breakpoint" },
    ["<leader>tb"] = { "<cmd> PBToggleBreakpoint <CR>", "Debugger toggle breakpoint" },
    ["<leader>dc"] = { "<cmd> PBSetConditionalBreakpoint <CR>", "Debugger set conditional breakpoint" },
    ["<leader>da"] = { "<cmd> PBClearAllBreakpoints <CR>", "Debugger clear all breakpoints" },
    ["<leader>dr"] = { "<cmd> DapToggleRepl <CR>", "Debugger toggle repl" },
    ["<leader>dl"] = {
      function()
        require("dap").run_last()
      end,
      "Debugger run last config",
    },
    ["<leader>du"] = {
      function()
        require("dapui").toggle()
      end,
      "Toggle dap ui",
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

    ["<leader>co"] = {
      function()
        make()
      end,
      "Make",
      slient = true,
      noremap = false,
    },
    ["<leader>ob"] = { "<cmd> OverseerRun <CR>", "Run tasks" },
    ["<leader>ot"] = { "<cmd> OverseerToggle <CR>", "Toggle Overseer" },

    ["<leader>q"] = {
      "<cmd> :TroubleToggle document_diagnostics<CR>",
      "TroubleToggle",
      silent = true,
    },
    ["<leader>qf"] = {
      "<cmd> :TroubleToggle quickfix<CR>",
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

    ["<leader>gb"] = { "<cmd> Gitsigns toggle_current_line_blame <CR>", "Toggle git blame", silent = true },
    ["<leader>go"] = {
      function()
        require("neogit").open { kind = "split" }
      end,
      "Neogit Open",
    },

    ["<leader>gc"] = {
      function()
        require("neogit").open { "commit" }
      end,
      "Neogit Commits",
    },
  },

  v = {
    ["<leader>ca"] = { "<cmd>Lspsaga code_action<CR>" },
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
