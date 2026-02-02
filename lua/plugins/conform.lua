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
    log_level = vim.log.levels.INFO,
    format_on_save = function(bufnr)
      return {
        timeout_ms = 500,
        lsp_format = "fallback",
      }
    end,
    formatters = {
      -- Require a Prettier configuration file to format.
      prettier = { require_cwd = true },
    },
    formatters_by_ft = {
      javascript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      javascriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      json = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      jsonc = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      lua = { "stylua" },
      markdown = { "prettier" },
      scss = { "prettier" },
      sh = { "shfmt" },
      typescript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      typescriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
      yaml = { "prettier" },
      ["_"] = { "trim_whitespace" },
    },
  },
}
