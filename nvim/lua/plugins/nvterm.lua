return {
  "NvChad/nvterm",
  config = function()
    local map = vim.keymap.set
    require("nvterm").setup()

    map({ "n" }, "<Leader>h", function()
      require("nvterm.terminal").toggle("horizontal")
    end, { desc = "Terminal Toggle Horizontal term" })

    map({ "n" }, "<Leader>v", function()
      require("nvterm.terminal").toggle("vertical")
    end, { desc = "Terminal Toggle Vertical term" })
  end,
}
