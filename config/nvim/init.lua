local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath})
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup 'plugins'

vim.opt.breakindent   = true
vim.opt.cursorline    = true
vim.opt.fileencodings = {'ucs-boms', 'utf-8', 'cp932', 'euc-jp'}
vim.opt.list          = true
vim.opt.number        = true
vim.opt.tabstop       = 4
vim.opt.wildmode      = {'longest:full', 'full'}
-- share clipboard with OS
vim.opt.clipboard:append('unnamedplus,unnamed')

-- Copy current file path (relative) to clipboard
vim.keymap.set('n', '<Space>%',  ':let @+ = expand("%")<CR>')
-- Remove Search Highlights
vim.keymap.set('n', '<Space>h',  ':nohlsearch<CR>')
-- Insert current file's directory path
vim.keymap.set('c', '<C-x>', "<C-r>=expand('%:p:h')<CR>/")
-- Sort Selected Lines
vim.keymap.set('x', '<Space>s', ':sort<CR>')

if vim.fn.executable('rg') == 1 then
  vim.o.grepprg    = 'rg --vimgrep --hidden'
  vim.o.grepformat = '%f:%l:%c:%m'
end

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = {'vim', 'grep'},

  callback = function()
    if #vim.fn.getqflist() > 1 then
      vim.cmd 'cwindow'
    end
  end
})

vim.filetype.add({
  extension = {
    axlsx = 'ruby',
    jb    = 'ruby'
  },

  filename = {
    ['Thorfile'] = 'ruby'
  }
})
