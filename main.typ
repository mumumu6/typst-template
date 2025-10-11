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
codelstを使っていて、それをラップしています
コードを挿入するには基本はmdと同様に #raw("```")  で囲めばできます。
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    return 0;
}
```
captionをいじりたいときは
````typ
#code(caption:"captionをいじれます",id:"captionの説明")[
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    return 0;
}
```]

````
#code(caption: "captionをいじれます", id: "captionの説明")[
  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      cout << "Hello, World!" << endl;
      return 0;
  }
  ```
]

@captionの説明 のように、ラベルで参照することもできます。


== ファイルからの参照について
````typ
#code(file: read("a.cpp"), lang: "cpp")[]
````

#code(file: read("a.cpp"), lang: "cpp")[]

ちなみにコードブロックの上のソースコードという表示は `indexed: false` で消せます。



\
以下参考文献の例
#bibliography("ref.yml", full: true)
