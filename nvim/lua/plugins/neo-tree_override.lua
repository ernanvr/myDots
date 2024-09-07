return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  opts = {
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          -- auto close
          -- vimc.cmd("Neotree close")
          -- OR
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
    window = {
      position = "right",
    },
  },
}
