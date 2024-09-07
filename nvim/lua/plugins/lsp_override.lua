local util = require("lspconfig.util")

return {
  "neovim/nvim-lspconfig",
  opts = {
    -- options for vim.diagnostic.config()
    ---@type vim.diagnostic.Opts
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
          [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
          [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
        },
      },
    },
    inlay_hints = {
      enabled = false,
    },
    codelens = {
      enabled = false,
    },
    document_highlight = {
      enabled = false,
    },
    capabilities = {},
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
    --@type lspconfig.options
    servers = {
      dartls = {
        cmd = { "dart", "language-server", "--protocol=lsp" },
        filetypes = { "dart" },
        root_dir = util.root_pattern("pubspec.yaml"),
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = false,
                resolveSupport = {
                  properties = { "documentation", "detail", "additionalTextEdits" },
                },
              },
            },
          },
        },
        init_options = {
          onlyAnalyzeProjectsWithOpenFiles = true,
          suggestFromUnimportedLibraries = true,
          closingLabels = true,
          outline = true,
          flutterOutline = true,
        },
        settings = {
          dart = {
            completeFunctionCalls = true,
            showTodos = true,
          },
        },
        docs = {
          description = [[ https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server/tool/lsp_spec Language server for dart. ]],
          default_config = {
            root_dir = [[root_pattern("pubspec.yaml")]],
          },
        },
      },
      lua_ls = {
        ---@type LazyKeysSpec[]
        -- keys = {},
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
            },
            doc = {
              privateName = { "^_" },
            },
            hint = {
              enable = false,
              setType = false,
              paramType = false,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      },
    },
    ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    setup = {
      dartls = function()
        LazyVim.lsp.on_attach(function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end, "dartls")
      end,
    },
  },
}
