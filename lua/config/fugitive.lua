-- lua/config/fugitive.lua

vim.api.nvim_create_user_command("GitConflict", function()
  vim.cmd("Gvdiffsplit!")
end, { desc = "Open 3-way diff for conflict resolution" })

-- Clean up fugitive buffers automatically
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "fugitive://*",
  callback = function()
    vim.opt_local.bufhidden = "delete"
  end,
})

