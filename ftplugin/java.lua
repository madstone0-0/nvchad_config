local JDTLS_LOCATION = vim.fn.stdpath "data" .. "/mason/packages/jdtls"

local HOME = os.getenv "HOME"
local WORKSPACE_PATH = HOME .. "/workspace/java/"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

local config = {
    init_options = {
        bundles = {
            vim.fn.glob "/home/mads/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar",
        },
    },
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "-Xmx1G",
        "-noverify",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob(JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        JDTLS_LOCATION .. "/config_linux",
        "-data",
        workspace_dir,
    },
    extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
    signatureHelp = { enabled = true },
    contentProvider = { preferred = "fernflower" },

    maven = {
        downloadSources = true,
    },
    referencesCodeLens = {
        enabled = true,
    },
    references = {
        includeDecompiledSources = true,
    },
    inlayHints = {
        parameterNames = {
            enabled = "all", -- literals, all, none
        },
    },
    format = {
        enabled = false,
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
            "org.mockito.ArgumentMatchers.*",
            "org.mockito.Answers.RETURNS_DEEP_STUBS",
        },
        filteredTypes = {
            "com.sun.*",
            "io.micrometer.shaded.*",
            "java.awt.*",
            "jdk.*",
            "sun.*",
        },
    },

    sources = {
        organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
        },
    },
    codeGeneration = {
        toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
    },
    import = { enabled = true },
    rename = { enabled = true },
    configuration = {
        runtimes = {
            {
                name = "JavaSE-21",
                path = "/usr/lib/jvm/java-21-openjdk/",
            },
            {
                name = "JavaSE-22",
                path = "/usr/lib/jvm/java-22-openjdk/",
            },
        },
    },
}

require("jdtls").start_or_attach(config)
