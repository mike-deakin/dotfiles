local lsp_config = require'lsp'

local config = {
    cmd = { vim.env.HOME .. '/.config/lsp/jdtls/bin/jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    on_attach = lsp_config.on_attach,
    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = 'JavaSE-17',
                        path = vim.env.HOME .. '/.sdkman/candidates/java/17.0.7-oracle'
                    },
                }
            }
        }
    }
}

require('jdtls').start_or_attach(config)
