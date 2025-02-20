local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybinds
	-- to learn the available actions
	lsp_zero.default_keymaps({buffer = bufnr})
end)

local lspconfig = require('lspconfig')

lspconfig.dartls.setup({})
lspconfig.lua_ls.setup({
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
})

-- here you can setup the language servers

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {"gopls"},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
} )
