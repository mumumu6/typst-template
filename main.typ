#import "./template/style.typ": *

#show: config.with(
  paper: "a4",
  fontsize: 10pt,
  lines-per-page: auto,
  numbering-headings: "1.1.1",
  cols: 1,
)





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
  #codly(header: [*実際のtypstコード*])

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
][
  #codly(header: [*Header Example*])
  ```cpp
  #include <iostream>
  using namespace std;
  int main() {
      cout << "Hello, World!" << endl;
      return 0;
  }
  ```]

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


\

#pagebreak()
以下参考文献の例
#bibliography("ref.yml", full: true)
