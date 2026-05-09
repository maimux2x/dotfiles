return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',

    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'RRethy/nvim-treesitter-endwise',
      'andymass/vim-matchup',
      'windwp/nvim-ts-autotag',
    },

    config = function()
      local ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'csv',
        'diff',
        'dockerfile',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'glimmer',
        'go',
        'gomod',
        'gpg',
        'graphql',
        'html',
        'javascript',
        'jq',
        'jsdoc',
        'json',
        'json5',
        'jsonc',
        'kdl',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'mermaid',
        'proto',
        'python',
        'rbs',
        'ruby',
        'rust',
        'scss',
        'sparql',
        'sql',
        'tera',
        'toml',
        'tsv',
        'tsx',
        'turtle',
        'typescript',
        'vim',
        'xml',
        'yaml',
      }

      local installed = require('nvim-treesitter.config').get_installed()
      local to_install = vim.iter(ensure_installed)
        :filter(function(p) return not vim.tbl_contains(installed, p) end)
        :totable()

      if #to_install > 0 then
        require('nvim-treesitter').install(to_install)
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      require('nvim-ts-autotag').setup()
    end,
  },
}
