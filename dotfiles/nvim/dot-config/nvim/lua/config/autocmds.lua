local group = vim.api.nvim_create_augroup("config", {})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

if vim.fn.filereadable(vim.fn.stdpath("config") .. "/colors/matugen.vim") == 1 then
  vim.cmd.colorscheme("matugen")
end

vim.api.nvim_create_autocmd("Signal", {
  group = group,
  pattern = "SIGUSR1",
  command = "colorscheme matugen",
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    local buffer = args.buf
    local opts = { buffer = buffer, silent = true }

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})
