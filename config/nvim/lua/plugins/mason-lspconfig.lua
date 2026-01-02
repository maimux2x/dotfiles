return {
  'williamboman/mason-lspconfig.nvim',

  dependencies = {
    {
      'williamboman/mason.nvim',
      opts = {}
    }
  },

  config = function()
    local lspconfig = require('lspconfig')

    vim.lsp.config('ruby_lsp', {
      init_options = {
        addonSettings = {
          ['Ruby LSP Rails'] = {
            enablePendingMigrationsPrompt = false
          }
        }
      }
    })

    vim.lsp.config('denols', {
      root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc')
    })

    -- vim.lsp.config('ts-ls', {
    --   root_dir            = lspconfig.util.root_pattern('package.json'),
    --   single_file_support = false
    -- })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          diagnostics = {
            globals = {'vim'}
          }
        }
      }
    })

    -- glintはnvim-lspconfig内部でconfig nilエラーが発生するため無効化
    vim.lsp.enable('glint', false)

    require('mason-lspconfig').setup {
      ensure_installed = {
        'ansiblels',
        'bashls',
        'clangd',
        'css_variables',
        'cssls',
        'denols',
        'docker_compose_language_service',
        'dockerls',
        'ember',
        'eslint',
        -- 'glint', -- nvim-lspconfig内部でconfig nil エラーが発生するため無効化
        'gopls',
        'graphql',
        'html',
        'jdtls',
        'jsonls',
        'lemminx',
        'lua_ls',
        'marksman',
        'pylsp',
        'rubocop',
        'ruby_lsp',
        'rust_analyzer',
        'sqlls',
        'stimulus_ls',
        'taplo',
        'terraformls',
        -- 'ts-ls',
        'vimls',
        'yamlls',
      },

      handlers = {
        function(server_name)
          local opts = vim.lsp.get_config and vim.lsp.get_config(server_name) or {}
          lspconfig[server_name].setup(opts)
        end,
      }
    }
  end
}
