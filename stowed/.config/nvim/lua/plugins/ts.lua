local disable_func = function(lang, buf)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
        return true
    end
end

return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "rrethy/nvim-treesitter-textsubjects",
    },
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "go", "templ", "vimdoc", "bash", "zig" },
            sync_install = false,
            highlight = {
                disable = disable_func,
                enable = true,
            },
            indent = {
                disable = disable_func,
                enable = true,
            },
        })
    end,
}
