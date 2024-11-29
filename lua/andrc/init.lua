require("andrc.set")
require("andrc.remap")

require("andrc.lazy_init")

local augroup = vim.api.nvim_create_augroup
local usrGroup = augroup('andrc', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = usrGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
