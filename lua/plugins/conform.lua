-- Autoformat
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    notify_on_error = false,
    notify_no_formatters = true,
    log_level = vim.log.levels.DEBUG,
    format_on_save = function(bufnr)
      return {
        timeout_ms = 500,
        lsp_format = "fallback",
      }
    end,
    formatters = {
      prettier = {
        require_cwd = false,
        append_args = function(self, ctx)
          local ft = vim.bo[ctx.buf].filetype
          local path = vim.fs.joinpath(vim.uv.os_homedir(), ".config", "prettier", ".prettierrc.yaml")
          if ft == "ps1" then
            return { "--config", path }
          end
          return {}
        end,
        options = {
          ext_parsers = {
            ps1 = "powershell",
          },
        },
      },
    },
    formatters_by_ft = {
      ["_"] = { "trim_whitespace" },
      javascript = { "prettier", name = "dprint" },
      javascriptreact = { "prettier", name = "dprint" },
      json = { "prettier", name = "dprint" },
      jsonc = { "prettier", name = "dprint" },
      lua = { "stylua" },
      markdown = { "prettier" },
      ps1 = { "prettier", name = "dprint", timeout_ms = 1000 },
      scss = { "prettier" },
      sh = { "shfmt" },
      typescript = { "prettier", name = "dprint" },
      typescriptreact = { "prettier", name = "dprint" },
      yaml = { "prettier" },
    },
  },
}
