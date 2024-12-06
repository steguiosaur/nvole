---@diagnostic disable: undefined-global
return {
    -- Headers
    s({trig="h1", dscr="header"}, {
        t("# "), i(1),
    }),

    -- Headers
    s({trig="h2", dscr="header"}, {
        t("## "), i(1),
    }),

    -- Headers
    s({trig="h3", dscr="header"}, {
        t("### "), i(1),
    }),

    -- Headers
    s({trig="h4", dscr="header"}, {
        t("#### "), i(1),
    }),

    -- Headers
    s({trig="h5", dscr="header"}, {
        t("##### "), i(1),
    }),

    -- Bold Font
    s({trig="it", dscr="Italics shortcut *italics*"}, {
        t("*"), i(1), t("*"),
    }),

    -- Italics Font
    s({trig="bf", dscr="Bold shortcut **bold**"}, {
        t("**"), i(1), t("**"),
    }),

    -- Monospace
    s({trig="tt", dscr="Monospace shortcut `monospace`"}, {
        t("`"), i(1), t("`"),
    }),

    -- -- Commands and code
    -- s({trig="code", dscr="Command environment"},
    --     {
    --         t({ "```console",
    --             ""}),i(1),
    --         t({ "", "```"}),
    --     }
    -- ),

    -- link
    s({trig="link", dscr="Insert [link](www.url.com)"}, {
        t("["), i(1), t("]("), i(2), t(")"),
    }),

    -- check
    s({trig="check", dscr="Box check"}, {
        t("- ["), i(1), t("] "), i(2),
    }),

}
