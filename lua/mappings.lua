require "nvchad.mappings"
local utils = require "utils"
local map = vim.keymap.set
local run = vim.api.nvim_command

local function quickfix()
    local ft = vim.bo.filetype
    if ft == "qf" then
        vim.cmd "cclose"
    else
        vim.cmd "copen"
    end
end

local makeExts = { "cpp", "go", "c" }

local function make(silent)
    local command = "./build.sh debug yes"

    -- If build_cmd.txt exists in the current dir use that
    local build_cmd_file = vim.fn.expand "./build_cmd.txt"
    if vim.fn.filereadable(build_cmd_file) == 1 then
        command = vim.fn.readfile(build_cmd_file)[1]
    end

    local ext = vim.fn.expand "%:e"
    if utils.findStringInTable(ext, makeExts) then
        vim.opt.makeprg = command
    end

    if silent == false then
        vim.api.nvim_command("AsyncRun " .. vim.opt.makeprg.get(vim.opt.makeprg))
    else
        vim.api.nvim_command("AsyncRun -silent " .. vim.opt.makeprg.get(vim.opt.makeprg))
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

local keymaps = {
    -- [[ Normal mode]]
    n = {
        {
            map = "<C-c>",
            cmd = "",
            opts = {},
        },
        {
            map = "<C-A-s>",
            cmd = "<cmd> noautocmd w<CR>",
            opts = { desc = "Save without formatting", silent = true },
        },
        {
            map = "<C-A-c>",
            cmd = function()
                vim.cmd "qall"
            end,
            opts = { desc = "Close all" },
        },
        {
            map = "<leader>sp",
            cmd = "<cmd> :vsplit<CR>",
            opts = { desc = "Split Vert" },
        },
        {
            map = "<leader>sph",
            cmd = "<cmd> :split<CR>",
            opts = { desc = "Split Hor" },
        },
        {
            map = "<leader>rg",
            cmd = "<cmd> :Telescope live_grep<CR>",
            opts = { desc = "Search with rg", silent = true },
        },
        {
            map = "<leader>tk",
            cmd = "<cmd> :Telescope keymaps<CR>",
            opts = { desc = "Keymaps", silent = true },
        },
        {
            map = "<leader>fm",
            cmd = function()
                require("conform").format { async = true, lsp_fallback = true }
            end,
            opts = { desc = "Format", silent = true },
        },
        {
            map = "<leader>x",
            cmd = function()
                require("nvchad.tabufline").close_buffer()
            end,
            opts = { desc = "Close buffer", silent = true },
        },
        {
            map = "<leader>tn",
            cmd = "<cmd> :tabnew <CR>",
            opts = { desc = "New tab" },
        },
        {
            map = "<leader>uu",
            cmd = "<cmd> :Lazy  sync <CR>",
            opts = { desc = "Update" },
        },
        {
            map = "<leader>ss",
            cmd = function()
                vim.lsp.buf.signature_help()
            end,
            opts = { desc = "Toggle Signature", silent = true },
        },
        {
            map = "<C-A-.>",
            cmd = function()
                require("nvchad.tabufline").move_buf(1)
            end,
            opts = { desc = "Move buf to the right", noremap = true },
        },
        {
            map = "<C-A-,>",
            cmd = function()
                require("nvchad.tabufline").move_buf(-1)
            end,
            opts = { desc = "Move buf to the left", noremap = true },
        },
        {
            map = "<up>",
            cmd = "<cmd> :resize -2<CR>",
            opts = { noremap = true },
        },
        {
            map = "<down>",
            cmd = "<cmd> :resize +2<CR>",
            opts = { noremap = true },
        },
        {
            map = "<left>",
            cmd = "<cmd> :vertical resize -2<CR>",
            opts = { noremap = true },
        },
        {
            map = "<right>",
            cmd = "<cmd> :vertical resize +2<CR>",
            opts = { noremap = true },
        },
        {
            map = "<leader>ra",
            cmd = function()
                vim.lsp.buf.rename()
            end,
            opts = { desc = "Rename" },
        },
        {
            map = "gd",
            cmd = function()
                vim.lsp.buf.definition()
            end,
            opts = { desc = "Goto definition" },
        },
        {
            map = "<leader>ws",
            cmd = function()
                vim.lsp.buf.workspace_symbol ""
            end,
            opts = { desc = "Workspace symbol" },
        },
        {
            map = "gh",
            cmd = "<cmd>Lspsaga lsp_finder<CR>",
            opts = {},
        },
        {
            map = "gp",
            cmd = "<cmd>Lspsaga peek_definition<CR>",
            opts = {},
        },
        {
            map = "<leader>cv",
            cmd = "<cmd>AerialToggle!<CR>",
            opts = { desc = "Outline" },
        },
        {
            map = "<leader>cf",
            cmd = function()
                quickfix()
            end,
            opts = { desc = "Toggle quickfix" },
        },
        {
            map = "<leader>ll",
            cmd = function()
                vim.g.virtual_lines.current_line = not vim.g.virtual_lines.current_line
                vim.diagnostic.config { virtual_text = false, virtual_lines = vim.g.virtual_lines }
            end,
            opts = { desc = "Toggle lsp_lines" },
        },
        {
            map = "<leader>pr",
            cmd = function()
                preview()
            end,
            opts = { desc = "Preview notes" },
        },
        {
            map = "<leader>ul",
            cmd = "<cmd> :UltiSnipsEdit! <CR>",
            opts = { desc = "Edit snippets", silent = true },
        },
        {
            map = "<leader>tc",
            cmd = "<cmd> :Telescope <CR> ",
            opts = { desc = "Telescope window" },
        },
        {
            map = "<leader>tt",
            cmd = function()
                require("base46").toggle_transparency()
            end,
            opts = { desc = "toggle transparency" },
        },
        -- {
        --     map = "<leader>ct",
        --     cmd = "<cmd> :ColorizerToggle <CR>",
        --     opts = { desc = "Toggle colorizer", silent = true },
        -- },
        {
            map = "<F5>",
            cmd = "<cmd> DapContinue <CR>",
            opts = { desc = "Debugger continue" },
        },
        {
            map = "<leader>dR",
            cmd = function()
                require("dap").run_to_cursor()
            end,
            opts = { desc = "Debugger run to cursor" },
        },
        {
            map = "<leader>de",
            cmd = function()
                require("dap-view").eval(vim.fn.input "[Expression] > ")
                -- require("dapui").eval(vim.fn.input "[Expression] > ")
            end,
            opts = { desc = "Debugger Evaluate Input" },
        },
        {
            map = "<leader>dx",
            cmd = function()
                require("dap").terminate()
            end,
            opts = { desc = "Debugger terminate" },
        },
        {
            map = "<leader>dj",
            cmd = function()
                require("dap").load_launchjs()
            end,
            opts = {},
        },
        {
            map = "<F10>",
            cmd = "<cmd> DapStepOver <CR>",
            opts = { desc = "Debugger step over" },
        },
        {
            map = "<F9>",
            cmd = "<cmd> DapStepInto <CR>",
            opts = { desc = "Debugger step into" },
        },
        {
            map = "<F12>",
            cmd = "<cmd> DapStepOut <CR>",
            opts = { desc = "Debugger step out" },
        },
        {
            map = "<leader>tb",
            cmd = "<cmd> PBToggleBreakpoint <CR>",
            opts = { desc = "Debugger toggle breakpoint" },
        },
        {
            map = "<leader>dc",
            cmd = "<cmd> PBSetConditionalBreakpoint <CR>",
            opts = { desc = "Debugger set conditional breakpoint" },
        },
        {
            map = "<leader>da",
            cmd = "<cmd> PBClearAllBreakpoints <CR>",
            opts = { desc = "Debugger clear all breakpoints" },
        },
        {
            map = "<leader>dr",
            cmd = "<cmd> DapToggleRepl <CR>",
            opts = { desc = "Debugger toggle repl" },
        },
        {
            map = "<leader>dl",
            cmd = function()
                require("dap").run_last()
            end,
            opts = { desc = "Debugger run last config" },
        },
        {
            map = "<leader>du",
            cmd = function()
                require("dap-view").toggle()
                -- require("dapui").toggle()
            end,
            opts = { desc = "Toggle dap ui" },
        },
        {
            map = "<leader>dh",
            cmd = function()
                require("dap.ui.widgets").hover()
            end,
            opts = { desc = "Debugger ui hover" },
        },
        {
            map = "<leader>dt",
            cmd = "<cmd>DapTerminate <CR>",
            opts = { desc = "Debugger terminate" },
        },
        {
            map = "<leader>te",
            cmd = function()
                require("neotest").run.run { strategy = "dap" }
            end,
            opts = { desc = "Test nearest" },
        },
        {
            map = "<leader>ta",
            cmd = function()
                require("neotest").run.run(vim.fn.expand "%")
            end,
            opts = { desc = "Test current file" },
        },
        {
            map = "<leader>ts",
            cmd = function()
                require("neotest").run.stop()
            end,
            opts = { desc = "Stop test" },
        },
        {
            map = "<leader>tp",
            cmd = function()
                require("neotest").output.open()
            end,
            opts = { desc = "Show results for nearest" },
        },
        {
            map = "<leader>to",
            cmd = function()
                require("neotest").output_panel.toggle()
            end,
            opts = { desc = "Toggle test output panel" },
        },
        {
            map = "<leader>tm",
            cmd = function()
                require("neotest").summary.toggle()
            end,
            opts = { desc = "Toggle test summary" },
        },
        {
            map = "<leader>oj",
            cmd = "<cmd> :FSSplitBelow<CR>",
            opts = { desc = "FSSplitBelow" },
        },
        {
            map = "<leader>oc",
            cmd = "<cmd> :ClangdSwitchSourceHeader<CR>",
            opts = { desc = "Switch between C++ source and header files" },
        },
        {
            map = "<leader>co",
            cmd = function()
                make(false)
            end,
            opts = { desc = "Make", silent = true, noremap = false },
        },
        {
            map = "<leader>cos",
            cmd = function()
                make(true)
            end,
            opts = { desc = "Make", silent = true, noremap = false },
        },
        -- {
        --     map = "<leader>ob",
        --     cmd = "<cmd> OverseerRun <CR>",
        --     opts = { desc = "Run tasks" },
        -- },
        -- {
        --     map = "<leader>ot",
        --     cmd = "<cmd> OverseerToggle <CR>",
        --     opts = { desc = "Toggle Overseer" },
        -- },
        {
            map = "<leader>q",
            cmd = "<cmd> :Trouble diagnostics toggle filter.buf=0<CR>",
            opts = { desc = "Trouble Toggle Diagnostics", silent = true },
        },
        {
            map = "<leader>qf",
            cmd = "<cmd> :Trouble qflist toggle<CR>",
            opts = { desc = "Trouble Toggle Quickfix", silent = true },
        },
        {
            map = "<leader>qt",
            cmd = "<cmd> :Trouble todo toggle filter.buf=0<CR>",
            opts = { desc = "Trouble Toggle Todo", silent = true },
        },
        {
            map = "<leader>rr",
            cmd = "<cmd> :RunCode<CR>",
            opts = { desc = "Run Code", silent = true },
        },
        {
            map = "<leader>un",
            cmd = "<cmd> :UndotreeToggle<CR>",
            opts = { desc = "Toggle undo tree", silent = true },
        },
        {
            map = "<leader>ps",
            cmd = function()
                require("persistence").load { last = true }
            end,
            opts = { desc = "Restore session" },
        },
        {
            map = "<leader>pl",
            cmd = function()
                require("persistence").load { last = true }
            end,
            opts = { desc = "Restore last session" },
        },
        {
            map = "<leader>pd",
            cmd = function()
                require("persistence").stop()
            end,
            opts = { desc = "Don't restore session" },
        },
        {
            map = "<F3>",
            cmd = function()
                vim.cmd "setlocal spell!"
                vim.cmd "setlocal complete+=kspell!"
            end,
            opts = { desc = "Toggle spell check" },
        },
        -- {
        --     map = "<C-w>z",
        --     cmd = "<cmd> WindowsMaximize<CR>",
        --     opts = {},
        -- },
        -- {
        --     map = ">C-w>_",
        --     cmd = "<cmd> WindowsMaximizeVertically<CR>",
        --     opts = {},
        -- },
        -- {
        --     map = "<C-w>|",
        --     cmd = "<cmd> WindowsMaximizeHorizontally<CR>",
        --     opts = {},
        -- },
        -- {
        --     map = "<C-w>=",
        --     cmd = "<cmd> WindowsEqualize<CR>",
        --     opts = {},
        -- },
        {
            map = "zR",
            cmd = function()
                require("ufo").openAllFolds()
            end,
            opts = {},
        },
        {
            map = "zM",
            cmd = function()
                require("ufo").closeAllFolds()
            end,
            opts = {},
        },
        {
            map = "<leader>dmo",
            cmd = "<cmd> DiffviewOpen <CR>",
            opts = { desc = "Open diffview" },
        },
        {
            map = "<leader>dmc",
            cmd = "<cmd> DiffviewClose <CR>",
            opts = { desc = "Close diffview" },
        },
        {
            map = "<leader>dmf",
            cmd = "<cmd> DiffviewToggleFiles <CR>",
            opts = { desc = "Toggle files" },
        },
        {
            map = "<leader>gb",
            cmd = "<cmd> Gitsigns toggle_current_line_blame <CR>",
            opts = { desc = "Toggle git blame", silent = true },
        },
        -- {
        --     map = "<leader>go",
        --     cmd = function()
        --         require("neogit").open { kind = "split" }
        --     end,
        --     opts = { desc = "Neogit Open" },
        -- },
        {
            map = "<leader>la",
            cmd = function()
                require("nvchad.term").toggle { pos = "float", id = "fa", cmd = "lazygit && exit" }
            end,
            opts = { desc = "Lazygit open" },
        },
        {
            map = "<leader>gn",
            cmd = function()
                vim.cmd "Neogen"
            end,
            opts = { desc = "Neogen annotation" },
        },
        {
            map = "<leader>rd",
            cmd = function()
                run "AsyncRun ./build.sh debug"
            end,
            opts = { desc = "Run build script" },
        },
        {
            map = "<leader>ee",
            cmd = function()
                utils.CustomPicker("▶︎ AsyncRun/Files", function()
                    -- stream both with fd+compgen so Telescope sorts server‑side
                    return require("telescope.finders").new_oneshot_job({
                        "bash",
                        "-lc",
                        "compgen -c; fd --type f --hidden --exclude .git --max-depth 3",
                    }, { cwd = vim.loop.cwd() })
                end, function(value)
                    vim.cmd("AsyncRun " .. value)
                end)
            end,
            opts = { desc = "Telescope command picker" },
        },
        {
            map = "<leader>ex",
            cmd = function()
                vim.ui.input({
                    prompt = "Run ▶︎ ",
                    default = "echo 'Hello World'",
                    completion = "shellcmd",
                }, function(cmdline)
                    if not cmdline or cmdline == "" then
                        return
                    end
                    vim.cmd("AsyncRun " .. cmdline)
                end)
            end,
        },
        {
            map = "<leader>ca",
            cmd = function()
                vim.lsp.buf.code_action()
            end,
            opts = { desc = "Code Action" },
        },
        {
            map = "<leader>ct",
            cmd = function()
                vim.cmd "Copilot enable"
                vim.cmd "Copilot toggle"
                vim.cmd "Copilot status"
            end,
            opts = { desc = "Toggle Copilot", silent = true },
        },
        {
            map = "<leader>cd",
            cmd = function()
                vim.cmd "Copilot disable"
            end,
            opts = { desc = "Disable Copilot", silent = true },
        },
        {
            map = "<leader>ce",
            cmd = function()
                vim.cmd "Copilot enable"
            end,
            opts = { desc = "Enable Copilot", silent = true },
        },
    },
    -- [[ Insert mode]]
    i = {
        {
            map = "<C-l>",
            cmd = "<c-g>u<Esc>[s1z=]a<c-g>u",
            opts = { desc = "Spell check" },
        },
        {
            map = "<C-u>",
            cmd = "<c-g>u<c-u>",
            opts = {},
        },
        {
            map = "<C-w>",
            cmd = "<c-g>u<c-w>",
            opts = {},
        },
        {
            map = "jj",
            cmd = "<Esc>",
            opts = { desc = "Escape" },
        },
    },
    -- [[ Visual and Select mode]]
    v = {
        {
            map = "<leader>ca",
            cmd = function()
                vim.lsp.buf.code_action()
            end,
            opts = { desc = "Code Action" },
        },
    },
    -- [[ Visual mode]]
    x = {
        {
            map = "p",
            cmd = "P",
            opts = { desc = "Paste without formatting", silent = true, noremap = true },
        },
    },
}

for mode, maps in pairs(keymaps) do
    for _, m in pairs(maps) do
        map(mode, m.map, m.cmd, m.opts)
    end
end
