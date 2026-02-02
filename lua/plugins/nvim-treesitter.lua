return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  branch = "main",
  -- NOTE: [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
  config = function()
    ---@param buf integer
    ---@param language string
    local function treesitter_try_attach(buf, language)
      -- check if parser exists and load it
      if not vim.treesitter.language.add(language) then
        return
      end
      -- enables syntax highlighting and other treesitter features
      vim.treesitter.start(buf, language)

      -- enables treesitter based folds
      -- for more info on folds see `:help folds`
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      -- enables treesitter based indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    local available_parsers = require("nvim-treesitter").get_available()
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local buf, filetype = args.buf, args.match
        local language = vim.treesitter.language.get_lang(filetype)
        if not language then
          return
        end

        local installed_parsers = require("nvim-treesitter").get_installed("parsers")

        if vim.tbl_contains(installed_parsers, language) then
          -- if a parser is available in `nvim-treesitter` enable it after ensuring it is installed
          require("nvim-treesitter").install(language):await(function()
            treesitter_try_attach(buf, language)
          end)
        else
          -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
          treesitter_try_attach(buf, language)
        end
      end,
    })

    -- ensure basic parser are installed
    local parsers = {
      "bash",
      "bicep",
      "c",
      "c",
      "c_sharp",
      "cpp",
      "css",
      "diff",
      "diff",
      "dockerfile",
      "gitcommit",
      "go",
      "gotmpl",
      "graphql",
      "html",
      "html",
      "java",
      "javascript",
      "json",
      "json5",
      "jsonc",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "powershell",
      "python",
      "query",
      "rasi",
      "razor",
      "regex",
      "rust",
      "scss",
      "sql",
      "ssh_config",
      "terraform",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vim",
      "vimdoc",
      "vimdoc",
      "xml",
      "yaml",
      "zsh",
    }
    require("nvim-treesitter").install(parsers)
  end,
}
