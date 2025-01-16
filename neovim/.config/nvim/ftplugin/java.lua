local lsp_config = require 'lsp'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.env.HOME .. '/.cache/jdtls/' .. project_name

require('jdtls').start_or_attach({
    cmd = {
        vim.env.HOME .. '/.config/lsp/jdtls/bin/jdtls',
        '--jvm-arg=-javaagent:' .. vim.env.HOME .. '/.config/libs/lombok.jar',
        '-configuration ' .. vim.env.HOME .. '/.cache/jdtls',
        '-data', workspace_dir,
    },
    on_attach = lsp_config.on_attach,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            completion = {
                importOrder = { -- Import order roughly matches IntelliJ ordering
                    "",         -- "All other packages"
                    "java",
                    "javax",
                    "#", -- "All static imports"
                }
            },
            --configuration = {
            --runtimes = {
            --{
            --name = 'JavaSE-17',
            --path = '~/.sdkman/candidates/java/17.0.2-oracle'
            --}
            --},
            --maven = {
            --downloadSources = true,
            --}
            --},
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

vim.api.nvim_set_option_value('shiftwidth', 4, {})
