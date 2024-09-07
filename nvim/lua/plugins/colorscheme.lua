return {
  {
    "ericvw/nordtheme-vim",
    branch = "pu",
    config = function()
      vim.g.nord_bold = 1
      vim.g.nord_italic = 1
      vim.g.nord_underline = 1
    end,
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "rmehri01/onenord.nvim",
    priority = 1000, -- Ensure it loads first
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = { flavour = "frappe", transparent_background = true },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
