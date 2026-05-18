return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,

  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    'RRethy/nvim-treesitter-endwise',
    'andymass/vim-matchup',
    -- 'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'windwp/nvim-ts-autotag',
  },

  config = function()
    require('nvim-treesitter').install({
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
    })

    vim.api.nvim_create_autocmd('FileType', {
      callback = function() pcall(vim.treesitter.start) end,
    })

    require('nvim-ts-autotag').setup()
  end
}
