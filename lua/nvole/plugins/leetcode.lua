return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    enabled = false,
    dependencies = {
        -- "nvim-telescope/telescope.nvim",
        "ibhagwan/fzf-lua",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        arg = "lc",

        lang = "python3",

        injector = {
            ["python3"] = {
                before = true
            },
            ["cpp"] = {
                before = { "#include <bits/stdc++.h>", "using namespace std;" },
                after = "int main() {}",
            },
            ["java"] = {
                before = "import java.util.*;",
            },
        },

        description = {
            position = "left",
            width = "40%",
            show_stats = true,
        },

        keys = {
            toggle = { "q" },
            confirm = { "<CR>" },

            reset_testcases = "r",
            use_testcase = "U",
            focus_testcases = "H",
            focus_result = "L",
        },
    },
}
