local opt = vim.opt
local o = vim.o
local g = vim.g
local a = vim.api
local exec = a.nvim_command
local fn = vim.fn
HOME = fn.environ()["HOME"]
vim.loader.enable()

require "autocmds"

local global_options = {
    encoding = "utf-8",
    hidden = true,
    expandtab = true,
    title = true,
    shiftwidth = 4,
    tabstop = 4,
    grepprg = "rg --hidden --iglob '!node_modules/* !.git/*' --vimgrep --smart-case --follow",
    list = true,
    conceallevel = 2,
    thesaurus = "/home/mads/thesaurus/thesaurii.txt",
    timeout = true,
    timeoutlen = 300,
    tag = "./tags",
    termguicolors = true,
    ignorecase = true,
    splitbelow = true,
    splitright = true,
    smartcase = true,
    spelllang = "en_gb",
    undolevels = 5000,
    undofile = true, -- undo even when it closes
    undodir = vim.fn.stdpath "data" .. "/undo_dir",
    cmdheight = 1,
    pumheight = 10,
    smartindent = true,
    swapfile = false,
    updatetime = 300,
    backup = false,
    writebackup = false,
    numberwidth = 2,
    wrap = true,
    linebreak = true,
    scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor
    sidescrolloff = 8,
    whichwrap = "bs<>[]hl",
    history = 5000,
    textwidth = 120,
    autoindent = true,
    cursorline = false,
    guifont = "CaskaydiaCove Nerd Font Mono:h11",
    number = true,
    relativenumber = true,
    mouse = "a",
    signcolumn = "yes",
    inccommand = "split",
    -- statusline = [[%f %y %r %m %=%l/%L %p%%]],

    -- Folding
    -- foldcolumn = "0",
}

g.markdown_fenced_languages = {
    "ts=typescript",
}

local local_options = {
    sessionoptions = "blank,buffers,folds,help,tabpages,winsize,winpos,terminal",
    fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵,diff:-]],
    autochdir = false,

    -- Folding
    foldcolumn = "1",
    foldlevel = 99,
    foldlevelstart = 70,
    foldenable = true,
    foldmethod = "expr",
    foldtext = "",
    foldexpr = "v:lua.vim.treesitter.foldexpr()",
}

local plugin_options = {
    -- Local Leader
    localleader = ",",
    -- Matchup
    -- matchup_matchparen_offscreen = { method = "status" },

    -- Vim Markdown
    mkdp_auto_start = 0,
    vim_markdown_math = 1,
    vim_markdown_folding_disabled = 0,

    -- UltiSnips
    UltiSnipsExpandTrigger = "<A-A>",
    UltiSnipsJumpForwardTrigger = "<tab>",
    UltiSnipsJumpBackwardTrigger = "<s-tab>",
    UltiSnipsEditSplit = "horizontal",
    -- UltiSnipsSnippetDirectories

    -- VimLatex
    tex_flavour = "latex",
    -- vimtex_compiler_method = "latexrun",
    vimtex_compiler_latexmk_engines = {
        _ = "-xelatex",
        -- _ = "-lualatex",
    },
    vimtex_compiler_latexmk = {
        options = {
            "-xelatex",
            -- "-lualatex",
            -- "-pdf",
            "-interaction=nonstopmode",
            "-synctex=1",
            "-file-line-error",
            "-shell-escape",
        },
    },
    vimtex_view_method = "zathura",
    vimtex_quickfix_mode = 0,
    tex_conceal = "abdmgs",

    -- Copilot
    copilot_assume_mapped = true,
    copilot_filetypes = { { "TelescopePrompt", false } },

    -- LuaSnip
    luasnippets_path = string.format("%s/lua/snippets/LuaSnip", fn.stdpath "config"),

    -- Suda
    suda_smart_edit = 1,

    -- Python3
    python3_host_prog = "/home/mads/.pyenv/versions/neovim/bin/python3",

    -- Node.js
    node_host_prog = "/home/mads/.nvm/versions/node/v20.4.0/lib/node_modules/neovim/bin/cli.js",

    -- zip
    loaded_zipPlugin = 0,
    loaded_zip = 0,

    -- AsyncRun
    asyncrun_open = 6,
}

for k, v in pairs(global_options) do
    opt[k] = v
end

for k, v in pairs(local_options) do
    o[k] = v
end

opt.listchars:append "eol:↴,tab:>·,trail:~,extends:>,precedes:<,space:·"
opt.wildignore:append { ".javac", "node_modules", "*.pyc" }
opt.nrformats:append "alpha"
opt.iskeyword:append "-" -- hyphenated words recognized by searches

-- vim.diagnostic.config { virtual_lines = { only_current_line = true } }

local enable_providers = {
    "python3_provider",
    "node_provider",
    -- and so on
}

for _, plugin in pairs(enable_providers) do
    vim.g["loaded_" .. plugin] = nil
    vim.cmd("runtime " .. plugin)
end

vim.cmd "runtime! plugin/rplugin.vim"

for k, v in pairs(plugin_options) do
    g[k] = v
end

exec(
    string.format(
        "let g:UltiSnipsSnippetDirectories=['%s','%s']",
        vim.fn.stdpath "data" .. "/lazy/vim-snippets/UltiSnips/",
        vim.fn.stdpath "config" .. "/lua/snippets/UltiSnips/"
    )
)

for i = 1, 9, 1 do
    vim.keymap.set("n", string.format("<C-S-%s>", i), function()
        a.nvim_set_current_buf(vim.t.bufs[i])
    end)
end

local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match "E5108" then
        return
    end

    if msg:match "warning: multiple different client offset_encodings" then
        return
    end

    notify(msg, ...)
end

-- require("base46").toggle_transparency(true)
vim.schedule(function()
    opt.clipboard = { "unnamed", "unnamedplus" }
    os.execute "python ~/.config/nvim/pywal/chadwal.py &> /dev/null &"

    vim.g.virtual_lines = { current_line = true }

    vim.diagnostic.config {
        virtual_text = false,
        virtual_lines = vim.g.virtual_lines,
        update_in_insert = true,
    }
end)

-- Setup user commands
vim.schedule(function()
    local cmds = require "cmds"
    cmds.setupCmds()
end)
