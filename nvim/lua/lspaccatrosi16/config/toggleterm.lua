require('toggleterm').setup({
    open_mapping = [[<C-\>]],
    direction = "vertical",
    size = function(_)
        return vim.o.columns * 0.4
    end
})
