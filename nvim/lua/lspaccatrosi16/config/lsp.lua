require("neodev").setup()

local lsp_zero = require("lsp-zero")
lsp_zero.setup()
lsp_zero.on_attach(function(_, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end
    },
    sources = cmp.config.sources {
        { name = "nvim_lsp" }
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    window = {
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
        },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
        end,
        expandable_indicator = true
    },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local noop = function() end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { "lua_ls", "gopls", "jdtls", "qmlls" },
    handlers = {
        function(server_name) require('lspconfig')[server_name].setup({ capabilities = capabilities }) end,
        jdtls = noop,
    },
})
