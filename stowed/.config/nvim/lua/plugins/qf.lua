return {
    "kevinhwang91/nvim-bqf",
    dependencies = {
        "stevearc/quicker.nvim",
    },
    config = function()
        require('bqf').setup({
            auto_enable = true,
            auto_resize_height = true,
            preview = {
                border = "single",
                winblend = 0,
            }
        })
        require("quicker").setup()
    end,
}
