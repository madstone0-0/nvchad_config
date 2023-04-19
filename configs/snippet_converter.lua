local template = {
  sources = {
    ultisnips = {
      vim.fn.stdpath "config" .. "/lua/custom/snippets/UltiSnips",
    },
  },

  output = {
    vscode_luasnip = {
      vim.fn.stdpath "config" .. "/lua/custom/snippets/LuaSnip",
    },

    snipmate_luasnip = {
      vim.fn.stdpath "config" .. "/lua/custom/snippets/SnipMate",
    },
  },
}

require("snippet_converter").setup {
  templates = { template },
}
