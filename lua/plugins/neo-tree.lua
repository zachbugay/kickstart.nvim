return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "main",
  version = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  },
  lazy = false,
  keys = {
    { "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    close_if_last_window = true,
    popup_border_style = "NC",
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      filtered_items = {
        never_show = {
          ".DS_Store",
        },
        visible = true,
        hide_hidden = false,
      },
      window = {
        mappings = {
          ["\\"] = "close_window",
        },
      },
    },
  },
}
