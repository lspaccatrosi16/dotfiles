local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local config = require("lspaccatrosi16/remaps.config")
local sec = config.sections:add("h", "harpoon")


sec.add("n", "a", mark.add_file, "add file")
sec.add("n", "h", ui.toggle_quick_menu, "open menu")
sec.add("n", "1", function() ui.nav_file(1) end, "goto file 1")
sec.add("n", "2", function() ui.nav_file(2) end, "goto file 2")
sec.add("n", "3", function() ui.nav_file(3) end, "goto file 3")
sec.add("n", "4", function() ui.nav_file(4) end, "goto file 4")
sec.add("n", "5", function() ui.nav_file(5) end, "goto file 5")
