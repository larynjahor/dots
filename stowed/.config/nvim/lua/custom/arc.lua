local function copy_arcadia_link(rev)
    local _, file_path = vim.fn.expand("%:p"):match("(.+)(arcadia/.+)")
    if file_path == nil then
        print("not an arcadia repo")
        return
    end

    local cur_begin = vim.fn.getpos("v")[2]
    local cur_end = vim.fn.line(".")

    local range = string.format("L%d-%d", cur_begin, cur_end)

    if tonumber(cur_begin) > tonumber(cur_end) then
        range = string.format("L%d-%d", cur_end, cur_begin)
    end


    local link = string.format("https://a.yandex-team.ru/%s?rev=%s#%s", file_path, rev, range)
    print(link)
    vim.cmd(string.format([[call setreg("+", "%s")]], link))
end

vim.keymap.set({"n", "x"}, "<leader>at", function()
    copy_arcadia_link("trunk")
end)

vim.keymap.set({"n", "x"}, "<leader>ab", function()
    local f = assert(io.popen('arc rev-parse HEAD', 'r'))
    local rev = f:read('*all'):gsub("%s*", "")
    f:close()
    copy_arcadia_link(rev)
end)