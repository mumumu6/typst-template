#import "./template/style.typ": *

#show: config.with(
  paper: "a4",
  fontsize: 10pt,
  lines-per-page: auto,
  numbering-headings: "1.1.1",
  cols: 1,
  all-display-style: true,
)




#maketitle(
  title: "Typst template",
  subtitle: "サンプル用コード",
  author: "mumumu",
  id: "12B34567",
  type: 1,
  abstract: [
    このレポートでは、Typst のテンプレートファイルの使い方について述べる。
  ],
)


#outline()



#pagebreak()

= 表紙について
表紙は二種類作りました。typeから選べます。\
レポートを書くときにtitleとsubtitleがどうしても欲しいので二つ用意してあります。

```typ
#maketitle(
  title: "Typst template",
  subtitle: "サンプル用コード",
  author: "mumumu",
  id: "12B34567",
  type: 2,
  abstract: [
    このレポートでは、Typst のテンプレートファイルの使い方について述べる。
  ],
)
```

= コードの挿入について
codlyを使っています。
コードを挿入するには基本はmdと同様に #raw("```")  で囲めばできます。
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    return 0;
}
```
header を付けたいときは
#grid(columns: 2, gutter: 2em)[
  #code(header: [*実際のtypstコード*])[

    ````typ
    #codly(header: [*Header Example*])
    ```cpp
    #include <iostream>
    using namespace std;
    int main() {
        cout << "Hello, World!" << endl;
        return 0;
    }
    ```
    ````
  ]
][
  #code(header: [*Header Example*])[
    ```cpp
    #include <iostream>
    using namespace std;
    int main() {
        cout << "Hello, World!" << endl;
        return 0;
    }
    ```]
]

#pagebreak()
`#code`でも同様に呼び出すことが可能で、こちらからheaderやcaption,labelの指定を可能にしました。

#code(caption: "Hello World", header: [*caption、labelの例*], label: "label")[
  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      cout << "Hello, World!" << endl;
      return 0;
  }
  ```
]
@label のようにできます\
ファイルからの読み込みも可能です
#grid(columns: 2, gutter: 2em)[
  ```typ
  #code(file: "/a.cpp")[]
  ```
][
  #code(file: "/a.cpp")[]

]

ちなみにコードブロックの上のソースコードという表示は `indexed: false` で消せます。

= 数式
$
  sum_(k=0)^(oo) (2k)!/(2^(2k)(k!)^2) 1/(2k+1) = pi/2\
  (integral_0^oo (sin x) / sqrt(x))^2 = pi/2\
  (b +- sqrt(b^2 - 4a c) )/ (2a)
$

文中の数式でも私はディスプレイスタイルの分数がいいので$1/2$,$(integral_0^oo x dif x)/(2x)$$sum_(k=0)^oo$のように表示することができるように`all-display-style`オプションを追加.
これは場合によっては行間が広がるので分数は`dfrac` で個別に対応することも可能にしました

#pagebreak()
= 定理環境
#theorem(
  title: [#lorem(6)],
  color: rgb("#1F6E3F"),
)[#lorem(10) ]
== aa

#theorem(
  title: [#lorem(6)],
)[
  For any real number $x$, we have $x^2 >= 0$.
  $ integral_0^oo e^(-x^2) dif x = sqrt(pi)/2 $
]

#theorem(
  title: [#lorem(3)],
  label: "def1",
  kind: "definition",
)[
  #lorem(5)
]
@def:def1

= 定理環境2

#theorem(
  title: [数字はいい感じに更新される],
  numbering: none,
  color: rgb("#6E4E1F"),
  label: "memo",
)[
  定理環境の箱もっと見た目をかえたかったが、counterのせいで見た目がおかしくなってしまい、シンプルな見た目にすることに\
  謎バグ
]
@the:memo

#pagebreak()
= callout

#callout(
  kind: "example",
  title: "Example",
)[
  Like this one.
]

#callout(
  kind: "info",
  title: "info",
)[
  Like this one.
]
#callout(
  kind: "question",
  title: "Question",
  text-color: rgb("#0e5e36"),
)[
  Like this one.
]
#callout(
  kind: "note",
  title: "Note",
)[
  Like this one.
]

#callout(
  kind: "success",
  title: "Success",
)[
  Like this one.
]
#callout(
  kind: "warning",
  title: "Warning",
)[
  Like this one.
]





#pagebreak()
以下参考文献の例
#bibliography("ref.yml", full: true)
