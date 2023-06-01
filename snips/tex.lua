---@diagnostic disable: undefined-global
return {
    -- Typewritter Text
    s({trig="tt", dscr="Expands 'tt' into '\texttt{}'"}, {
        t("\\texttt{"), i(1), t("}"),
    }),

    -- Italic Text
    s({trig="it", dscr="Expands 'it' into '\textit{}'"}, {
        t("\\textit{"), i(1), t("}"),
    }),

    -- Bold Text
    s({trig="bf", dscr="Expands 'bf' into '\textbf{}'"}, {
        t("\\textbf{"), i(1), t("}"),
    }),

    -- Hyperlink Reference
    s({trig="href", dscr="The hyperref package's href{}{} command (for url links)"},
        fmta(
            [[\href{<>}{<>}]],
            {
                i(1, "url"),
                i(2, "name"),
            }
        )
    ),

    -- Enumerate
    s({trig="enum", dscr="A LaTeX enumerate environment"},
        {
            t({ "\\begin{enumerate}",
                "    \\item "}),i(1, "item"),
            t({ "", "\\end{enumerate}"}),
        }
    ),

    -- Itemize
    s({trig="itm", dscr="A LaTeX itemize environment"},
        {
            t({ "\\begin{itemize}",
                "    \\item "}),i(1, "item"),
            t({ "", "\\end{itemize}"}),
        }
    ),


-- MATH SNIPPETS
    -- Math Typewritter Text
    s({trig="mtt", dscr="Expands 'tt' into '\\mathtt{}'"}, {
        t("\\mathtt{"), i(1), t("}"),
    }),

    -- Math Italic Text
    s({trig="mit", dscr="Expands 'it' into '\\mathit{}'"}, {
        t("\\mathit{"), i(1), t("}"),
    }),

    -- Math Bold Text
    s({trig="mbf", dscr="Expands 'bf' into '\\mathbf{}'"}, {
        t("\\mathbf{"), i(1), t("}"),
    }),

    -- Fraction
    s({trig="frac", dscr="Expands 'frac' into '\frac{}{}'"},{
            t("\\frac{"), i(1), t("}{"), i(2), t("}")
        }
    ),

    -- Summation
    s({trig="summ", dscr="Expands 'summation' into '\\sum_{}^{}'"},{
            t("\\sum_{"), i(1), t("}^{"), i(2), t("}")
        }
    ),

    -- Integral
    s({trig="integ", dscr="Expands 'integral' into '\\int_{}^{}'"},{
            t("\\int_{"), i(1), t("}^{"), i(2), t("}")
        }
    ),

    -- Autotriggered Greek symbols
	s({ trig = ";a", snippetType = "autosnippet" }, {
		t("\\alpha"),
	}),
	s({ trig = ";b", snippetType = "autosnippet" }, {
		t("\\beta"),
	}),
	s({ trig = ";g", snippetType = "autosnippet" }, {
		t("\\gamma"),
	}),
	s({ trig = ";S", snippetType = "autosnippet" }, {
		t("\\Sigma"),
	}),
	s({ trig = ";O", snippetType = "autosnippet" }, {
		t("\\Omega"),
	}),

    -- Equation
    s({trig="eq", dscr="A LaTeX equation environment"},
        {
            t({ "\\begin{equation*}",
                "    "}),i(1),
            t({ "", "\\end{equation*}"}),
        }
    ),

    -- Aligned Equation
    s({trig="align", dscr="A LaTeX equation environment"},
        {
            t({ "\\begin{aligned}",
                "    "}),i(1),
            t({ "", "\\end{aligned}"}),
        }
    ),
}
