# Wife's Bedroom - 対話・多言語 ＆ カスタムMODシステム仕様書 (v4.1 決定版)
# (08_DIALOGUE_AND_CUSTOM_MOD_SYSTEM.md)

本仕様書は、JSON対話システム、多言語（日本語/英語）セリフ・フォント動的スワップ、およびカスタムMODアセット（スプライト・断面図・カスタム喘ぎ声・ベッドルーム）の自動スキャン読み込み構造を詳細に定義します。

---

## 1. 多言語対応 JSON対話システム [✅ 実装確認済]

言語設定（English / Japanese）の切り替えに完全連動して、セリフファイルと描画フォントが動的にスワップされます。

### ① ディレクトリ分離構造
* **英語セリフ**: `dialogue_en/dialogue_*.json`
* **日本語セリフ**: `dialogue_ja/dialogue_*.json`
* **言語切り替え時の挙動**:
  - メニューで `English` を選択: 原作のピクセル風フォント（`font_main`）へ切り替わり、`dialogue_en/` から英語のセリフを再ロード。
  - メニューで `Japanese` を選択: 高精細日本語動的フォント（`font.ttf` / MSゴシック）へ切り替わり、`dialogue_ja/` から日本語のセリフを再ロード。

### ② 対応性格（Personality）一覧
* `0: ボーイッシュ (dialogue_tomboy.json)`
* `1: メスガキ・生意気 (dialogue_bratty.json)`
* `2: 従順・健気 (dialogue_submissive.json)`
* `3: スライム娘 (dialogue_slime.json)`
* `4: アンドロイド (dialogue_android.json)`
* `5: クラウン / ピエロ (dialogue_clown.json)`
* `6: バニーガール (dialogue_bunny.json)`
* `7: エイリアン (dialogue_alien.json)`

---

## 2. カスタムMODフォルダ自動スキャン ＆ 喘ぎ声音声置換 [✅ 実装確認済]

### ① フォルダ構造定義
`custom/` ディレクトリ内の各パートナー/ラバーフォルダに以下のファイルを配置することで、テクスチャや音声を自在に差し替えることができます。

```text
custom/
└── キャラクター名/
    ├── custom_data.futa (または custom_data.spouse)
    ├── custom_mating_press.png
    ├── custom_reverse_cowgirl.png
    ├── custom_deepthroat.png
    ├── custom_xray.png
    ├── custom_condom.png
    ├── custom_portrait.png
    ├── moan_slow/          <-- 低興奮・スロー喘ぎ声 (.ogg / .wav)
    ├── moan_fast/          <-- 激しいピストン喘ぎ声 (.ogg / .wav)
    ├── orgasm/             <-- 絶頂時喘ぎ声 (.ogg / .wav)
    └── BallsClench/        <-- 睾丸収縮アニメーションフレーム (0..4)
```

### ② 座標パラメータの基準値 (`custom_data.futa`)
* `origin_x = 80`, `origin_y = 84`
* `condom_y = 78`（※コンドームの密着基準高さ）
* `xray_origin_x = 80`, `xray_origin_y = 84`
* `portrait_origin_x = 64`, `portrait_origin_y = 64`

---

## 3. MODタイトル表示仕様 [✅ 実装確認済]
* タイトル画面左上に表示される公式MOD識別表記：
  **`Wife's Bedroom: Apex Refined MOD v4.1`**
