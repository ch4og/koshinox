local M = {}

function M.setup()
  require("lualine").setup({
    options = {
      theme = "base16",
    },
  })
end

return M
