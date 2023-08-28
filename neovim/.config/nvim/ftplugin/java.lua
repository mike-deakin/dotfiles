local lsp_config = require 'lsp'

require('jdtls').start_or_attach({
    cmd = { vim.env.HOME .. '/.config/lsp/jdtls/bin/jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    on_attach = lsp_config.on_attach,
    settings = {
        java = {
            signatureHelp = { enabled = true },
        }
    }
})

--require 'neotest'.setup({
    --log_level = vim.log.levels.DEBUG,
    --adapters = {
        --require 'neotest-junit' ({}),
    --}
--})

--require 'caskey'.emit('NeoTestConfigured')
