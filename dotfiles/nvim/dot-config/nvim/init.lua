vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local function github(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  { src = github("nvim-neorocks/lz.n"), name = "lz.n" },
  { src = github("vyfor/cord.nvim"), name = "cord.nvim" },
  { src = github("nvim-telescope/telescope.nvim"), name = "telescope.nvim" },
  { src = github("nvim-lua/plenary.nvim"), name = "plenary.nvim" },
  { src = github("lewis6991/gitsigns.nvim"), name = "gitsigns.nvim" },
  { src = github("nvim-treesitter/nvim-treesitter"), name = "nvim-treesitter", version = "main" },
  { src = github("neovim/nvim-lspconfig"), name = "nvim-lspconfig" },
  { src = github("wakatime/vim-wakatime"), name = "vim-wakatime" },
}, { load = false, confirm = false })

vim.cmd.packadd("lz.n")

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("lz.n").load("plugins")
