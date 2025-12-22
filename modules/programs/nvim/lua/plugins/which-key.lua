local wk = require 'which-key'
wk.add {
  { '<leader>o', group = 'Obsidian', icon = '󰇈' }, -- group
  { '<leader>ol', '<cmd>LivePreview start<CR>', desc = 'LivePreview', icon = '' },
  -- {
  --   "<leader>fb",
  --   function()
  --     print("hello")
  --   end,
  --   desc = "Foobar",
  -- },
  -- { "<leader>fn", desc = "New File" },
  -- { "<leader>f1", hidden = true }, -- hide this keymap
  -- { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
  -- {
  --   "<leader>b",
  --   group = "buffers",
  --   expand = function()
  --     return require("which-key.extras").expand.buf()
  --   end,
  -- },
}
