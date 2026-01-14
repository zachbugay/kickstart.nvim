-- Get the window id for the buffer.
---@param buffer_number integer
---@return integer
local function buffer_to_window(buffer_number)
  local current_window = vim.fn.win_getid()

  -- Check if current window has the buffer
  if vim.fn.winbufnr(current_window) == buffer_number then
    return current_window
  end

  -- Otherwise, find a visible window with this buffer
  local window_ids = vim.fn.win_findbuf(buffer_number)
  local current_tabpage = vim.fn.tabpagenr()

  for _, window_id in ipairs(window_ids) do
    if vim.fn.win_id2tabwin(window_id)[1] == current_tabpage then
      return window_id
    end
  end

  return current_window
end

-- Split a string into multiple lines, each no longer than max_width.
-- The split will only occur on spaces to preserve readability.
---@param str string
---@param max_width integer
---@return string[]
local function split_line(str, max_width)
  if #str <= max_width then
    return { str }
  end

  local lines = {}
  local current_line = ""

  for word in string.gmatch(str, "%S+") do
    -- If adding this word would exceed max_width
    if #current_line + #word + 1 > max_width then
      -- Add the current line to our results
      table.insert(lines, current_line)
      current_line = word
    else
      -- Add word to the current line with a space if needed.
      if current_line ~= "" then
        current_line = current_line .. " " .. word
      else
        current_line = word
      end
    end
  end

  -- Don't forget the last line.
  if current_line ~= "" then
    table.insert(lines, current_line)
  end
  return lines
end

---@param diagnostic vim.Diagnostic
---@return string
local function virtual_lines_format(diagnostic)
  local window = buffer_to_window(diagnostic.bufnr)
  local sign_column_width = vim.fn.getwininfo(window)[1].textoff
  local text_area_width = vim.api.nvim_win_get_width(window) - sign_column_width
  local center_width = 5
  local left_width = 1

  ---@type string[]
  local lines = {}

  for msg_line in diagnostic.message:gmatch("([^\n]+)") do
    local max_width = text_area_width - diagnostic.col - center_width - left_width
    vim.list_extend(lines, split_line(msg_line, max_width))
  end

  return table.concat(lines, "\n")
end

-- Don't show virtual text on current line since we'll show virtual_lines
---@param diagnostic vim.Diagnostic
---@return string?
local function virtual_text_format(diagnostic)
  if vim.fn.line(".") == diagnostic.lnum + 1 then
    return nil
  end

  return diagnostic.message
end

vim.diagnostic.config({
  virtual_text = { format = virtual_text_format, severity = { min = vim.diagnostic.severity.WARN } },
  virtual_lines = { format = virtual_lines_format, current_line = true },
  severity_sort = { reverse = false },
})

-- Re-draw diagnostics each line change to account for virtual_text changes.

local last_line = vim.fn.line(".")
local timer = nil
local redraw_debounce = 100

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    local current_line = vim.fn.line(".")

    if current_line ~= last_line then
      -- Line changed - cancel any pending timer and start a new one.
      if timer then
        timer:stop()
      end

      timer = vim.defer_fn(function()
        vim.diagnostic.hide()
        vim.diagnostic.show()
        last_line = current_line
      end, redraw_debounce)
    end
    -- If same line, do nothing and let any existing timer continue.
  end,
})

-- Re-render diagnostics when the window is restarted.
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.diagnostic.hide()
    vim.diagnostic.show()
  end,
})
