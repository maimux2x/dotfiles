return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',

    dependencies = {
      'RRethy/nvim-treesitter-endwise',
      'andymass/vim-matchup',
      'windwp/nvim-ts-autotag',
    },

    config = function()
      -- vim.treesitter.start を上書きして lang 自動解決とエラー抑制を行う
      vim.treesitter.start = (function(wrapped)
        return function(bufnr, lang)
          lang = lang or vim.api.nvim_get_option_value('filetype', { buf = bufnr })
          pcall(wrapped, bufnr, lang)
        end
      end)(vim.treesitter.start)

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
        callback = function(args)
          vim.treesitter.start(args.buf)
        end,
      })

      require('nvim-ts-autotag').setup()
    end,
  },
}
