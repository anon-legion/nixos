return {
  "nvim-neotest/neotest",
  optional = true,
  dependencies = {
    "Issafalcon/neotest-dotnet",
  },
  opts = {
    adapters = {
      ["neotest-dotnet"] = {
        -- Here we can set options for neotest-dotnet
      },
    },
  },
}
