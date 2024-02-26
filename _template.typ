#let template(
    title: none, subtitle: none,
    authors: (), contributors: (),
    ammended: none,
    doc
) = {
    set text(font: "Nimbus Sans")
    set page("a4")
    show heading: set text(font: "Rajdhani")
    show heading.where(level: 1): it => {
        pagebreak()
        set text(font: "Rajdhani")
        block(
            locate(loc => {
                if counter(heading).at(loc).at(0) != 0 {
                    counter(heading).display()
                }
                [ #it.body ]
            })
        )
    }

    v(2fr)
    align(center, {
        text(28pt, font: "Rajdhani", weight: "bold", title)
        if (subtitle != none) {
            v(12pt)
            text(20pt, font: "Rajdhani", weight: "semibold", subtitle)
        }

        v(1fr)
        let count = authors.len()
        let ncols = calc.min(count, 3)
        grid(
            columns: (1fr,) * ncols,
            row-gutter: 12pt,
            ..authors.map(a => text(16pt, a))
        )

        if (contributors.len() > 0) {
            v(12pt)
            let count = contributors.len()
            let ncols = calc.min(count, 3)
            grid(
                columns: (1fr,) * ncols,
                row-gutter: 12pt,
                ..contributors.map(c => text(14pt, c))
            )
        }

        if (ammended != none) {
            v(1fr)
            ammended
        }
    })
    v(4fr)

    set page(numbering: "i")
    counter(page).update(1)

    outline()

    set heading(numbering: "1.")
    show enum: it => locate(loc => {
        // Retrieve the last heading so we know what level to step at
        let headings = query(selector(heading).before(loc), loc)
        let last = headings.at(-1)


        // Combine the output items
        let output = ()
        for item in it.children {
            output.push([
                #counter(heading).step(level: last.level + 1)
                #counter(heading).display()
            ])
            output.push([
                #text(item.body)
                #parbreak()
            ])
        }

        // Display in a grid
        grid(
            columns: (auto, 1fr),
            column-gutter: 1em,
            row-gutter: 1em,
            ..output
        )
    })

    set page(numbering: "1")
    counter(page).update(1)
    doc
}
