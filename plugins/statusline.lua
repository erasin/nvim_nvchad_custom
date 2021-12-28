local colors = require("colors").get()
local lsp = require "feline.providers.lsp"
-- local vimode = require('feline.providers.vi_mode');
local lsp_severity = vim.diagnostic.severity

local icon_styles = {
   default = {
      left = "",
      right = " ",
      main_icon = "  ", --"  ",
      vi_mode_icon = " ",
      position_icon = " ",
   },
   arrow = {
      left = "",
      right = "",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
   },

   block = {
      left = " ",
      right = " ",
      main_icon = "   ",
      vi_mode_icon = "  ",
      position_icon = "  ",
   },

   round = {
      left = "",
      right = "",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
   },

   slant = {
      left = " ",
      right = " ",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
   },
}

local config = require("core.utils").load_config().plugins.options.statusline

-- statusline style
local user_statusline_style = config.style
local statusline_style = icon_styles[user_statusline_style]

-- show short statusline on small screens
local shortline = config.shortline == false and true

-- Initialize the components table
local components = {
   active = {},
   inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

-- components.active[1][1]
local c_icons = {
   provider = statusline_style.main_icon,

   hl = {
      fg = colors.statusline_bg,
      bg = colors.nord_blue,
   },

   right_sep = {
     str = statusline_style.right,
     hl = {
      fg = colors.nord_blue,
      bg = colors.statusline_bg,
     }
   },
}

-- components.active[1][2]
local c_filename = {
   provider = function()
      local filename = vim.fn.expand "%:t"
      local extension = vim.fn.expand "%:e"
      local icon = require("nvim-web-devicons").get_icon(filename, extension)
      if icon == nil then
         icon = " "
         return icon
      end
      return " " .. icon .. " " .. filename .. " "
   end,

   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 70
   end,

   hl = {
      fg = colors.nord_blue,
      bg = colors.statusline_bg,
   },

   right_sep = {
     str = statusline_style.right,
     hl = {
       fg = colors.statusline_bg,
       bg = colors.lightbg2,
     },
   },
}

-- components.active[1][3]
local c_dir = {
   provider = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      return  dir_name .. " "
   end,

   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 80
   end,

   icon = "  ",

   hl = {
      fg = colors.statusline_bg,
      bg = colors.nord_blue,
   },

   -- right_sep = { str = statusline_style.right, hl = { fg = colors.nord_blue, bg = colors.statusline_bg} },
}

-- components.active[1][4]
local c_git_add = {
   provider = "git_diff_added",
   hl = {
      -- fg = colors.grey_fg2,
      fg = colors.green,
      bg = colors.statusline_bg,
   },
   icon = "  ", --" ",
}
-- diffModfified
-- components.active[1][5]
local c_git_changed = {
   provider = "git_diff_changed",
   hl = {
      -- fg = colors.grey_fg2,
      fg = colors.nord_blue,
      bg = colors.statusline_bg,
   },
   icon = " 柳", --"   ",
}
-- diffRemove
-- components.active[1][6]
local c_git_diff = {
   provider = "git_diff_removed",
   hl = {
      -- fg = colors.grey_fg2,
      fg = colors.orange,
      bg = colors.statusline_bg,
   },
   icon = "  ",--"  ",
}

-- components.active[1][7]
local c_dia_error = {
   provider = "diagnostic_errors",
   enabled = function()
      return lsp.diagnostics_exist(lsp_severity.ERROR)
   end,

   hl = { fg = colors.red },
   icon = "  ",
}

-- components.active[1][8]
local c_dia_warn = {
   provider = "diagnostic_warnings",
   enabled = function()
      return lsp.diagnostics_exist(lsp_severity.WARN)
   end,
   hl = { fg = colors.yellow },
   icon = "  ",
}

-- components.active[1][9]
local c_dia_hits = {
   provider = "diagnostic_hints",
   enabled = function()
      return lsp.diagnostics_exist(lsp_severity.HINT)
   end,
   hl = { fg = colors.grey_fg2 },
   icon = "  ",
}

-- components.active[1][10]
local c_dia_info = {
   provider = "diagnostic_info",
   enabled = function()
      return lsp.diagnostics_exist(lsp_severity.INFO)
   end,
   hl = { fg = colors.green },
   icon = "  ",--"  ",
}

-- components.active[2][1]
local c_lsp_msg = {
   provider = function()
      local Lsp = vim.lsp.util.get_progress_messages()[1]

      if Lsp then
         local msg = Lsp.message or ""
         local percentage = Lsp.percentage or 0
         local title = Lsp.title or ""
         local spinners = {
            "",
            "",
            "",
         }

         local success_icon = {
            "",
            "",
            "",
         }

         local ms = vim.loop.hrtime() / 1000000
         local frame = math.floor(ms / 120) % #spinners

         if percentage >= 70 then
            return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
         end

         return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
      end

      return ""
   end,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 80
   end,
   hl = { fg = colors.green },

}

-- components.active[3][1]
local c_lsp_client = {
   provider = function()
      -- if next(vim.lsp.buf_get_clients()) ~= nil then
      --    return "  LSP"
      -- else
      --    return ""
      -- end

      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        return ""
      end

      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          table.insert(buf_client_names, client.name)
        end
      end

      -- local buf_ft = vim.bo.filetype
      -- -- add formatter
      -- local formatters = require "lvim.lsp.null-ls.formatters"
      -- local supported_formatters = formatters.list_registered_providers(buf_ft)
      -- vim.list_extend(buf_client_names, supported_formatters)
      --
      -- -- add linter
      -- local linters = require "lvim.lsp.null-ls.linters"
      -- local supported_linters = linters.list_registered_providers(buf_ft)
      -- vim.list_extend(buf_client_names, supported_linters)

      return table.concat(buf_client_names," ") .. " "

   end,

   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 70
   end,

   icon = "  ",
   hl = { fg = colors.statusline_bg, bg = colors.lightbg2},
   left_sep = { str = statusline_style.right, hl = { fg = colors.statusline_bg, bg = colors.lightbg2}},
   right_sep = { str = statusline_style.right, hl = { fg = colors.nord_blue, bg = colors.statusline_bg} },
}

-- components.active[3][2]
local c_git_branch = {
   provider = "git_branch",

   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 70
   end,

   -- hl = { fg = colors.white, bg = colors.statusline_bg },
   icon = "  ",

   hl = { fg = colors.statusline_bg, bg = colors.nord_blue},
   right_sep = { str = statusline_style.right, hl = { fg = colors.nord_blue, bg = colors.statusline_bg} },
   left_sep = { str = statusline_style.right, hl = { fg = colors.statusline_bg, bg = colors.lightbg2}},
}

components.active[3][3] = {
   provider = " " ,--.. statusline_style.left,
   hl = {
      fg = colors.statusline_bg,
      bg = colors.statusline_bg,
   },
}

local mode_colors = {
   ["n"] = { "正常", colors.red ,"  "},
   ["no"] = { "N-PENDING", colors.red , " "},
   ["i"] = { "书写", colors.dark_purple, " ﯑ " },
   ["ic"] = { "书写", colors.dark_purple, "  "},
   ["t"] = { "终端", colors.green },
   ["v"] = { "可视", colors.cyan, "  "},
   ["V"] = { "V-LINE", colors.cyan },
   [""] = { "V-BLOCK", colors.cyan },
   ["R"] = { "REPLACE", colors.orange },
   ["Rv"] = { "V-REPLACE", colors.orange },
   ["s"] = { "SELECT", colors.nord_blue },
   ["S"] = { "S-LINE", colors.nord_blue },
   [""] = { "S-BLOCK", colors.nord_blue },
   ["c"] = { "指令", colors.pink," גּ " },
   ["cv"] = { "指令", colors.pink," גּ " },
   ["ce"] = { "指令", colors.pink," גּ " },
   ["r"] = { "PROMPT", colors.teal },
   ["rm"] = { "MORE", colors.teal },
   ["r?"] = { "CONFIRM", colors.teal },
   ["!"] = { "SHELL", colors.green },
}

local chad_mode_hl = function()
   return {
      fg = mode_colors[vim.fn.mode()][2],
      bg = colors.one_bg,
   }
end

components.active[3][4] = {
   provider = statusline_style.left,
   hl = function()
      return {
         fg = mode_colors[vim.fn.mode()][2],
         bg = colors.one_bg2,
      }
   end,
}

components.active[3][5] = {
   provider = statusline_style.vi_mode_icon,
   hl = function()
      return {
         fg = colors.statusline_bg,
         bg = mode_colors[vim.fn.mode()][2],
      }
   end,
}

-- components.active[3][6]
local c_mode = {
   provider = function()
      local icon = mode_colors[vim.fn.mode()][3]
      if icon == nil then
        icon = " "
      end
      return icon .. mode_colors[vim.fn.mode()][1] .. " "
   end,
   hl = {
      fg = mode_colors[vim.fn.mode()][2],
      bg = colors.one_bg,
      style = "bold",
   },
}

components.active[3][7] = {
   provider = "", -- statusline_style.left,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
   end,
   hl = {
      fg = colors.grey,
      bg = colors.one_bg,
   },
}

components.active[3][8] = {
   provider = "",-- statusline_style.left,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
   end,
   hl = {
      fg = colors.green,
      bg = colors.grey,
   },
}

components.active[3][9] = {
   provider = " ",-- statusline_style.position_icon,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
   end,
   hl = {
      fg = colors.black,
      bg = colors.green,
   },
}

-- components.active[3][10]
local c_lines = {
   provider = function()
      local current_line = vim.fn.line "."
      local total_line = vim.fn.line "$"

      -- if current_line == 1 then
      --    return " Top "
      -- elseif current_line == vim.fn.line "$" then
      --    return " Bot "
      -- end
      local result, _ = math.modf((current_line / total_line) * 100)

      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_line
      local index = math.ceil(line_ratio * #chars)

      return string.format('  %2d%%%% %s', result, chars[index]) -- " " .. result .. "%% " .. chars[index] .. " "

   end,

   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
   end,

   hl = {
      fg = colors.green,
      bg = colors.one_bg,
   },
}

local c_pos = {
  provider = function()
      return string.format(" %d:%d", vim.fn.line("."), vim.fn.col("."))
  end,

  enabled = shortline or function(winid)
    return vim.api.nvim_win_get_width(winid) > 90
  end,

  hl = {
    fg = "skyblue",
    bg = colors.statusline_bg,
  },
}

local components2 = {
   active = {
     {
       c_icons,
       c_mode,
       c_git_branch,
       c_git_add,
       c_git_changed,
       c_git_diff,
       c_dia_error,
       c_dia_warn,
       c_dia_hits,
       c_dia_info,
     },
     {
       c_lsp_msg,
     },
     {
       c_pos,
       c_lines,
       c_lsp_client,
       c_filename,
       c_dir,
     },
   },
   inactive = {},
}

require("feline").setup {
   theme = {
      bg = colors.statusline_bg,
      fg = colors.fg,
   },

   components = components2,
}
