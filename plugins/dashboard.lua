local g = vim.g

g.dashboard_disable_at_vimenter = 0
g.dashboard_disable_statusline = 0
g.dashboard_default_executive = "telescope"
g.dashboard_custom_header = {
    '',
    '',
    '',
    '',
    '',
 ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
 ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
 ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
 ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
 ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
 ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
    '',
    '',
    '',
    '',
    '',
}

g.dashboard_custom_section = {
   a = { description = { "  快速查找文件               SPC f f" }, command = "Telescope find_files" },
   b = { description = { "  最近打开的文件             SPC f o" }, command = "Telescope oldfiles" },
   c = { description = { "  内容查询                   SPC f w" }, command = "Telescope live_grep" },
   d = { description = { "洛 新建文件                   SPC f n" }, command = "DashboardNewFile" },
   e = { description = { "  书签                       SPC b m" }, command = "Telescope marks" },
   f = { description = { "  打开上次内容               SPC l  " }, command = "SessionLoad" },
}

g.dashboard_custom_footer = {
   "我思故我在,不要停止思考",
}
