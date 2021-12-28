-- This is an example chadrc file , its supposed to be placed in /lua/custom dir
-- lua/custom/chadrc.lua --

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:
--
M.options = {
    tabstop = 4,
    timeoutlen = 800,
    shiftwidth = 4,
}

M.ui = {
   theme = "one-light",
}

M.plugins = {
   status = {
     dashboard = true,
   },
   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspinstaller",
      },
      -- luasnip = {
      --    snippet_path = {
      --      "~/.config/nvim/lua/custom/snippets"
      --    },
      -- },
     statusline = {
         -- hide, show on specific filetypes
         hidden = {
            "help",
            -- "dashboard",
            "NvimTree",
            -- "terminal",
         },
         shown = {},

         -- truncate statusline on small screens
         shortline = true,
         style = "default", -- default, round , slant , block , arrow
      },
   },
   default_plugin_config_replace = {
     feline = "custom.plugins.statusline",
     dashboard = "custom.plugins.dashboard",
     bufferline = "custom.plugins.bufferline"
   },
}

M.mappings = {
    plugins = {

        lspconfig = {
          declaration = "gD",
          definition = "gd",
          hover = "K",
          implementation = "gi",
          signature_help = "gk",
          add_workspace_folder = "<leader>wa",
          remove_workspace_folder = "<leader>wr",
          list_workspace_folders = "<leader>wl",
          type_definition = "<leader>D",
          rename = "<leader>rn",
          code_action = "<leader>ca",
          references = "gr",
          float_diagnostics = "ge",
          goto_prev = "[d",
          goto_next = "]d",
          set_loclist = "<leader>lq",
          formatting = "<leader>fm",
        },

        nvimtree = {
          toggle = "<leader>e",
          focus = "<C-e>",
        },
    }
}


return M
