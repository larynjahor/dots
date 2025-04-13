return {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("hlchunk").setup({
            indent = {
                enable = true,
            },
            chunk = {
                enable = true,
                delay = 10,
                chars = {
                    horizontal_line = "─",
                    vertical_line = "│",
                    left_top = "┌",
                    left_bottom = "└",
                    right_arrow = ">",
                },
            },
        })

        vim.api.nvim_set_hl(0, "HLChunk1", { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Search")), "bg", "gui") })
        vim.api.nvim_set_hl(0, "HLChunk2", { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Error")), "fg", "gui") })
    end
}

