local mySysInfo = require("mysysinfo").new(vim.uv.os_uname())
mySysInfo:useWindowsShell()
print("mySysInfo.processor_architecture: " .. mySysInfo.processor_architecture)
print(vim.print(vim.uv.os_uname()))

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.diagnostic")
require("config.lazy")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
