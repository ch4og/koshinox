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

local EMACS_OPTIONS = "(setq enable-local-eval t enable-local-variables :all)"

local function emacs_indent_expression(first_line, last_line)
  return string.format(
    "(progn (hack-local-variables) (goto-char (point-min)) (forward-line %d) (let ((beg (point))) (goto-char (point-min)) (forward-line %d) (indent-region beg (line-end-position))) (save-buffer))",
    first_line - 1,
    last_line - 1
  )
end

local function format_with_emacs(buf, file, first_line, last_line)
  vim.cmd.update()
  local out = vim.fn.system({
    "emacs",
    "--batch",
    "--quick",
    "--eval",
    EMACS_OPTIONS,
    file,
    "--eval",
    emacs_indent_expression(first_line, last_line),
  })
  if vim.v.shell_error ~= 0 then
    vim.notify(out, vim.log.levels.ERROR)
  end
  vim.cmd.checktime()
end

-- In projects with .dir-locals.el, delegate formatting to Emacs so its local
-- indentation rules apply. Otherwise, use Neovim's native indentation.
local function setup_emacs_formatting(buf)
  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then
    return false
  end

  local dir_locals = vim.fs.find(".dir-locals.el", {
    path = vim.fs.dirname(file),
    upward = true,
    type = "file",
    limit = 1,
  })[1]
  if not dir_locals then
    return false
  end

  vim.keymap.set("n", "<C-A-\\>", function()
    format_with_emacs(buf, file, 1, vim.api.nvim_buf_line_count(buf))
  end, { buffer = buf, desc = "Format buffer with Emacs (.dir-locals.el)" })

  vim.keymap.set("x", "<C-A-\\>", function()
    local first_line = vim.fn.line("v")
    local last_line = vim.api.nvim_win_get_cursor(0)[1]

    format_with_emacs(buf, file, math.min(first_line, last_line), math.max(first_line, last_line))
  end, { buffer = buf, desc = "Format selection with Emacs (.dir-locals.el)" })

  return true
end

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(args)
    if not setup_emacs_formatting(args.buf) then
      local opts = { buffer = args.buf, desc = "Indent buffer" }
      vim.keymap.set("n", "<C-A-\\>", "gg=G", opts)
      vim.keymap.set("x", "<C-A-\\>", "=", opts)
    end
  end,
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
