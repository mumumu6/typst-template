#import "@preview/showybox:2.0.4": showybox


#let theorem-config = state(
  "theorem",
  (
    // numbering: none なら番号なし。数値なら単純連番。
    numbering: "1",
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
  numbering: none,
  kind: "theorem", // "theorem", "definition", "proposition", "lemma"
  body,
  label: none,
) = context {
  // 設定の取得
  let cfg = theorem-config.get()
  // 現在のsection番号を取得して、変化があればリセット
  let current-section-number = counter(heading).get().at(0)

  let num = theorem-counters.get().at(0)


  if section-counters.get().at(0) != current-section-number {
    section-counters.update(current-section-number)
    theorem-counters.update(0)
    num = 1
  }
  theorem-counters.update(num + 1)


  let type = cfg.palette.at(kind).at("label")
  let label = cfg.palette.at(kind).en-label + ":" + label

  let title = par(justify: false)[*#type  #current-section-number.#num* #title]
  [
    #figure(kind: kind, supplement: [#type], numbering: _ => [#current-section-number.#num])[
      #showybox(
        title: title,
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
