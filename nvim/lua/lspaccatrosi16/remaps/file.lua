local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local dropdown = themes.get_dropdown({})

local wrap_telescope_theme = function(cmd)
    return function()
        cmd(dropdown)
    end
end

local config = require("lspaccatrosi16/remaps.config")
local sec = config.sections:add("f", "file commands")

sec.add("n", "t", vim.cmd.TSJToggle, "grow / collapse blocks")
sec.add("n", "u", vim.cmd.UndotreeToggle, "toggle undo tree")
sec.add("n", "b", "dibvbpg;", "remove surrounding brackets")
sec.add("n", "q", "diqvqpg;", "remove surrounding quotes")
sec.add("n", "f", ":LspZeroFormat<CR>", "format file")

local fileComment = config.sections:add("fc", "file comment commands")

fileComment.add("n", "l", "<Plug>(comment_toggle_linewise_current)", "line comment")
fileComment.add("n", "b", "<Plug>(comment_toggle_blockwise_current)", "block comment")

local fileSymbol = config.sections:add("fs", "file symbol commands")

fileSymbol.add("n", "r", vim.lsp.buf.rename, "rename")
fileSymbol.add("n", "s", wrap_telescope_theme(builtin.treesitter), "search")
