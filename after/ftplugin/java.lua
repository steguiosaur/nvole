local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then return end
local jdtls_dap = require("jdtls.dap")
local jdtls_setup = require("jdtls.setup")

local home = os.getenv("HOME")

local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages/"
local path_to_jdtls_package = path_to_mason_packages .. "jdtls/"
local path_to_jdebug_package = path_to_mason_packages .. "java-debug-adapter/"
local path_to_jtest_package = path_to_mason_packages .. "java-test/"

-- local jdtls_path = path_to_jdtls_package .. "jdtls"
-- local path_to_plugins = path_to_jdtls_package .. "plugins/"

local path_to_config = path_to_jdtls_package .. "/config_linux_arm"
-- [CRITICAL]
local path_to_jar = path_to_jdtls_package .. "plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"
local lombok_path = path_to_jdtls_package .. "/lombok.jar"

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = jdtls_setup.find_root(root_markers)
if root_dir == "" then return end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace" .. project_name

local bundles = {
    vim.fn.glob(path_to_jdebug_package .. "extension/server/com.microsoft.java.debug.plugin-*.jar", true)
}

vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_jtest_package .. "extension/server/*.jar", true), "\n"))

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
        },
    }
}

config['on_attach'] = function(client, bufnr)
    jdtls.setup_dap({ hotcodereplace = "auto" })
    jdtls_dap.setup_dap_main_class_configs()
    jdtls_setup.add_commands()

    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

local capabilities = {
    workspace = {
        configuration = true
    },
    textDocument = {
        completion = {
            completionItem = {
                snippetSuport = true
            }
        }
    }
}

config.capabilities = capabilities
local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

config.init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities
}

require('jdtls').start_or_attach(config)
