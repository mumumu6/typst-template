#import "config-state.typ": *

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
) = context align(center)[
  #set document(title: title, author: author)
  #let cfg-state = config-state.get()

  #let _author = author
  #let _id = id

  #if author == "" {
    _author = cfg-state.author
  }

  #if id == "" {
    _id = cfg-state.id
  }

  #if type == 1 {
    v(3em)
    if title != "" {
      text(size: 2em)[#title]
      v(4em)
    }

    if subtitle != "" {
      text(size: 1.8em)[#subtitle]
      v(3em)
    }

    text(size: 1.4em)[#date]
    v(3em)


    text(size: 1.4em)[学籍番号 #_id]
    v(3em)


    text(size: 1.2em)[#_author]

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

      #if _author != "" { text(1.1em)[#_author] }

      #if _id != "" {
        text(1.1em)[学籍番号 #_id]
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

#let solutiontitle = {
  set text(font: "Noto Sans CJK JP")
  noindent[
    【解答】
  ]
}

// 表

#let diag(body1, body2,
  dir: "\\",                 // "/" or "\\"
  width: auto, height: 1cm,
  inset: 3.5pt, stroke: 0.5pt,
) ={
  table.cell(inset: 0pt)[
    #box(width: width, height: height)[
      #set text(size: 0.75em) // 少し小さく
      #if dir == "/" {
        // ／：左上・右下
        place(top + left,    body1, dx:  inset, dy:  inset)
        place(bottom + right,body2, dx: -inset, dy: -inset)
        // 左下 → 右上（／）
        line(start: (0%, 100%), end: (100%, 0%), stroke: stroke)
      } else if dir == "\\" {
        // ＼：左下・右上
        place(bottom + left, body1, dx:  inset, dy: -inset)
        place(top + right,   body2, dx: -inset, dy:  inset)
        // 左上 → 右下（＼）
        line(start: (0%, 0%), end: (100%, 100%), stroke: stroke)
      } else {
        // 想定外の記号は既定（＼）にフォールバック
        place(bottom + left, body1, dx:  inset, dy: -inset)
        place(top + right,   body2, dx: -inset, dy:  inset)
        line(start: (0%, 0%), end: (100%, 100%), stroke: stroke)
      }
    ]
  ]
}
