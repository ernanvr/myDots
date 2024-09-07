return {
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --     "nvim-lua/plenary.nvim",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "sidlatau/neotest-dart",
  --   },
  --   opts = { adapters = { "neotest-dart" } },
  -- },
  {
    "vim-test/vim-test",
    config = function()
      vim.g["test#strategy"] = "neovim"
      if vim.fn.has("nvim") == 1 then
        vim.api.nvim_set_keymap("t", "<C-o>", "<C-\\><C-n>", { noremap = true, silent = true })
      end
    end,
  },
}
