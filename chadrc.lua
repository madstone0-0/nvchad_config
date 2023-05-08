-- First read our docs (completely) then check the example_config repo

 local M = {}

 local highlights = require "custom.highlights"

 M.ui = {
   theme = "mountain",
   statusline = {
     theme = "vscode_colored",
   },

   nvdash = {
     load_on_startup = true,
   },
   tabufline = {
     lazyload = true,
   },
   hl_override = highlights.override,
   hl_add = highlights.add,
 }

 M.plugins = "custom.plugins"
 M.mappings = require "custom.mappings"

 return M
