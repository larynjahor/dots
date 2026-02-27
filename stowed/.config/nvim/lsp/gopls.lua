local arcadia_marker = "/arcadia"

local function is_arcadia(root_dir)
    if root_dir == nil then
        return false
    end

    return root_dir:sub(-string.len(arcadia_marker)) == arcadia_marker
end

local targets = {
    -- "yy/backend/libs/go",
    -- "thefeed/backend/libs",
    "neuroexpert/backend",
    "neuroexpert/tasklets",
    "neuro/go",
    -- "browser/backend/extra/summary-bot",
    -- "portal/avocado/morda-go",
    -- "library/go/yandex/oauth",
    "library/go/porto",
    "junk/larynjahor",
    -- "neuro/go/tasklets"
}


local filters = {}

for _, target in ipairs(targets) do
    table.insert(filters, "+"..target)
end

local function get_top_level_dirs(path)
    local dirs = {}
    local handle = vim.loop.fs_scandir(path)
    if handle then
        while true do
            local name, type = vim.loop.fs_scandir_next(handle)
            if not name then break end
            if type == "directory" and not name:match("^%.") then
                table.insert(dirs, name)
            end
        end
    end
    return dirs
end

-- Add exclude filters for directories not in targets
if vim.fn.isdirectory(vim.fn.expand("~/arcadia")) == 1 then
    local arcadia_dirs = get_top_level_dirs(vim.fn.expand("~/arcadia"))

    -- Create a set of top-level target directories for quick lookup
    local target_top_dirs = {}
    for _, target in ipairs(targets) do
        local top_dir = target:match("^([^/]+)")
        if top_dir then
            target_top_dirs[top_dir] = true
        end
    end

    -- Add exclude filters for directories not in targets
    for _, dir in ipairs(arcadia_dirs) do
        if not target_top_dirs[dir] then
            table.insert(filters, "-" .. dir)
        end
    end
end

return {
    settings = {
        gopls = {
            staticcheck = true,
            verboseWorkDoneProgress = true,
            analysisProgressReporting = true,
            env = {
                CGO_ENABLED = "0",
            },
        }
    },
    before_init = function(params, config)
        if is_arcadia(params.rootPath) then
            local env = {
                -- GOPACKAGESDRIVER = "/Users/larynjahor/gits/spd/spd",
                GOPACKAGESDRIVER = "/Users/larynjahor/gits/stdpd/stdpd",
                GOFLAGS = "-mod=vendor",
                SPDTARGETS = table.concat(targets, ","),
                -- SPDTARGETS = "neuroexpert,neuro/go",
            }

            config.settings.gopls.env = vim.tbl_extend("force", config.settings.gopls.env, env)
            config.settings.gopls.directoryFilters = filters
        end
    end,
}
