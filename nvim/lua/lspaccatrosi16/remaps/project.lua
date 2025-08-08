-- Telescope
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local dropdown = themes.get_dropdown({})

local wrap_telescope_theme = function(cmd)
    return function()
        cmd(dropdown)
    end
end

local config = require("lspaccatrosi16/remaps.config")
local sec = config.sections:add("p", "project commands")

sec.add('n', 'f', wrap_telescope_theme(builtin.find_files), "project file search")
sec.add('n', 's', wrap_telescope_theme(builtin.live_grep), "project live grep")
sec.add('n', 'e', wrap_telescope_theme(builtin.diagnostics), "project diagnostics search")
sec.add('n', 'h', wrap_telescope_theme(builtin.help_tags), "help search")
sec.add('n', 'v', vim.cmd.Ex, 'project file manager')
