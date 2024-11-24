local M = {}

-- local rainbow = require "ts-rainbow"

M.treesitter = {
    ensure_installed = {
        "c",
        "vim",
        "vimdoc",
        "lua",
        "bash",
        "css",
        "javascript",
        "json",
        "html",
        "python",
        "yaml",
        "toml",
        "cpp",
        "markdown",
        "markdown_inline",
        "typescript",
        "tsx",
    },

    highlight = {
        enable = true,
        disable = { "latex" },
        use_languagetree = true,
        additional_vim_regex_highlighting = {
            "haskell",
        },
    },

    matchup = {
        enable = true,
    },

    rainbow = {
        enable = false,
        query = "rainbow-parens",
        -- Highlight the entire buffer all at once
        -- strategy = rainbow.strategy.global,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = 5000, -- Do not enable for files with more than n lines, int
    },

    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
        },
    },
}

M.mason = {
    -- registries = {
    --     "github:nvim-java/mason-registry",
    --     "github:mason-org/mason-registry",
    -- },
    ensure_installed = {
        -- lua
        "lua-language-server",
        "stylua",

        -- webdev
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "eslint_d",
        "prettier",
        "prettierd",
        "json-lsp",
        "yamllint",
        "yamlfmt",
        "rustywind",

        -- shell
        "shfmt",
        "shellcheck",
        "bash-language-server",

        --python
        "black",
        "ruff",
        "python-lsp-server",
        "pyright",
        "ruff-lsp",
        "debugpy",

        -- markdown
        "remark-cli",
        "cbfmt",
        "cspell",
        "marksman",

        -- latex
        "texlab",
        "latexindent",
        "ltex-ls",

        -- c++
        "clang-format",
        "cpptools",

        --rust
        "rust-analyzer",
    },
}

local function on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- BEGIN_DEFAULT_ON_ATTACH
    vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts "CD")
    vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts "Open: In Place")
    vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts "Info")
    vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts "Rename: Omit Filename")
    vim.keymap.set("n", "<C-t>", api.node.open.tab, opts "Open: New Tab")
    vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts "Open: Vertical Split")
    vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts "Open: Horizontal Split")
    vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts "Close Directory")
    vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "<Tab>", api.node.open.preview, opts "Open Preview")
    vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts "Next Sibling")
    vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts "Previous Sibling")
    vim.keymap.set("n", ".", api.node.run.cmd, opts "Run Command")
    vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts "Up")
    vim.keymap.set("n", "a", api.fs.create, opts "Create")
    vim.keymap.set("n", "bmv", api.marks.bulk.move, opts "Move Bookmarked")
    vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts "Toggle No Buffer")
    vim.keymap.set("n", "c", api.fs.copy.node, opts "Copy")
    vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts "Toggle Git Clean")
    vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts "Prev Git")
    vim.keymap.set("n", "]c", api.node.navigate.git.next, opts "Next Git")
    vim.keymap.set("n", "D", api.fs.remove, opts "Delete")
    vim.keymap.set("n", "d", api.fs.trash, opts "Trash")
    vim.keymap.set("n", "E", api.tree.expand_all, opts "Expand All")
    vim.keymap.set("n", "e", api.fs.rename_basename, opts "Rename: Basename")
    vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts "Next Diagnostic")
    vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts "Prev Diagnostic")
    vim.keymap.set("n", "F", api.live_filter.clear, opts "Clean Filter")
    vim.keymap.set("n", "f", api.live_filter.start, opts "Filter")
    vim.keymap.set("n", "g?", api.tree.toggle_help, opts "Help")
    vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts "Copy Absolute Path")
    vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts "Toggle Dotfiles")
    vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts "Toggle Git Ignore")
    vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts "Last Sibling")
    vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts "First Sibling")
    vim.keymap.set("n", "m", api.marks.toggle, opts "Toggle Bookmark")
    vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "O", api.node.open.no_window_picker, opts "Open: No Window Picker")
    vim.keymap.set("n", "p", api.fs.paste, opts "Paste")
    vim.keymap.set("n", "P", api.node.navigate.parent, opts "Parent Directory")
    vim.keymap.set("n", "q", api.tree.close, opts "Close")
    vim.keymap.set("n", "r", api.fs.rename, opts "Rename")
    vim.keymap.set("n", "R", api.tree.reload, opts "Refresh")
    vim.keymap.set("n", "s", api.node.run.system, opts "Run System")
    vim.keymap.set("n", "S", api.tree.search_node, opts "Search")
    vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts "Toggle Hidden")
    vim.keymap.set("n", "W", api.tree.collapse_all, opts "Collapse")
    vim.keymap.set("n", "x", api.fs.cut, opts "Cut")
    vim.keymap.set("n", "y", api.fs.copy.filename, opts "Copy Name")
    vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts "Copy Relative Path")
    vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts "CD")
    -- END_DEFAULT_ON_ATTACH
