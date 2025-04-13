return {
	"ibhagwan/fzf-lua",
	config = function()
		local fzf = require("fzf-lua")

		fzf.setup({
            hls = {
                normal = "Normal",
                border = "Normal",
                title = "Normal",
                title_flags = "Normal",
                backdrop = "Normal",
                preview_normal = "Normal",
                preview_border = "Normal",
                preview_title = "Normal",
                cursor = "Normal",
                cursorline = "Normal",
                cursorlinenr = "Normal",
                search = "Normal",
                scrollborder_e = "Normal",
                scrollborder_f = "Normal",
                scrollfloat_e = "Normal",
                scrollfloat_f = "Normal",
                help_normal = "Normal",
                help_border = "Normal",
                header_bind = "Normal",
                header_text = "Normal",
                path_colnr = "Normal",
                path_linenr = "Normal",
                buf_name = "Normal",
                buf_id = "Normal",
                buf_nr = "Normal",
                buf_linenr = "Normal",
                buf_flag_cur = "Normal",
                buf_flag_alt = "Normal",
                tab_title = "Normal",
                tab_marker = "Normal",
                dir_icon = "Normal",
                dir_part = "Normal",
                file_part = "Normal",
                live_prompt = "Normal",
                live_sym = "Normal",
            },
            fzf_colors = {
                ["fg"] = {"fg", "Normal"},
                ["bg"] = {"bg", "Normal"},
                ["preview-fg"] = {"fg", "Normal"},
                ["preview-bg"] = {"fg", "Normal"},
                ["hl"] = {"bg", "Search"},
                ["hl+"] = {"bg", "Search"},
                ["fg+"] = {"fg", "Normal"},
                ["bg+"] = {"bg", "Visual"},
                ["gutter"] = "-1",
                ["query"] = {"fg", "Normal"},
                ["disabled"] = {"fg", "Normal"},
                ["info"] = {"fg", "Normal"},
                ["border"] = {"fg", "Normal"},
                ["scrollbar"] = {"fg", "Normal"},
                ["preview-border"] = {"fg", "Normal"},
                ["preview-scrollbar"] = {"fg", "Normal"},
                ["separator"] = {"fg", "Normal"},
                ["label"] = {"fg", "Normal"},
                ["preview-label"] = {"fg", "Normal"},
                ["prompt"] = {"fg", "Error"},
                ["pointer"] = {"fg", "Normal"},
                ["marker"] = {"fg", "MoreMsg", "bold"},
                ["spinner"] = {"fg", "Normal"},
                ["header"] = {"fg", "Normal"},
            },
            winopts = {
                border = "single",
                height = 0.9,
                width = 0.9,
                preview = {
                    wrap = "nowrap",
                    hidden = "hidden",
                },
            },
        })

        vim.keymap.set("n", "<C-p>", require("fzf-lua").files)
        vim.keymap.set("n", "<M-s>", require("fzf-lua").live_grep)
        vim.keymap.set("n", "<leader>fF", require("fzf-lua").builtin)
        vim.keymap.set("n", "<M-x>", require("fzf-lua").commands)
        vim.keymap.set("n", "<leader>fh", require("fzf-lua").help_tags)
        vim.keymap.set("n", "<leader>fH", require("fzf-lua").highlights)
        vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers)
        vim.keymap.set("n", "<leader>q", require("fzf-lua").quickfix)
        vim.keymap.set("n", "<C-x><C-r>", require("fzf-lua").oldfiles)
        vim.keymap.set("n", "<C-r>", require("fzf-lua").resume)
        vim.keymap.set("n", "gr", require("fzf-lua").lsp_references)
        vim.keymap.set("n", "gi", require("fzf-lua").lsp_implementations)

        vim.keymap.set({ "n" }, "<C-]>", require("fzf-lua").buffers)
        vim.keymap.set({ "n" }, "<C-[>", require("fzf-lua").quickfix)

        fzf.register_ui_select()
    end,
}
