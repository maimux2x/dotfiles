return {
  'williamboman/mason-lspconfig.nvim',

  dependencies = {
    {
      'williamboman/mason.nvim',
      opts = {}
    }
  },

  config = function()
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
        'glint',
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
        'ts_ls',
        'vimls',
        'yamlls',
      }
    }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          if server_name == 'denols' then
            vim.lsp.config(server_name, {
              root_markers = {'deno.json', 'deno.jsonc'}
            })
          elseif server_name == 'lua_ls' then
            vim.lsp.config(server_name, {
              settings = {
                Lua = {
                  diagnostics = {
                    globals = {'vim'}
                  }
                }
              }
            })
          elseif server_name == 'tsserver' or server_name == 'ts_ls' then
            vim.lsp.config(server_name, {
              root_markers = {'package.json'},
              single_file_support = false
            })
          else
            vim.lsp.config(server_name, {})
          end
          vim.lsp.enable(server_name)
        end
      }
    }
  end
}
