return {
  -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
  -- used for completion, annotations and signatures of Neovim apis
  "folke/lazydev.nvim",
  ft = "lua", -- Only load on lua files
  ---@module 'lazydev'
  ---@type lazydev.Config
  opts = {
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      "LazyVim",
      --      { path = "LazyVim", words = { "LazyVim" } },
    },
  },
}
