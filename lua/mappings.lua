require "nvchad.mappings"
local map = vim.keymap.set

local function quickfix()
    local ft = vim.bo.filetype
    if ft == "qf" then
        vim.cmd "cclose"
    else
        vim.cmd "copen"
    end
end

local function make(silent)
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
    -- local command =
    --     "mkdir -p build; CXX=clang++ cmake -G 'Ninja' -S . -B build && (ninja -C ./build &> ./build.log && echo Done) &"
    local command = "./build.sh"

    print(command)
    if vim.fn.expand "%:e" == "cpp" then
        vim.opt.makeprg = command
    end

    -- local old = vim.g.autochdir
    -- vim.g.autochdir = false
    if silent == false then
        vim.api.nvim_command("AsyncRun " .. vim.opt.makeprg.get(vim.opt.makeprg))
    else
        vim.api.nvim_command("AsyncRun -silent " .. vim.opt.makeprg.get(vim.opt.makeprg))
    end
    -- vim.g.autochdir = old
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

map("n", "<C-c>", "")

-- map("n", "<Esc>", ":noh <CR>", {desc = "clear highlights" , silent = true })
map("n", "<C-A-s>", "<cmd> noautocmd w<CR>", { desc = "Save without formatting", silent = true })
map("n", "<C-A-c>", "<cmd> qall <CR>", { desc = "Close all" })
map("n", "<leader>rg", "<cmd> :Telescope live_grep<CR>", { desc = "Search with rg", silent = true })
map("n", "<leader>tk", "<cmd> :Telescope keymaps<CR>", { desc = "Keymaps", silent = true })
-- map("n", "<leader>la", "<cmd> :Telescope lazy<CR>", {desc = "Lazy" , silent = true, noremap = true })
map("n", "<leader>fm", function()
    require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format", silent = true })
map("n", "<leader>x", function()
    require("nvchad.tabufline").close_buffer()
end, { desc = "Close buffer", silent = true })
map("n", "<leader>tn", "<cmd> :tabnew <CR>", { desc = "New tab" })
map("n", "<leader>uu", "<cmd> :Lazy  sync <CR>", { desc = "Update" })
map("n", "<leader>ss", function()
    vim.lsp.buf.signature_help()
end, { desc = "Toggle Signature", silent = true })

map("n", "<C-A-.>", function()
    require("nvchad.tabufline").move_buf(1)
end, { desc = "Move buf to the right", noremap = true })
map("n", "<C-A-,>", function()
    require("nvchad.tabufline").move_buf(-1)
end, { desc = "Move buf to the left", noremap = true })

map("n", "<up>", "<cmd> :resize -2<CR>", { noremap = true })
map("n", "<down>", "<cmd> :resize +2<CR>", { noremap = true })
map("n", "<left>", "<cmd> :vertical resize -2<CR>", { noremap = true })
map("n", "<right>", "<cmd> :vertical resize +2<CR>", { noremap = true })
-- [";"] ={ ":", "enter cmdline", opts = { nowait = true } },

map("n", "<leader>ra", function()
    vim.lsp.buf.rename()
end, { desc = "Rename" })
map("n", "gd", function()
    vim.lsp.buf.definition()
end, { desc = "Goto definition" })
map("n", "<leader>ws", function()
    vim.lsp.buf.workspace_symbol ""
end, { desc = "Workspace symbol" })

map("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
map("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
-- map("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
map("n", "<leader>cv", "<cmd>Lspsaga outline<CR>")
-- map("n", "K", "<cmd>Lspsaga hover_doc<CR>")
-- map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
map("n", "<leader>cf", function()
    quickfix()
end, { desc = "Toggle quickfix" })

map("n", "<leader>ll", function()
    require("lsp_lines").toggle()
    vim.diagnostic.config { virtual_lines = { only_current_line = true } }
end, { desc = "Toggle lsp_lines" })
map("n", "<leader>pr", function()
    preview()
end, { desc = "Preview notes" })
map("n", "<leader>ul", "<cmd> :UltiSnipsEdit! <CR>", { desc = "Edit snippets", silent = true })
map("n", "<leader>tc", "<cmd> :Telescope <CR> ", { desc = "Telescope window" })
map("n", "<leader>tt", function()
    require("base46").toggle_transparency()
end, { desc = "toggle transparency" })
map("n", "<leader>ct", "<cmd> :ColorizerToggle <CR>", { desc = "Toggle colorizer", silent = true })
-- map("n", "<leader>x", "<cmd> :BufDel <CR>", {desc = "BufDel" , noremap = false })
map("n", "<F5>", "<cmd> DapContinue <CR>", { desc = "Debugger continue" })
map("n", "<leader>dR", function()
    require("dap").run_to_cursor()
end, { desc = "Debugger run to cursor" })
map("n", "<leader>de", function()
    require("dapui").eval(vim.fn.input "[Expression] > ")
end, { desc = "Debugger Evaluate Input" })
map("n", "<leader>dx", function()
    require("dap").terminate()
end, { desc = "Debugger terminate" })
map("n", "<leader>dj", function()
    require("dap").load_launchjs()
end)
map("n", "<F10>", "<cmd> DapStepOver <CR>", { desc = "Debugger step over" })
map("n", "<F9>", "<cmd> DapStepInto <CR>", { desc = "Debugger step into" })
map("n", "<F12>", "<cmd> DapStepOut <CR>", { desc = "Debugger step out" })
-- map("n", "<leader>tb", "<cmd> DapToggleBreakpoint <CR>", {desc = "Debugger toggle breakpoint"  })
map("n", "<leader>tb", "<cmd> PBToggleBreakpoint <CR>", { desc = "Debugger toggle breakpoint" })
map("n", "<leader>dc", "<cmd> PBSetConditionalBreakpoint <CR>", { desc = "Debugger set conditional breakpoint" })
map("n", "<leader>da", "<cmd> PBClearAllBreakpoints <CR>", { desc = "Debugger clear all breakpoints" })
map("n", "<leader>dr", "<cmd> DapToggleRepl <CR>", { desc = "Debugger toggle repl" })
map("n", "<leader>dl", function()
    require("dap").run_last()
end, { desc = "Debugger run last config" })
map("n", "<leader>du", function()
    require("dapui").toggle()
end, { desc = "Toggle dap ui" })
map("n", "<leader>dh", function()
    require("dap.ui.widgets").hover()
end, { desc = "Debugger ui hover" })
map("n", "<leader>dt", "<cmd>DapTerminate <CR>", { desc = "Debugger terminate" })
map("n", "<leader>te", function()
    require("neotest").run.run { strategy = "dap" }
end, { desc = "Test nearest" })
map("n", "<leader>ta", function()
    require("neotest").run.run(vim.fn.expand "%")
end, { desc = "Test current file" })
map("n", "<leader>ts", function()
    require("neotest").run.stop()
end, { desc = "Stop test" })
map("n", "<leader>tp", function()
    require("neotest").output.open()
end, { desc = "Show results for nearest" })
map("n", "<leader>to", function()
    require("neotest").output_panel.toggle()
end, { desc = "Toggle test output panel" })
map("n", "<leader>tm", function()
    require("neotest").summary.toggle()
end, { desc = "Toggle test summary" })

map("n", "<leader>oj", "<cmd> :FSSplitBelow<CR>", { desc = "FSSplitBelow" })

map("n", "<leader>co", function()
    make(false)
end, { desc = "Make", silent = true, noremap = false })
map("n", "<leader>cos", function()
    make(true)
end, { desc = "Make", silent = true, noremap = false })
map("n", "<leader>ob", "<cmd> OverseerRun <CR>", { desc = "Run tasks" })
map("n", "<leader>ot", "<cmd> OverseerToggle <CR>", { desc = "Toggle Overseer" })

map("n", "<leader>q", "<cmd> :Trouble diagnostics toggle<CR>", { desc = "TroubleToggle", silent = true })
map("n", "<leader>qf", "<cmd> :Trouble qflist toggle<CR>", { desc = "TroubleToggle", silent = true })

map("n", "<leader>rr", "<cmd> :RunCode<CR>", { desc = "Run Code", silent = true })

map("n", "<leader>un", "<cmd> :UndotreeToggle<CR>", { desc = "Toggle undo tree", silent = true })

map("n", "<leader>ps", function()
    -- require("persistence").load()
    vim.cmd ":SessionRestore"
end, { desc = "Restore session" })
map("n", "<leader>pl", function()
    require("persistence").load { last = true }
end, { desc = "Restore last session" })
map("n", "<leader>pd", function()
    -- require("persistence").stop()
    vim.cmd ":SessionDelete"
end, { desc = "Don't restore session" })

map("n", "<F3>", function()
    vim.cmd "setlocal spell!"
    vim.cmd "setlocal complete+=kspell!"
end, { desc = "Toggle spell check" })

map("n", "<C-w>z", "<cmd> WindowsMaximize<CR>")
map("n", ">C-w>_", "<cmd> WindowsMaximizeVertically<CR>")
map("n", "<C-w>|", "<cmd> WindowsMaximizeHorizontally<CR>")
map("n", "<C-w>=", "<cmd> WindowsEqualize<CR>")

map("n", "<C-f>", function()
    ink_edit()
end, { silent = true, noremap = true })

map("n", "zR", function()
    require("ufo").openAllFolds()
end)
map("n", "zM", function()
    require("ufo").closeAllFolds()
end)

map("n", "<leader>gb", "<cmd> Gitsigns toggle_current_line_blame <CR>", { desc = "Toggle git blame", silent = true })
map("n", "<leader>go", function()
    require("neogit").open { kind = "split" }
end, { desc = "Neogit Open" })

map("n", "<leader>gc", function()
    require("neogit").open { "commit" }
end, { desc = "Neogit Commits" })

map("n", "<leader>rd", function()
    require("nvchad.term").runner {
        pos = "sp",
        cmd = "./build.sh debug",
        id = "debug",
    }
end, { desc = "Run build script" })

map("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>")

map("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "Spell check" })
map("i", "<C-u>", "<c-g>u<c-u>")
map("i", "<C-w>", "<c-g>u<c-w>")

map("i", "jj", "<Esc>", { desc = "Escape" })
map("i", "<C-f>", function()
    ink_create()
end, { silent = true, noremap = true })

-- Molten
-- map({ "v", "n" }, "<leader>mR", "<Cmd>MoltenEvaluateVisual<CR>")
-- map("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })
-- map("n", "<leader>mp", function()
--     local venv = os.getenv "VIRTUAL_ENV"
--     if venv ~= nil then
--         -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
--         venv = string.match(venv, "/.+/(.+)")
--         vim.cmd(("MoltenInit %s"):format(venv))
--     else
--         vim.cmd "MoltenInit python3"
--     end
-- end, { desc = "Initialize Molten for python3", silent = true, noremap = true })
--
-- local r = require "quarto.runner"
-- map("n", "<leader>mrc", r.run_cell, { desc = "run cell", silent = true })
-- map("n", "<leader>mra", r.run_above, { desc = "run cell and above", silent = true })
-- map("n", "<leader>mrb", r.run_below, { desc = "run cell and below", silent = true })
-- map("n", "<leader>mrl", r.run_line, { desc = "run line", silent = true })
-- map("n", "<leader>mrA", r.run_all, { desc = "run all cells", silent = true })
--
-- map("n", "<leader>me", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
-- map("n", "<leader>mrr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
-- map("v", "<leader>mr", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "execute visual selection", silent = true })
-- map("n", "<leader>mos", ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true })
-- map("n", "<leader>moh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
-- map("n", "<leader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })
-- local open = false
-- map("n", "<leader>mot", function()
--     open = not open
--     vim.fn.MoltenUpdateOption("auto_open_output", open)
-- end)

-- local opts = { noremap = true, silent = true }
--
-- map(
--     "n",
--     "<leader>jos",
--     ":call jukit#splits#output()<CR>",
--     { noremap = true, silent = true, desc = "Open new output window" }
-- )
-- map(
--     "n",
--     "<leader>jts",
--     ":call jukit#splits#term()<CR>",
--     { noremap = true, silent = true, desc = "Open new output window" }
-- )
-- map(
--     "n",
--     "<leader>jhs",
--     ":call jukit#splits#history()<CR>",
--     { noremap = true, silent = true, desc = "Open output-history window" }
-- )
-- map(
--     "n",
--     "<leader>johs",
--     ":call jukit#splits#output_and_history()<CR>",
--     { noremap = true, silent = true, desc = "Open output and history" }
-- )
-- map(
--     "n",
--     "<leader>jhd",
--     ":call jukit#splits#close_history()<CR>",
--     { noremap = true, silent = true, desc = "Close output-history window" }
-- )
-- map(
--     "n",
--     "<leader>jod",
--     ":call jukit#splits#close_output_split()<CR>",
--     { noremap = true, silent = true, desc = "Close output window" }
-- )
-- map(
--     "n",
--     "<leader>johd",
--     ":call jukit#splits#close_output_and_history(1)<CR>",
--     { noremap = true, silent = true, desc = "Close both windows" }
-- )
-- map(
--     "n",
--     "<leader>jso",
--     ":call jukit#splits#show_last_cell_output(1)<CR>",
--     { noremap = true, silent = true, desc = "Show current cell output" }
-- )
-- map(
--     "n",
--     "<leader>j",
--     ":call jukit#splits#out_hist_scroll(1)<CR>",
--     { noremap = true, silent = true, desc = "Scroll down in output-history" }
-- )
-- map(
--     "n",
--     "<leader>k",
--     ":call jukit#splits#out_hist_scroll(0)<CR>",
--     { noremap = true, silent = true, desc = "Scroll up in output-history" }
-- )
-- map(
--     "n",
--     "<leader>jah",
--     ":call jukit#splits#toggle_auto_hist()<CR>",
--     { noremap = true, silent = true, desc = "Toggle auto display of saved output" }
-- )
-- map(
--     "n",
--     "<leader>jsl",
--     ":call jukit#layouts#set_layout()<CR>",
--     { noremap = true, silent = true, desc = "Apply layout to current splits" }
-- )
--
-- map(
--     "n",
--     "<leader>j<space>",
--     ":call jukit#send#section(0)<CR>",
--     { noremap = true, silent = true, desc = "Send current cell code to output split" }
-- )
-- map(
--     "n",
--     "<CR>",
--     ":call jukit#send#line()<CR>",
--     { noremap = true, silent = true, desc = "Send current line to output split" }
-- )
-- map(
--     "v",
--     "<CR>",
--     ":<C-U>call jukit#send#selection()<CR>",
--     { noremap = true, silent = true, desc = "Send visually selected code to output split" }
-- )
-- map(
--     "n",
--     "<leader>jcc",
--     ":call jukit#send#until_current_section()<CR>",
--     { noremap = true, silent = true, desc = "Execute all cells until the current cell" }
-- )
-- map("n", "<leader>jall", ":call jukit#send#all()<CR>", { noremap = true, silent = true, desc = "Execute all cells" })
--
-- map(
--     "n",
--     "<leader>jco",
--     ":call jukit#cells#create_below(0)<CR>",
--     { noremap = true, silent = true, desc = "New code cell below" }
-- )
-- map(
--     "n",
--     "<leader>jcO",
--     ":call jukit#cells#create_above(0)<CR>",
--     { noremap = true, silent = true, desc = "New code cell above" }
-- )
-- map(
--     "n",
--     "<leader>jct", ":call jukit#cells#create_below(1)<CR>",
--     { noremap = true, silent = true, desc = "New text cell below" }
-- )
-- map(
--     "n",
--     "<leader>jcT",
--     ":call jukit#cells#create_above(1)<CR>",
--     { noremap = true, silent = true, desc = "New text cell above" }
-- )
-- map(
--     "n",
--     "<leader>jcd",
--     ":call jukit#cells#delete()<CR>",
--     { noremap = true, silent = true, desc = "Delete current cell" }
-- )
-- map("n", "<leader>jcs", ":call jukit#cells#split()<CR>", { noremap = true, silent = true, desc = "Split current cell" })
-- map(
--     "n",
--     "<leader>jcM",
--     ":call jukit#cells#merge_above()<CR>",
--     { noremap = true, silent = true, desc = "Merge with cell above" }
-- )
-- map(
--     "n",
--     "<leader>jcm",
--     ":call jukit#cells#merge_below()<CR>",
--     { noremap = true, silent = true, desc = "Merge with cell below" }
-- )
-- map("n", "<leader>jck", ":call jukit#cells#move_up()<CR>", { noremap = true, silent = true, desc = "Move cell up" })
-- map("n", "<leader>jcj", ":call jukit#cells#move_down()<CR>", { noremap = true, silent = true, desc = "Move cell down" })
-- map(
--     "n",
--     "<leader>jJ",
--     ":call jukit#cells#jump_to_next_cell()<CR>",
--     { noremap = true, silent = true, desc = "Jump to next cell" }
-- )
-- map(
--     "n",
--     "<leader>jK",
--     ":call jukit#cells#jump_to_previous_cell()<CR>",
--     { noremap = true, silent = true, desc = "Jump to previous cell" }
-- )
-- map(
--     "n",
--     "<leader>jddo",
--     ":call jukit#cells#delete_outputs(0)<CR>",
--     { noremap = true, silent = true, desc = "Delete output of current cell" }
-- )
-- map(
--     "n",
--     "<leader>jdda",
--     ":call jukit#cells#delete_outputs(1)<CR>",
--     { noremap = true, silent = true, desc = "Delete outputs of all cells" }
-- )
--
-- map(
--     "n",
--     "<leader>np",
--     ':call jukit#convert#notebook_convert("jupyter-notebook")<CR>',
--     { noremap = true, silent = true, desc = "Convert from ipynb to py or vice versa" }
-- )
-- map(
--     "n",
--     "<leader>ht",
--     ':call jukit#convert#save_nb_to_file(0,1,"html")<CR>',
--     { noremap = true, silent = true, desc = "Convert file to html and open it" }
-- )
-- map(
--     "n",
--     "<leader>rht",
--     ':call jukit#convert#save_nb_to_file(1,1,"html")<CR>',
--     { noremap = true, silent = true, desc = "Convert file to html (re-run all cells) and open it" }
-- )
-- map(
--     "n",
--     "<leader>pd",
--     ':call jukit#convert#save_nb_to_file(0,1,"pdf")<CR>',
--     { noremap = true, silent = true, desc = "Convert file to pdf and open it" }
-- )
-- map(
--     "n",
--     "<leader>rpd",
--     ':call jukit#convert#save_nb_to_file(1,1,"pdf")<CR>',
--     { noremap = true, silent = true, desc = "Convert file to pdf (re-run all cells) and open it" }
-- )
