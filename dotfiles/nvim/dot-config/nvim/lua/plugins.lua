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
    "which-key.nvim",
    lazy = false,
    after = function()
      require("which-key").setup({})
      require("which-key").add({
        { "<leader>a", group = "AI / Claude Code" },
        { "<leader>g", group = "Git" },
      })
    end,
  },
  {
    "vim-emacsmodeline",
    lazy = false,
  },
  {
    "vim-wakatime",
    lazy = false,
  },
  {
    "cord.nvim",
    lazy = false,
    after = function()
      require("cord").setup({
        idle = {
          show_status = false,
        },
      })
    end,
  },
  {
    "snacks.nvim",
    lazy = true,
    keys = {
      {
        "<leader>e",
        function()
          require("snacks").explorer.open()
        end,
        desc = "File explorer",
      },
      {
        "<leader>t",
        function()
          require("snacks").terminal()
        end,
        desc = "Toggle terminal",
      },
      {
        "<C-/>",
        function()
          require("snacks").terminal()
        end,
        desc = "Toggle terminal",
      },
      {
        "<C-_>",
        function()
          require("snacks").terminal()
        end,
        desc = "Toggle terminal",
      },
      {
        "<leader>gg",
        function()
          require("snacks").lazygit.open()
        end,
        desc = "Lazygit",
      },
    },
    after = function()
      require("snacks").setup({
        explorer = {},
        lazygit = {},
        terminal = {},
      })
    end,
  },
  {
    "claudecode.nvim",
    before = function()
      require("lz.n").trigger_load("snacks.nvim")
    end,
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSelectModel",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeStatus",
      "ClaudeCodeStart",
      "ClaudeCodeStop",
      "ClaudeCodeOpen",
      "ClaudeCodeClose",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
      "ClaudeCodeCloseAllDiffs",
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
      },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
    after = function()
      require("claudecode").setup({})
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
    lazy = false,
    after = function()
      if vim.env.CC == nil and vim.fn.executable("cc") == 0 then
        vim.env.CC = "gcc"
      end

      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })
      require("nvim-treesitter").install({ "scheme" })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
  {
    "nvim-paredit",
    ft = "scheme",
    after = function()
      require("nvim-paredit").setup({
        filetypes = { "scheme" },
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
