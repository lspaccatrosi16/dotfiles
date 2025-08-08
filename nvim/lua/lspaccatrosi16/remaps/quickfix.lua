local config = require("lspaccatrosi16/remaps.config")

local sec = config.sections:add("q", "quickfix list")
local qf_open = false

sec.add("n", "n", ":cn<CR>", "next item")
sec.add("n", "p", ":cp<CR>", "previous item")
sec.add("n", "o", function()
    qf_open = true
    vim.cmd.copen()
end, "open quickfix list")
sec.add("n", "c", function()
    qf_open = false
    vim.cmd.cclose()
end, "close quickfix list")

sec.add("n", "q", function()
    if qf_open then
        qf_open = false
        vim.cmd.cclose()
    else
        qf_open = true
        vim.cmd.copen()
    end
end, "toggle quickfix list")
