require("neotest").setup({
  adapters = {
    require("neotest-plenary"),
  },
})

require 'caskey'.emit('NeoTestConfigured')
