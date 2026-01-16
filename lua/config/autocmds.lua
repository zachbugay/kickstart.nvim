-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Highlighting for files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  desc = "Determine the highlight of a file that might be a go template.",
  group = vim.api.nvim_create_augroup("bugay-buffer-highlight", { clear = true }),
  callback = function(args)
    local buffer_number = args.buf
    local file_name = vim.fn.expand("%")

    local my_detections = {
      {
        detections = { "zsh", "zprofile" },
        file_type = "zsh",
      },
      {
        detections = { "ps1", "powershell" },
        file_type = "ps1",
      },
    }

    for _, detection in ipairs(my_detections) do
      if type(detection.detections) == "table" then
        for _, d in ipairs(detection.detections) do
          if string.find(file_name, d) then
            vim.bo.filetype = detection.file_type
          end
        end
      end
    end
  end,
})
