-- assuming we're also using `ruff`
--
-- References
-- https://hwisnu.bearblog.dev/neovim-config-ruff-linter-pyright-hover-info
-- https://microsoft.github.io/pyright/#/settings?id=pyright-settings

return {
    settings = {
        python = {
            analysis = {
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                    reportUnusedVariable = "warning",
                },
                typeCheckingMode = "standard",
                diagnosticMode = "openFilesOnly",
            },
        },
        disableOrganizeImports = true,
    }
}
