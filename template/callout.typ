#import "@preview/showybox:2.0.4": *


#let _palette = (
  note: rgb("#086DDD"),
  info: rgb("#086DDD"),
  question: rgb("#EC7500"),
  example: rgb("#7852EE"),
  warning: rgb("#EC7500"),
  success: rgb("#08B94E"),
)


#let callout(kind: "info", title: none, body, callout-font: "Roboto", text-color: rgb("#222")) = {
  // 種類→色・アイコン決定
  let base-color = _palette.at(kind)
  // タイトル（省略時は種類名を頭大文字化）

  let ttl

  if title != none {
    // アイコン画像のパスを決定
    let path = "/template/assets/" + kind + ".svg"

    ttl = (
      title: text(font: callout-font)[
        #grid(columns: 2, gutter: 0.3em)[
          #pad(top: -.1em)[#image(
            path,
          )] ][#title]
      ],
    )
  }


  // Obsidian 風: タイトル帯は濃色、本文は淡色。区切りはやや太め。
  showybox(
    ..ttl,
    frame: (
      title-color: none,
      body-color: base-color.transparentize(90%),
      thickness: 0pt,
      radius: 2pt,
      title-inset: (x: 1.5em, bottom: 2.1em),
      body-inset: (x: 1.5em, y: 1.6em),
    ),
    title-style: (
      color: base-color,
      sep-thickness: 0pt,
      boxed-style: (
        offset: (x: -1em, y: 2.5em),
      ),
    ),
    body-style: (
      color: black,
      align: start,
    ),
    breakable: true, // 複数ページにまたがってもOK
    spacing: .0em,
    [#text(font: callout-font, fill: text-color)[#body]],
  )
}
