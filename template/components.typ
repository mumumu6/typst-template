
#let kintou(width, s) = box(width: width, s.text.clusters().join(h(1fr)))
#let scatter(s) = h(1fr) + s.text.clusters().join(h(2fr)) + h(1fr)

// ルビ
#let ruby(kanji, yomi) = box[
  #context {
    set par(first-line-indent: 0em)
    set text(top-edge: "ascender")
    let w = measure(kanji).width
    let x = measure(yomi).width / 2
    if w < x { w = x }
    box(width: w, h(1fr) + kanji + h(1fr)) // or scatter(kanji)
    place(top + center, dy: -0.5em, box(width: w, text(0.5em, scatter(yomi))))
  }
]

// インデントなし段落
#let noindent(body) = {
  set par(first-line-indent: 0em)
  body
}


// 表紙
#let maketitle(
  title: "",
  subtitle: "",
  date: datetime
    .today()
    .display(
      "[year]年[month repr:numerical padding:none]月[day padding:none]日",
    ),
  id: "",
  author: "",
  abstract: [],
  type: 1, // 表紙は二通り設定している
) = align(center)[
  #set document(title: title, author: author)

  #if type == 1 {
    v(3em)
    if title != "" {
      text(size: 2em)[#title]
      v(4em)
    }

    if subtitle != "" {
      text(size: 1.8em, weight: 550)[#subtitle]
      v(3em)
    }


    text(size: 1.4em)[#date]
    v(3em)


    text(size: 1.4em)[学籍番号 #id]
    v(3em)


    text(size: 1.2em)[#author]

    if abstract != [] {
      v(2.5em)
      block(width: 90%)[
        #set text(1em)
        _概要_
        #align(left)[#abstract]
      ]
    }
    v(1em)
  } else if type == 2 {
    // 右上の提出日

    align(right)[
      #if date != "" { text(1em)[提出日 #date] }
    ]


    // タイトル（中央）＋ 著者（右端）

    // ページ幅いっぱいの箱を用意
    v(4em)

    // タイトルは中央
    align(center)[
      #if title != none and title != "" {
        text(2em, title)
      }
      #if subtitle != none and subtitle != "" {
        v(2em)
        text(1.8em, subtitle)
      }
    ]


    // 著者・学籍番号はページ右端に寄せる
    align(right)[
      #v(2.4em)

      #if author != "" { text(1.1em)[#author] }

      #if id != "" {
        text(1.1em)[学籍番号 #id]
      }
    ]

    v(1em)
  }
]

// 数式

#let dfrac(num, den) = {
  // このブロック内だけ、分数を display 風に
  show math.frac: math.display
  $ frac(num, den) $
}
