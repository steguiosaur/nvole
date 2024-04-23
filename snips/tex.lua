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

    -- Simple Preamble
    s({trig="preamb", dscr="Basic LaTeX Preamble"},
        {
            t({"\\documentclass[12pt,a4paper]{article}"}),
            t({"", "\\usepackage[utf8]{inputenc}"}),
            t({"", "\\usepackage[T1]{fontenc}"}),
            t({"", "\\usepackage[margin=0.5in]{geometry}"}),
            t({"", "\\usepackage{enumitem}"}),
            t({"", "\\usepackage{hyperref}"}),
            t({"", "\\usepackage{amsmath}"}),
            t({"", "\\usepackage{amssymb}"}),
            t({"", "\\usepackage{tcolorbox}"}),
            t({"", "\\usepackage{graphicx}"}),
            t({"", "\\usepackage{listings}"}),
            t({"", "\\usepackage{svg}"}),
            t({"", "\\usepackage{adjustbox}"}),
            t({"", "\\tolerance=1"}),
            t({"", "\\emergencystretch=\\maxdimen"}),
            t({"", "\\hyphenpenalty=10000"}),
            t({"", "\\hbadness=10000"}),
            t({"", "\\pagestyle{empty}"}),
            t({"", "\\graphicspath{{./images/}}"}),
        }
    ),

    s({trig="apabib", dscr="APA Bibtex citation"},
        {
            t({ "\\bibliographystyle{apalike}"}),
            t({ "", "\\bibliography{" }), i(0), t({"}"}),
        }
    ),

    -- Environment
    s({trig="beg", dscr="LaTeX environment begin"},
        {
            t({ "\\begin{" }), i(1), t({"}"}),
            t({ "", "    "}),i(0),
            t({ "", "\\end{" }), rep(1), t({"}"}),
        }
    ),

    -- Image & SVG
    s({trig="img", dscr="Requires 'graphicx' package"}, {
        t("\\noindent\\includegraphics[width=\\textwidth]{"), i(1, "image_path"), t("}"),
    }),

    s({trig="svg", dscr="Requires 'svg' and 'adjustbox' package"}, {
        t("\\adjustbox{width=\\textwidth}{\\includesvg{"), i(1, "svg_path"), t("}}"),
    }),

    -- Figure
    s({trig="fig", dscr="Centered figure"},
        {
            t({ "\\begin{figure}[hbt!]",
                "   \\center"}),
            t({ "", "   \\noindent\\includegraphics[width=\\textwidth]{"}), i(1, "image_path"), t("}"),
            t({ "", "   \\caption{"}), i(2, "caption"), t("}"),
            t({ "", "   \\label{fig:"}), i(3, "figure"), t("}"),
            t({ "", "\\end{figure}"}),
        }
    ),

    -- Hyperlink Reference
    s({trig="href", dscr="The hyperref package's href{}{} command (for url links)"}, {
        t("\\href{"), i(1, "url"), t("}{"), i(2, "title"), t("}")
    }),

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

    -- Tcolorbox
    s({trig="box", dscr="Use 'tcolorbox' package in preamble"},
        {
            t({ "\\begin{tcolorbox}[colback=white"}), i(0), t({"]",
                "    "}),i(1),
            t({ "", "\\end{tcolorbox}"}),
        }
    ),

    -- Code Listings
    s({trig="lst", dscr="Code listings environment"},
        {
            t({ "\\begin{listings}[style=]",
                "    "}),i(1),
            t({ "", "\\end{listings}"}),
        }
    ),

    s({trig="tbl", dscr="A LaTeX table environment"},
        {
            t({ "\\begin{tabular}{ c c }",
                "    "}),i(1),
            t({ "", "\\end{tabular}"}),
        }
    ),

    -- Minipage
    s({trig="mini", dscr="MiniPage environment"},
        {
            t({ "\\begin{minipage}[b]{.5\\textwidth}",
                "    "}), i(1),
            t({ "", "\\end{minipage}"}),
            t({ "", "\\hfill"}),
            t({ "", "\\begin{minipage}[b]{.4\\textwidth}",
                "    "}), i(2),
            t({ "", "\\end{minipage}"}),
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
