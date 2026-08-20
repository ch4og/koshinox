local keymap = require("lz.n").keymap

local telescope = keymap({
  "telescope.nvim",
  cmd = "Telescope",
  before = function()
    vim.cmd.packadd("plenary.nvim")
  end,
  after = function()
    require("telescope").setup({})
  end,
})

telescope.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })

telescope.set("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Live grep" })

telescope.set("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "Find buffers" })

return {
  {
    "catppuccin",
    lazy = false,
    after = function()
      require("catppuccin").setup({ flavour = "mocha" })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "gitsigns.nvim",
    event = "BufReadPre",
    after = function()
      require("gitsigns").setup()
    end,
  },
  {
    "nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    after = function()
      require("nvim-treesitter").setup({})
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
  {
    "nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    after = function()
      vim.lsp.enable({ "lua_ls", "bashls", "nil_ls" })
    end,
  },
}
