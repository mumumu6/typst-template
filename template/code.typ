#import "@preview/codelst:2.0.2" as cdl

// ソースコードの設定(codelst)
#let my_frame = cdl.code-frame.with(
  fill: luma(95%), // 背景色
  stroke: .6pt + luma(190), // 枠線の色
  inset: (x: .45em, y: .65em),
  radius: 5pt,
  clip: false,
)

// `` の設定がcodeblockに反映されないようにlangを付けておく
#let codelst-lno(lno) = text(.8em, luma(160), raw(lno, lang: "codelst-lno"))

#let sourcecode = cdl.sourcecode.with(
  frame: b => my_frame(b),
  numbers-style: b => codelst-lno(b),
)

#let sourcefile = cdl.sourcefile.with(frame: b => my_frame(b), numbers-style: b => codelst-lno(b))

#show: cdl.codelst.with(frame: b => my_frame(b), numbers-style: b => codelst-lno(b))

// caption を付けれるように
#let code(code, caption: "", id: "", position: top, indexed: true, file: none, lang: none) = {
  // caption の設定
  let cap = none
  let numbering = "1" // numbering

  if indexed == false {
    // indexを振りたくなければふらない
    cap = none
    numbering = none
  } else if caption != "" {
    // caption があれば普通にcaptionを付ける
    cap = figure.caption(position: position)[#caption]
  } else if caption == "" {
    // caption が空文字列ならseparatorなし
    cap = figure.caption(position: position, separator: "")[#caption]
  }


  // label がなければcaptionにしておく
  if id == "" and type(caption) == str {
    id = caption
  }

  let body

  if file == none {
    // 直接与えられたコードをレンダリング
    body = sourcecode()[#code]
  } else {
    body = sourcefile(file, lang: lang)
  }


  [
    #figure(caption: cap, kind: "code", supplement: "ソースコード", numbering: numbering)[
      #body
    ]
    #if id != "" { label(id) }
  ]
}
