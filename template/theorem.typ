#import "@preview/showybox:2.0.4": showybox


#let theorem-config = state(
  "theorem",
  (
    // numbering: false なら番号なし。
    numbering: true,
    palette: (
      theorem: (label: "定理", color: rgb("#222"), en-label: "the"),
      definition: (label: "定義", color: rgb("#222"), en-label: "def"),
      proposition: (label: "命題", color: rgb("#222"), en-label: "prop"),
      lemma: (label: "補題", color: rgb("#6E4E1F"), en-label: "lem"),
    ),
    title-color: white, // タイトル帯の文字色
    body-inset: 1em,
  ),
)

#let theorem-counters = counter("theorem")
#let section-counters = counter("section")

#let lbl(it) = { label(it) }

#let theorem(
  title: none,
  title-color: black,
  color: rgb("#1F6E3F"),
  numbering: true,
  kind: "theorem", // "theorem", "definition", "proposition", "lemma"
  body,
  label: none,
) = context {
  // 設定の取得
  let cfg = theorem-config.get()
  // 現在のsection番号を取得して、変化があればリセット
  let section-number = counter(heading).get().at(0)

  let theorem-number = theorem-counters.get().at(0)


  if section-counters.get().at(0) != section-number {
    section-counters.update(section-number)
    theorem-counters.update(0)
    theorem-number = 1
  }
  theorem-counters.update(theorem-number + 1)


  let type = cfg.palette.at(kind).at("label")
  let label = cfg.palette.at(kind).en-label + ":" + label

  // numberingがfalseなら番号なしに
  let _title
  if numbering == true {
    _title = par(justify: false)[*#type  #section-number.#theorem-number* #h(0.5em) #title]
  } else {
    _title = par(justify: false)[*#type* #h(0.5em) #title]
  }

  [
    #figure(kind: kind, supplement: [#type], numbering: _ => [#section-number.#theorem-number])[
      #showybox(
        title: _title,
        frame: (
          title-color: white,
          body-inset: 1em,
        ),
        title-style: (
          color: title-color,
        ),
        breakable: true,
      )[#body]
    ]
    #if label != none { lbl(label) }
  ]
}
