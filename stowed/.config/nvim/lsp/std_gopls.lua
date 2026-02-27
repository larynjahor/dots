return {
    cmd = {"gopls"},
    root_dir = function(bufnr, on_dir)
        root = vim.fs.root(bufnr, ".arcadia.root") 
        gomod = vim.fs.root(bufnr, "go.mod") 

        if gomod == nil then
            return nil
        end

        if root == gomod then
            return nil
        end

        on_dir(gomod)
    end,
}
