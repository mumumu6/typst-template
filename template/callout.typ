#import "@preview/showybox:2.0.4": *


#let _palette = (
  note: rgb("#086DDD"),
  info: rgb("#086DDD"),
  question: rgb("#EC7500"),
  example: rgb("#7852EE"),
  warning: rgb("#EC7500"),
  success: rgb("#08B94E"),
)

#let callout-config = state(
  "call-out",
  (
    kind: "info",
    font: "Roboto",
    text-color: rgb("#222"),
  ),
)

#let callout-init(kind: "info", font: "Source Sans Pro", text-color: rgb("#222")) = {
  callout-config.update(_ => (
    kind: kind,
    font: font,
    text-color: text-color,
  ))
}

#let __callout-default = context [ Callout Default ]

#let callout(
  kind: __callout-default,
  title: none,
  body,
  callout-font: __callout-default,
  text-color: __callout-default,
) = context {
  // デフォルト値の設定
  let defaults = callout-config.get()
  let resolve(v, def) = if v == __callout-default { def } else { v }

  let kind = resolve(kind, defaults.kind)
  let callout-font = resolve(callout-font, defaults.font)
  let text-color = resolve(text-color, defaults.text-color)
  // デフォルト値を更新
  callout-config.update(_ => (
    kind: kind,
    font: callout-font,
    text-color: text-color,
  ))

  // 色決定
  let base-color = _palette.at(kind)

  // タイトル（
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


  // Obsidian 風
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
