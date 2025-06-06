-- Language Server Protocol
local nvim_lsp = require 'lspconfig'
local merge = require 'merge'

local M = {}

M.toggle_hints = function()
  local is_enabled = vim.lsp.inlay_hint.is_enabled()
  vim.lsp.inlay_hint.enable(not is_enabled)
end

local set_mappings = function(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  vim.keymap.set('n', 'gs', '<cmd>Telescope lsp_document_symbols<CR>', opts)
  vim.keymap.set('n', 'gS', '<cmd>Telescope lsp_workspace_symbols<CR>', opts)
  vim.keymap.set('n', '<C-n>', M.toggle_hints, opts)
  vim.keymap.set({ 'n', 'i' }, '<C-h>', vim.lsp.buf.hover, opts)
  vim.keymap.set({ 'n', 'i' }, '<C-y>', vim.lsp.buf.signature_help, opts)
  --vim.keymap.set({ 'n', 'i' }, '<C-d>', peek_definition, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.keymap.set('n', '<space>D', '<cmd>Telescope lsp_type_definitions<CR>', opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<space>ca', require('actions-preview').code_actions, opts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
  vim.keymap.set('n', '<space>do', '<cmd>Telescope diagnostics<CR>', opts)
  vim.keymap.set('n', '<space>f', function() require "format-options".editorconfigLspFormat({ async = true }) end, opts)
  vim.keymap.set('n', '<space>oi',
    function() vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true }) end, opts)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
  if client.server_capabilities.signatureHelpProvider then
    require('lsp-overloads').setup(client, {})
  end

  set_mappings(bufnr)
end

vim.g.rustaceanvim = {
  server = {
    on_attach = M.on_attach,
    default_settings = {
      ['rust-analyzer'] = {
        cargo = {
          extraEnv = { ["RUSTUP_TOOLCHAIN"] = "stable" }
        }
      }
    }
  }
}

-- cmp completions
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#
-- append items from this list to the above url to see docs
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        hint = {
          enable = true,
        },
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = { enable = false },
      }
    }
  },
  cucumber_language_server = {
    settings = {
      cucumber = {
        glue = { './**/*.java' }
      }
    }
  },
  ruby_lsp = {},
  pylsp = {},
  ts_ls = {},
  gopls = {},
  hls = {},
  elixirls = {
    cmd = { vim.env.HOME .. '/.config/lsp/elixirls/language_server.sh' } -- TODO: install through scripts
  },
  kotlin_language_server = {
    --cmd = {
      --vim.fn.stdpath('data') ..
      --'/site/pack/packer/start/kotlin-language-server/server/build/install/server/bin/kotlin-language-server' },
  },
  jsonls = {},
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/circleciconfig.json"] = "/.circleci/*",
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          ["https://json.schemastore.org/swagger-2.0.json"] = "**/openapi.yaml",
        }
      }
    }
  },
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for lsp, conf in pairs(servers) do
  nvim_lsp[lsp].setup(merge({
    on_attach = M.on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities
  }, conf))
end

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

return M