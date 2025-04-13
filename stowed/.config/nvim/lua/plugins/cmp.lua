return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "l3mon4d3/luasnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "quangnguyen30192/cmp-nvim-tags",
    },
    config = function()
        local luasnip = require("luasnip")
        local cmp     = require('cmp')

        cmp.setup({
            view = {
                docs = {
                    auto_open = true
                }
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                documentation = cmp.config.window.bordered({
                    border = "single"
                }),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-y>"]     = cmp.mapping.confirm({
                    select = false,
                    behavior = cmp.ConfirmBehavior.Insert,
                }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ["<Tab>"]     = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"]   = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
                {
                    name = "lazydev",
                    group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                }
            })
        })
    end,
}
