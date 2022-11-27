-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'lspconfig.configs'.ls_emmet = {
  default_config = {
    cmd = { 'ls_emmet', '--stdio' };
    filetypes = { 'html', 'css', 'scss', 'xml', 'sass' };
    root_dir = function(_)
      return vim.loop.cwd()
    end;
    settings = {};
  };
}

-- Find langservers at: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local langservers = {
  "html", -- paru -S vscode-html-languageserver
  "cssls", -- paru -S vscode-css-languageserver
  "tsserver", -- paru -S typescript-language-server
  "pylsp", -- paru -S python-lsp-server
  "ls_emmet", -- npm install -g ls_emmet, then moved it to .local/bin
  "sumneko_lua", -- paru -S lua-language-server
}

for _, server in ipairs(langservers) do
  if server == "sumneko_lua" then
    require"lspconfig"[server].setup {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = "/usr/bin/luajit",
          },
          diagnostics = {
            globals = {"vim"},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }
  else
    require"lspconfig"[server].setup {
      capabilities = capabilities
    }
  end
end
