#import "code.typ": *
#import "components.typ": *
#import "callout.typ": *
#import "theorem.typ": *
#import "@preview/quick-maths:0.2.1": shorthands

#let config(
  lang: "ja",
  seriffont: "New Computer Modern", // or "Libertinus Serif" or "Source Serif Pro"
  seriffont-cjk: "Harano Aji Mincho", // or "Yu Mincho" or "Hiragino Mincho ProN"
  sansfont: "Source Sans Pro", // or "Arial" or "New Computer Modern Sans" or "Libertinus Sans"
  sansfont-cjk: "Harano Aji Gothic", // or "Yu Gothic" or "Hiragino Kaku Gothic ProN"
  paper: "a4", // "a*", "b*", or (paperwidth, paperheight) e.g. (210mm, 297mm)
  paper-margin: (top: 20mm, bottom: 27mm, left: 20mm, right: 20mm),
  page-number: "1",
  numbering-headings: "1.1.1",
  indent-length: 1em,
  heading-bibliography: "参考文献",
  fontsize: 10pt,
  baselineskip: auto,
  lines-per-page: auto,
  book: false,
  cols: 1,
  non-cjk: regex("[\u0000-\u2023]"), // or "latin-  in-cjk"
  all-display-style: false,
  cjkheight: 0.88, // height of CJK in em
  bibliography-style: "sist02",
  callout-font: "Roboto",
  callout-text-color: rgb("#222"),
  callout-default-kind: "info",
  body,
) = {
  if baselineskip == auto { baselineskip = 1.45 * fontsize }
  set columns(gutter: 2em)
  set page(
    paper: paper,
    margin: paper-margin,
    columns: cols,
    numbering: page-number,
  )
  set text(
    lang: lang,
    font: ((name: seriffont, covers: non-cjk), seriffont-cjk),
    weight: 450,
    size: fontsize,
    top-edge: cjkheight * fontsize,
  )
  set par(
    first-line-indent: indent-length,
    justify: true,
    spacing: baselineskip - cjkheight * fontsize, // space between paragraphs
    leading: baselineskip - cjkheight * fontsize, // space between lines
  )
  set heading(numbering: numbering-headings)
  show heading: set text(
    font: ((name: sansfont, covers: non-cjk), sansfont-cjk),
    weight: 450,
  )

  show heading.where(level: 1): it => {
    block(
      above: 2 * baselineskip - (cjkheight - 0.2) * fontsize,
      below: 1.5 * baselineskip - (cjkheight + 0.2) * fontsize,
      breakable: false,
      sticky: true,
    )[
      #set par(first-line-indent: 1em)
      #set text(size: 1.4 * fontsize)
      #if it.numbering != none {
        counter(heading).display()
        h(1em)
      }
      #it.body
    ]
  }
  show heading.where(level: 2): it => block(
    above: 2 * baselineskip - (cjkheight - 0.1) * fontsize,
    below: 1.5 * baselineskip - (cjkheight + 0.1) * fontsize,
    breakable: false,
    sticky: true,
  )[
    #set text(size: 1.2 * fontsize)
    #if it.numbering != none {
      counter(heading).display()
      h(1em)
    }
    #it.body
  ]

  show heading.where(level: 3): it => block(
    above: 2 * baselineskip - (cjkheight + 0.2) * fontsize,
    below: 1.2 * baselineskip - (cjkheight) * fontsize,
    breakable: false,
    sticky: true,
  )[
    #set text(size: 1.1 * fontsize)
    #if it.numbering != none {
      counter(heading).display()
      h(1em)
    }
    #it.body
  ]

  // show strong: set text(
  //   font: ((name: sansfont, covers: non-cjk), sansfont-cjk),
  // )
  show emph: set text(
    font: ((name: seriffont, covers: non-cjk), sansfont-cjk),
    weight: 450,
  )
  set quote(block: true)
  show quote.where(block: true): set pad(left: 2em, right: 0em)
  show quote.where(block: true): set block(
    spacing: 1.5 * baselineskip - cjkheight * fontsize,
  )
  show enum: set block(spacing: 1.5 * baselineskip - cjkheight * fontsize)
  show list: set block(spacing: 1.5 * baselineskip - cjkheight * fontsize)
  show terms: set block(spacing: 1.5 * baselineskip - cjkheight * fontsize)
  show math.equation.where(block: true): set block(
    spacing: 1.5 * baselineskip - cjkheight * fontsize,
  )
  set block(spacing: 1.5 * baselineskip - cjkheight * fontsize)
  set terms(indent: 2em, separator: h(1em, weak: true))
  set enum(indent: 0.722em)
  set list(indent: 0.722em)
  set table(stroke: 0.04em)
  show table: set text(top-edge: (1.9 * cjkheight - 1) * fontsize)
  set table(align: center)
  set footnote.entry(indent: 1.6em)
  show figure.where(kind: table): set figure.caption(position: top)
  show ref: set text(fill: rgb("#0000ff")) // 参照の色を変更
  show link: set text(fill: rgb("#0000ff")) // リンクの色を変更

  show raw.where(block: false): it => {
    // ←ここにいつもの装飾
    set text(
      size: 0.94em,
      fill: rgb("#333"),
    )

    // boxの微調整
    box(
      fill: luma(95%), // 背景色 codeblockと揃えている
      radius: 2pt,
      inset: (top: 0em, bottom: 0em, left: .4em, right: .4em),
      outset: (top: 0em, bottom: 0em),
      height: cjkheight * fontsize + 0.55em,
      baseline: cjkheight * 0.5em,
    )[#it]
  }

  // code.typの設定を反映
  show: apply-codly

  // 参考文献
  set bibliography(style: "sist02")

  // display styleで表示するかどうか
  show: body => {
    if all-display-style {
      show math.equation.where(block: false): it => math.display(it)
      show math.integral: math.display
      body
    } else { body }
  }


  show: shorthands.with(
    ($+-$, $plus.minus$),
  )

  // コールアウトのデフォルト値の設定
  callout-init(
    kind: callout-default-kind,
    font: callout-font,
    text-color: callout-text-color,
  )

  // finally
  body
}
