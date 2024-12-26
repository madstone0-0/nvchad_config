local M = {}
local map = vim.keymap.set
local harpoon = require "harpoon"

function M.setup()
    harpoon:setup()

    map("n", "<leader>ja", function()
        harpoon:list():add()
    end, { desc = "Harpoon add" })

    -- map("n", "<leader>jl", function()
    --     harpoon.ui:toggle_quick_menu(harpoon:list())
    -- end, { desc = "Harpoon list" })

    map("n", "<leader>j1", function()
        harpoon:list():select(1)
    end, { desc = "Harpoon select 1" })

    map("n", "<leader>j2", function()
        harpoon:list():select(2)
    end, { desc = "Harpoon select 2" })

    map("n", "<leader>j3", function()
        harpoon:list():select(3)
    end, { desc = "Harpoon select 3" })

    map("n", "<leader>j4", function()
        harpoon:list():select(4)
    end, { desc = "Harpoon select 4" })

    -- Toggle previous & next buffers stored within Harpoon list
    map("n", "<C-S-K>", function()
        harpoon:list():prev()
    end, { desc = "Harpoon prev" })

    map("n", "<C-S-L>", function()
        harpoon:list():next()
    end, { desc = "Harpoon next" })

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end

        local finder = function()
            local paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(paths, item.value)
            end

            return require("telescope.finders").new_table {
                results = paths,
            }
        end

        require("telescope.pickers")
            .new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table {
                    results = file_paths,
                },
                previewer = conf.file_previewer {},
                sorter = conf.generic_sorter {},

                attach_mappings = function(prompt_bufnr, map)
                    map("i", "<C-d>", function()
                        local state = require "telescope.actions.state"
                        local selected_entry = state.get_selected_entry()
                        local current_picker = state.get_current_picker(prompt_bufnr)

                        table.remove(harpoon_files.items, selected_entry.index)
                        current_picker:refresh(finder())
                    end)
                    return true
                end,
            })
            :find()
    end

    vim.keymap.set("n", "<leader>jl", function()
        toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })
end

return M
