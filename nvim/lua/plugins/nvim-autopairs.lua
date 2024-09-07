return {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   config = function()
  --     -- run default AstroNvim config
  --     require("nvim-autopairs").setup()
  --     -- require Rule function
  --     local Rule = require("nvim-autopairs.rule")
  --     local npairs = require("nvim-autopairs")
  --     local cond = require("nvim-autopairs.conds")
  --
  --     npairs.add_rules({
  --       Rule("<", ">", "dart"):with_pair(cond.not_before_text("=")):with_pair(cond.not_before_text(" ")),
  --     })
  --   end,
}
