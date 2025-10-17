#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *

// codly の初期設定
#let apply-codly(body) = {
  // ここで「実行」する
  show: codly-init
  // numberで上に少し余白を作ったのでコードが上昇する分をここで補正
  show raw.where(block: true): it => {
    let last-line = it.lines.len()
    show raw.line.where(number: 1): ln => move(dy: 0.25em, ln)
    show raw.line.where(number: last-line): ln => pad(bottom: 0.9em, ln)

    codly(
      zebra-fill: none,
      stroke: .5pt + luma(88%),
      fill: luma(95%),
      inset: (x: .5em, y: .25em),
      radius: 1em,
      languages: codly-languages,
      // langの装飾
      lang-fill: luma(85%),
      lang-stroke: 0.2pt + luma(50%),
      lang-outset: (x: -0.2em, y: 0em),
      lang-format: (lang, icon, color) => text(size: 0.85em)[ #lang],
      header-cell-args: (align: center, fill: luma(88%), inset: (y: 0.7em)),
      header-transform: it => {
        set text(size: 1.2em, fill: luma(10%))
        it
      },
      // numbering
      number-format: b => {
        pad(
          // 文字のサイズと開始時と終了時の余白を追加
          top: if b == 1 { 0.5em } else { 0em },
          bottom: if b == last-line { 1em } else { 0em },
          text(size: 0.85em, fill: luma(65%))[#b],
        )
      },

      number-align: center,
    )
    it
  }

  body
}

// 引数をlabelで使いたかったので退避
#let lbl(it) = { label(it) }
// 空白を-に変換
#let slug(s) = str.replace(str(s), regex("\\s+|　+"), "-")

// ユーザーが呼び出す関数
// caption, label, headerなどの設定をしている
#let code(code, label: none, header: none, caption: none, position: bottom, indexed: true, file: none, ..args) = {
  let cap = none
  let numbering = "1" // numbering

  if indexed == false {
    // indexを振りたくなければふらない
    cap = none
    numbering = none
  } else if caption != none {
    // caption があれば普通にcaptionを付ける
    cap = figure.caption(position: position)[#caption]
  } else if caption == none {
    // caption がない場合separatorなし
    cap = figure.caption(position: position, separator: "")[#caption]
  }

  // label が無ければ caption を流用（文字列のとき）
  if label == none and type(caption) == str {
    label = slug(caption)
  }

  if file != none {
    code = raw(read(file), block: true, lang: "cpp")
  }

  let codly-call
  if header == none {
    codly-call = codly(..args)
  } else {
    codly-call = codly(header: header, ..args)
  }

  // --- figure で包む（参照・番号付け可能） ---
  [
    #figure(caption: cap, kind: "code", supplement: "ソースコード", numbering: numbering)[
      #codly-call
      #code
    ]
    #if label != none { lbl(label) }
  ]
}
