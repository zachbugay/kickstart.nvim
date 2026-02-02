local mySysInfo = require("mysysinfo").new(vim.uv.os_uname())
mySysInfo:useWindowsShell()

-- vim.uv.os_uname = function()
--   return {
--     machine = "arm64",
--     release = "10.0.26200",
--     sysname = "Windows_NT",
--     version = "Windows 11 Enterprise",
--   }
-- end

-- print("mySysInfo.processor_architecture: " .. mySysInfo.processor_architecture)
-- print(vim.print(vim.uv.os_uname()))

-- [[ NOTE: Setup my options, keymaps and other custom settings. ]]
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.diagnostic")
-- [[ NOTE: Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
require("config.lazy")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
