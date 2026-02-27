-- require('go').setup()

vim.o.softtabstop    = 4
vim.b.softtabstop    = 4

if true then
    return 
end

local q = vim.treesitter.query.parse("go", [[
(if_statement 
    condition: (binary_expression
        left: (identifier) @val (#eq? @val "err")
        operator: ("!=")
        right: (nil))
    consequence: (block (return_statement (expression_list [
        (identifier)
        (call_expression
            function: (selector_expression 
                field: (field_identifier))
            arguments: (_))] @ret .))
        ) @block)
]])

local bufnr = vim.api.nvim_get_current_buf()
local ns = vim.api.nvim_create_namespace("go-err")

vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("CollapseErrors", {clear = true}),
    buffer = bufnr,
    callback = function()
        local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
        local height = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].height
        local root = vim.treesitter.get_parser(bufnr, "go"):parse()[1]:root()

        vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

        for _, matches in q:iter_matches(root, bufnr) do
            local captures = {}
            for id, nodes in pairs(matches) do
                captures[q.captures[id]] = nodes[1]
            end

            local start_row, start_col, end_row = captures["block"]:range()
            if start_row > row + height + height/2 then break end
            if row-1 >= start_row and row-1 <= end_row then goto continue end

            vim.api.nvim_buf_set_extmark(bufnr, ns, start_row, start_col+1, {
                virt_text_pos = "inline",
                virt_text = {{string.format(" -> %s", vim.treesitter.get_node_text(captures["ret"], bufnr)), "Comment"}},
            })

            vim.api.nvim_buf_set_extmark(bufnr, ns, start_row+1, 0, {
                end_row = end_row,
                conceal_lines = "",
            })

            ::continue::
        end
    end,
})

