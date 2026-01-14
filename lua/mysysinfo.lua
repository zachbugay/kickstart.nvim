-- Lua Class Tryout
--https://www.lua.org/pil/16.1.html
--https://learnxinyminutes.com/lua/
--https://github.com/folke/lazy.nvim/blob/main/lua/lazy/core/meta.lua

---@alias os_type `linux` | `windows` | `macos`
---@alias processor_architecture  `x64` | `ARM`

---@class SystemInfo
---@field os_type os_type
---@field processor_architecture processor_architecture
local SystemInfo = {}

-- A constructor for SystemInfo.
---@param info uv.os_uname.info
---@return SystemInfo
function SystemInfo.new(info)
  local self = setmetatable({}, { __index = SystemInfo })
  if info.sysname == "Windows_NT" then
    self.os_type = "windows"
  elseif info.sysname == "Linux" then
    self.os_type = "linux"
  else
    self.os_type = "macos"
  end

  if string.find(info.machine, "[x]?86") or string.find(info.machine, "[x]?64") then
    self.processor_architecture = "x64"
  else
    self.processor_architecture = "ARM"
  end

  return self
end

function SystemInfo:useWindowsShell()
  if self.os_type == "windows" then
    vim.o.shell = "pwsh.exe"
    vim.o.shellcmdflag =
      "-NoLogo -NonInteractive -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$PSStyle.Formatting.Error = '';$PSStyle.Formatting.ErrorAccent = '';$PSStyle.Formatting.Warning = '';$PSStyle.OutputRendering = 'PlainText';"
    vim.o.shellredir = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
    vim.o.shellpipe = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
    vim.o.shellquote = ""
    vim.o.shellxquote = ""
  end
end

-- vim.api.nvim_create_autocmd("TermOpen", {
--   group = vim.api.nvim_create_augroup("bugay/term_open", { clear = true }),
--   desc = "Use Windows PowerShell for terminal only.",
--   callback = function(args)
--     vim.notify("Running my call back cuz term open!", vim.log.levels.INFO, { title = "bugay" })
--     vim.notify("Running my auto command!", vim.log.levels.INFO, { title = "bugay" })
--     vim.notify("Args!", vim.log.levels.INFO, { title = "bugay" })
--
--     for key, value in pairs(args) do
--       vim.notify("key: " .. key .. " value: " .. value, vim.log.levels.INFO, { title = "bugay" })
--     end
--
--     local info = vim.uv.os_uname()
--     if info.sysname == "Windows_NT" then
--       vim.notify("THIS IS RUNNING!!!", vim.log.levels.INFO, { title = "bugay" })
--       vim.notify("Args!", vim.log.levels.INFO, { title = "bugay" })
--       vim.o.shell = "pwsh.exe"
--       vim.o.shellcmdflag =
--         "-NoLogo -NonInteractive -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$PSStyle.Formatting.Error = '';$PSStyle.Formatting.ErrorAccent = '';$PSStyle.Formatting.Warning = '';$PSStyle.OutputRendering = 'PlainText';"
--       vim.o.shellredir = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
--       vim.o.shellpipe = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
--       vim.o.shellquote = ""
--       vim.o.shellxquote = ""
--     end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("TermRequest", {
--   group = vim.api.nvim_create_augroup("bugay/cli_enter", { clear = true }),
--   desc = "Commandline Entered",
--   callback = function(args)
--     vim.notify("Running my call back cuz TermRequest!", vim.log.levels.INFO, { title = "bugay" })
--     vim.notify("Running my auto command!", vim.log.levels.INFO, { title = "bugay" })
--     vim.notify("Args!", vim.log.levels.INFO, { title = "bugay" })
--
--     for key, value in pairs(args) do
--       vim.notify("key: " .. key .. " value: " .. value, vim.log.levels.INFO, { title = "bugay" })
--     end
--
--     local info = vim.uv.os_uname()
--     if info.sysname == "Windows_NT" then
--       vim.notify("THIS IS RUNNING!!!", vim.log.levels.INFO, { title = "bugay" })
--       vim.notify("Args!", vim.log.levels.INFO, { title = "bugay" })
--       vim.o.shell = "pwsh.exe"
--       vim.o.shellcmdflag =
--         "-NoLogo -NonInteractive -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$PSStyle.Formatting.Error = '';$PSStyle.Formatting.ErrorAccent = '';$PSStyle.Formatting.Warning = '';$PSStyle.OutputRendering = 'PlainText';"
--       vim.o.shellredir = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
--       vim.o.shellpipe = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
--       vim.o.shellquote = ""
--       vim.o.shellxquote = ""
--     end
--   end,
-- })

return SystemInfo
