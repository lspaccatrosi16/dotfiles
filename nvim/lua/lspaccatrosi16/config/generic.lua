local setup = function(name, config)
    local status, req = pcall(require, name)
    if (status) then
        req.setup(config)
    else
        print("could not perform generic setup on package " .. name)
    end
end

setup('telescope')
setup('Comment')
setup('treesj', { use_default_keymaps = false })
setup('mini.ai')
setup('mini.completion')
setup('mini.jump')
setup('mini.pairs')
setup('go', {
    diagnostic = {
        hdlr = true,
        underline = true,
        signs = true,
        update_in_insert = false,
    }
})