end

M.tree = {
    filters = {
        -- exclude = { vim.fn.stdpath "config" },
        custom = { "^.git$", "^node_modules$", "^venv$", "^__pycache__$" },
    },
    git = {
        enable = true,
        ignore = false,
    },

    on_attach = on_attach,

    trash = {
        cmd = "trash",
    },

    -- view = {
    --   hide_root_folder = false,
    -- },

    renderer = {
        -- highlight_git = true,
        root_folder_label = false,

        icons = {
            show = {
                git = true,
            },
        },

        special_files = {
            "README.md",
            "readme.md",
            "package.json",
            "yarn.lock",
            "pyproject.toml",
            "poetry.lock",
            "ruff.toml",
        },
    },
}

M.blankline = {
    debounce = 100,
    indent = {
        char = " ",
    },
    scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        highlight = { "Function", "Label" },
        priority = 500,
    },
}

M.luasnip = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
}

M.telescope = {
    defaults = {
        preview = {
            mime_hook = function(filepath, bufnr, opts)
                local is_image = function(filepath)
                    local image_extensions = { "png", "jpg" } -- Supported image formats
                    local split_path = vim.split(filepath:lower(), ".", { plain = true })
                    local extension = split_path[#split_path]
                    return vim.tbl_contains(image_extensions, extension)
                end
                if is_image(filepath) then
                    local term = vim.api.nvim_open_term(bufnr, {})
                    local function send_output(_, data, _)
                        for _, d in ipairs(data) do
                            vim.api.nvim_chan_send(term, d .. "\r\n")
                        end
                    end
                    vim.fn.jobstart({
                        "catimg",
                        filepath, -- Terminal image viewer command
                    }, { on_stdout = send_output, stdout_buffered = true, pty = true })
                else
                    require("telescope.previewers.utils").set_preview_message(
                        bufnr,
                        opts.winid,
                        "Binary cannot be previewed"
                    )
                end
            end,
        },

        vimgrep_arguments = {
            "rg",
            "--hidden",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
        },
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        file_ignore_patterns = { ".git", "*tmp", "node_modules", "venv", ".ccls-cache" },
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "bottom",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        mappings = {
            n = { ["q"] = require("telescope.actions").close },
            i = {
                ["<C-j>"] = require("telescope.actions").move_selection_next,
                ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
        },
    },

    pickers = {
        find_files = {
            find_command = { "fd", "--hidden", "--type", "f", "--strip-cwd-prefix" },
            -- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
    },

    extensions_list = { "fzf", "themes", "terms" },

    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
}

function M.cmp(_)
    -- local cmp = require "cmp"
    -- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips").mappings

    local opts = {
        -- snippet = {
        --   expand = function(args)
        --     print(args)
        --     vim.fn["UltiSnips#Anon"](args.body)
        --   end,
        -- },

        -- mapping = {
        --   ["<C-p>"] = cmp.mapping.select_prev_item(),
        --   ["<C-n>"] = cmp.mapping.select_next_item(),
        --   ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
        --   ["<C-Space>"] = cmp.mapping.complete(),
        --   ["<C-e>"] = cmp.mapping.close(),
        --   ["<CR>"] = cmp.mapping.confirm {
        --     behavior = cmp.ConfirmBehavior.Insert,
        --     select = true,
        --   },
        --   ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --       cmp.select_next_item()
        --     -- elseif require("luasnip").expand_or_jumpable() then
        --     --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        --     else
        --       cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
        --     end
        --   end, {
        --     "i",
        --     "s",
        --   }),
        --   ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --       cmp.select_prev_item()
        --     -- elseif require("luasnip").jumpable(-1) then
        --     --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        --     else
        --       cmp_ultisnips_mappings.jump_backwards(fallback)
        --     end
        --   end, {
        --     "i",
        --     "s",
        --   }),
        -- },

        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "nvim_lua" },
            -- { name = "rg",      keyword_length = 3 },
            { name = "path" },
            -- { name = "git" },
            { name = "ultisnips" },
        },
    }
    return opts
end

M.color = {
    user_default_options = {
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        mode = "background", -- Set the display mode.
        -- parsers can contain values used in |user_default_options|
    },
}

M.key = {
    plugins = {
        spelling = {
            enabled = false,
        },
    },
}

M.signs = {
    current_line_blame = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
}

M.pairs = {
    enable_check_bracket_line = false,
}

return M
