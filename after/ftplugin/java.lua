local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then return end
local jdtls_dap = require("jdtls.dap")
local jdtls_setup = require("jdtls.setup")

local home = os.getenv("HOME")

local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages/"
local path_to_jdtls_package = path_to_mason_packages .. "jdtls/"
local path_to_jdebug_package = path_to_mason_packages .. "java-debug-adapter/"
local path_to_jtest_package = path_to_mason_packages .. "java-test/"

local path_to_config = vim.fn.has("Android") == 1 and path_to_jdtls_package .. "/config_linux_arm" or
    path_to_jdtls_package .. "/config_linux"

-- [CRITICAL]
local jdtls_launcher_glob = path_to_jdtls_package .. "plugins/org.eclipse.equinox.launcher_*.jar"
local launchers = vim.fn.glob(jdtls_launcher_glob, false, true)
if vim.tbl_isempty(launchers) then
    vim.notify("JDTLS launcher JAR not found at: " .. jdtls_launcher_glob, vim.log.levels.ERROR)
    return
end
local path_to_jar = launchers[1]

local lombok_path = path_to_jdtls_package .. "lombok.jar"
if vim.fn.filereadable(lombok_path) == 0 then
    vim.notify("Lombok JAR not found at: " .. lombok_path .. ". JDTLS might work but Lombok features won't.",
        vim.log.levels.WARN)
end



local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = jdtls_setup.find_root(root_markers)
if root_dir == "" then return end

local project_name = vim.fn.fnamemodify(root_dir, ":t")
local workspace_dir = home .. "/.cache/jdtls/workspace" .. project_name


local bundles = {}
local jdebug_jars = vim.fn.glob(path_to_jdebug_package .. "extension/server/com.microsoft.java.debug.plugin-*.jar", true,
    true)
if not vim.tbl_isempty(jdebug_jars) then
    vim.list_extend(bundles, jdebug_jars)
else
    vim.notify("Java Debug Adapter JARs not found.", vim.log.levels.WARN)
end

local jtest_jars = vim.fn.glob(path_to_jtest_package .. "extension/server/*.jar", true, true)
if not vim.tbl_isempty(jtest_jars) then
    vim.list_extend(bundles, jtest_jars)
else
    vim.notify("Java Test Runner JARs not found.", vim.log.levels.WARN)
end


local config = {
    cmd = {
        "java",

        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "-javaagent:" .. lombok_path,
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",

        "-jar", path_to_jar,
        "-configuration", path_to_config,
        "-data", workspace_dir,
    },

    root_dir = root_dir,

    settings = {
        java = {
            home = vim.fn.getenv("JAVA_HOME"),
            eclipse = { downloadSources = true },
            maven = { downloadsources = true },
            codeGeneration = {
                hashCodeEquals = {
                    useInstanceof = true,
                    useJava7Objects = true,
                },
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    codeStyle = "STRING_BUILDER_CHAINED",
                },
                useBlocks = true,
            },
            contentProvider = { preferred = "fernflower" },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            signatureHelp = { enabled = true },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            format = {
                settings = {
                    profile = "GoogleStyle",
                },
            },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
                importOrder = {
                    "java",
                    "javax",
                    "com",
                    "org",
                },
            },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-8",
                        path = "/usr/lib/jvm/java-8-openjdk/",
                    },
                    {
                        name = "JavaSE-11",
                        path = "/usr/lib/jvm/java-11-openjdk/",
                    },
                    {
                        name = "JavaSE-17",
                        path = "/usr/lib/jvm/java-17-openjdk/",
                    },
                    {
                        name = "JavaSE-21",
                        path = "/usr/lib/jvm/java-21-openjdk/",
                    },
                    {
                        name = "JavaSE-24",
                        path = "/usr/lib/jvm/java-24-openjdk/",
                    },
                },
            },
        },
    },
    capabilities = (function()
        local caps = vim.lsp.protocol.make_client_capabilities()

        local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if cmp_nvim_lsp_ok then
            caps = cmp_nvim_lsp.default_capabilities(caps)
        end
        -- caps.textDocument.completion.completionItem.snippetSupport = true
        return caps
    end)(),

    init_options = {
        bundles = bundles,
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
    },

    on_attach = function(client, bufnr)
        jdtls.setup_dap({ hotcodereplace = "auto" }) -- "manual", "never"
        jdtls_dap.setup_dap_main_class_configs()
        jdtls_setup.add_commands()

        vim.api.nvim_buf_create_user_command(bufnr, "JavaFormat", function(opts)
            vim.lsp.buf.format({ async = true, bufnr = bufnr })
        end, { desc = "Format current Java buffer with JDTLS" })

        -- local map_opts = { noremap = true, silent = true, buffer = bufnr }
        -- vim.keymap.set("n", "<leader>jo", "<Cmd>JavaOrganizeImports<CR>", vim.tbl_extend("force", {}, map_opts, { desc = "JDTLS: Organize Imports" }))
        -- vim.keymap.set("n", "<leader>ju", "<Cmd>JavaUpdateConfig<CR>", vim.tbl_extend("force", {}, map_opts, { desc = "JDTLS: Update Project Config" }))
        -- vim.keymap.set("n", "<leader>jd", function() require('jdtls').extract_variable() end, vim.tbl_extend("force", {}, map_opts, { desc = "JDTLS: Extract Variable" }))
        -- vim.keymap.set("v", "<leader>jd", function() require('jdtls').extract_variable(true) end, vim.tbl_extend("force", {}, map_opts, { desc = "JDTLS: Extract Variable (Visual)" }))

        -- client.server_capabilities.documentFormattingProvider = true
        -- client.server_capabilities.documentRangeFormattingProvider = true
    end,
}

jdtls.start_or_attach(config)
