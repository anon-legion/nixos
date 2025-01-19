return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        nixd = {},
        omnisharp = {
          cmd = {
            "dotnet",
            "/nix/store/63r3d7gv7mkl6clafaln4gms72g6gq3v-omnisharp-roslyn-1.39.13/lib/omnisharp-roslyn/",
          },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
      },
    },
  },
}
