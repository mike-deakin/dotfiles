local M = {}

M.moveLineDown = function()
    vim.cmd ( '.move.+'..vim.v.count1 )
end

M.moveLineUp = function()
    vim.cmd ( '.move.-'..(vim.v.count1 + 1) )
end

M.moveLinesDown = function()
    vim.cmd([['<,'>move'>+]]..vim.v.count1)
    vim.cmd([[normal gv]])
end

M.moveLinesUp = function()
    vim.cmd([['<,'>move'<-]]..(vim.v.count1 + 1))
    vim.cmd([[normal gv]])
end

return M
