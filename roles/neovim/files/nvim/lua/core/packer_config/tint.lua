require("tint").setup({
  tint = -60,
  saturation = 0.1,
  window_ignore_function = function(winid)
    local bufid = vim.api.nvim_win_get_buf(winid)
    local filetype = vim.api.nvim_buf_get_option(bufid, "filetype")

    local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
    local nvimtree = filetype == "NvimTree"
    local dap = string.find(filetype, "^dap") ~= nil
    local trouble = filetype == "Trouble"
    return floating or nvimtree or dap or trouble
  end
})
