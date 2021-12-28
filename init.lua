-- This is an example init file , its supposed to be placed in /lua/custom dir
-- lua/custom/init.lua

-- This is where your custom modules and plugins go.
-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!

local colors = require("colors").get()
local hooks = require "core.hooks"

-- MAPPINGS
-- To add new plugins, use the "setup_mappings" hook,

hooks.add("setup_mappings", function(map)
    map("n", "<leader>cc", ":Telescope <CR>", opt)
    map("n", "<leader>q", ":q <CR>", opt)

    map("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>")
    map("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>")
    map("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>")
    map("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>")
    map("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>")
    map("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>")
    map("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>")
    map("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>")
    map("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>")
end)

-- NOTE : opt is a variable  there (most likely a table if you want multiple options),
-- you can remove it if you dont have any custom options

-- Install plugins
-- To add new plugins, use the "install_plugin" hook,

-- examples below:

hooks.add("install_plugins", function(use)
   -- use {
   --    "max397574/better-escape.nvimn",
   --    event = "InsertEnter",
   -- }
   --
   use {
      "williamboman/nvim-lsp-installer",
   }

   use {
     "glepnir/lspsaga.nvim",
     config = function()
      require("custom.plugins.lspsaga").init()
     end
  }

   use {
      "brglng/vim-im-select",
      config = function()
         require("custom.plugins.imselect").init()
      end,
   }

   -- use {
   --   "liuchengxu/vim-which-key",
   --   config = function()
   --       require("plugins.whichKey").init()
   --   end,
   -- }


   use {
     "mg979/vim-visual-multi",
     config = function()
       require("custom.plugins.multi").init()
     end
   }

   -- theme
   -- use {
   --     'olimorris/onedarkpro.nvim',
   --     config = function() 
   --         -- require('onedarkpro').load()
   --     end
   -- }
   --
   -- use {
   --     "sonph/onehalf",
   --     rtp = 'vim'
   -- }

   use {
       "yamatsum/nvim-cursorline",
       config = function()
           vim.g.cursorline_timeout = 1000
           vim.g.cursorword_highlight = true
           -- vim.g.guibg = colors.black2
       end
   }

end)

-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event' field)
-- see: https://github.com/wbthomason/packer.nvim
-- https://nvchad.github.io/config/walkthrough
