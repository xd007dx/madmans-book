# Wife's Bedroom - 新マスター仕様書 (v4.1 決定版正本)
**文書ID**: `NEW_MASTER_SPECIFICATION_V4.1.md`  
**策定日**: 2026年9月3日  
**ステータス**: 正式正本仕様書 (再監査完了・確定版)  
**正本コード基準**: `_modding_workspace/current_gml_v4.1/`  

---

## 凡例（情報の信頼性区分ラベル）
本仕様書では、今後のAIおよび開発者が「事実」「仕様」「推測」を混同することを恒久的に防ぐため、全項目に以下の区分ラベルを付与する。

* **[VERIFIED FACT]**: 現在の正本コード（`current_gml_v4.1/`）等から直接確認された客観的事実。
* **[SPECIFICATION]**: 本プロジェクトにおいて正式採用・合意された仕様・ルール。
* **[HYPOTHESIS]**: コードや動作ログから導かれた原因候補・技術的推測。
* **[UNVERIFIED]**: コード上に構文は存在するが、実機上で意図通り動作するか未検証の項目。
* **[REGRESSION]**: 過去世代（v7/v8等）に存在していたが、現在の正本で消失・退行した項目。

---

# A. プロジェクト概要

* **[VERIFIED FACT] 対象作品**: 『Wife's Bedroom』(GameMaker製 成人向けシミュレーションゲーム)。
* **[SPECIFICATION] MOD名称**: 『Wife's Bedroom: Apex Refined MOD v4.1』。
* **[SPECIFICATION] プロジェクトの目的**:
  1. バニラ（原作）に存在する18種のピル体系に対し、新規23種のMODピルを追加し「全41種ピル体系」を構築すること。
  2. オーバードーズ（ID 19）による全40種ピルとの覚醒シナジー効果を確立すること。
  3. コンドームの物理演算・耐久度・超巨大膨張・床ドロップシステムを安定化させること。
  4. 多言語（日本語・英語）動的フォント切替、カスタムキャラクター・パートナー・寝室読込機能の完全提供。
  5. 過去のAI開発で生じた機能退行・バグ・仕様矛盾を完全是正し、実機で安定動作する決定版を完成させること。

---

# B. ゲームエンジン・データ形式

* **[VERIFIED FACT] ゲームエンジン**: GameMaker (GameMaker: Studio / GameMaker 202x ランタイム)。
* **[VERIFIED FACT] データパッケージ形式**: 単一の `data.win`（Bytecode 形式）。
* **[VERIFIED FACT] 主要オブジェクト構造**:
  - `oFutaMatingPress`: メインゲームループ・入力・描画・ステータス管理・HUD表示を統括する中心オブジェクト。
  - `oCondom`: 外されたコンドームの床ドロップ・物理移動・精液保持・マウスドラッグを担うオブジェクト。
  - `oCum`: 精液スプラッシュ・床溜まり・衝突判定を担うオブジェクト。
  - `oBackground`: 背景切替・アニメーション・部屋環境を担うオブジェクト。
* **[VERIFIED FACT] セーブ形式**: INIファイル形式（`save_data.sav`）。
* **[VERIFIED FACT] 外部リソース形式**:
  - 画像: PNG形式（`sprite_add` による動的ロード）。
  - 音声: OGG形式（`audio_create_stream` による動的ストリーミング）。**※WAV形式は現行コード非対応**。
  - フォント: TTF/TTC形式（`font_add` による動的ロード）。
  - テキスト/対話: TXT/JSON形式。

---

# C. MOD適用方式

* **[VERIFIED FACT] パッチ適用ツール**: `UndertaleModTool` (UTMT) CLI / C# スクリプト (`.csx`)。
* **[VERIFIED FACT] パッチの仕組み**:
  `data.win` をメモリ上にロードし、`CodeImportGroup` を介して GML コードの置換 (`QueueFindReplace`)、追加 (`QueueAppend`)、またはバイトコード命令の直接書き換え（`Instructions` 配列操作）を実行後、`SaveFile` で上書き保存する。
* **[VERIFIED FACT] 過去パッチスクリプトの重大欠陥**:
  `QueueFindReplace` は置換対象文字列がコード内に存在せず 0 件置換となった場合でもエラーや例外を出さない。そのため、「パッチ対象が存在せず何も変更されなかった」場合でもスクリプトが最後まで進み、`SUCCESS` を表示していた。
* **[SPECIFICATION] 今後のパッチ適用原則**:
  1. 置換対象コードの存在確認（アサーション）をパッチ前に行うこと。
  2. 置換後のコードが期待通りに変更されたか（逆コンパイル結果またはバイトコード検査）を検証すること。
  3. スクリプトの完了ログ「SUCCESS」は「処理が例外なく通過した」ことのみを意味し、「機能の実装成功」の根拠としては扱わないこと。

---

# D. 現在の正本ファイル

* **[SPECIFICATION] 正本ディレクトリ**: `_modding_workspace/current_gml_v4.1/`
* **[VERIFIED FACT] 監査対象ファイル一覧と現状**:
  1. `gml_Object_oFutaMatingPress_Create_0.gml` (85,252 bytes / 2,316 lines)
     - 変数初期化、フォントロード、言語処理、カスタムMODスキャン、`func_set_pill_effect`（バニラのみ）、セーブ/ロードを管轄。
  2. `gml_Object_oFutaMatingPress_Step_0.gml` (12,756 bytes / 432 lines)
     - タイマー、射精開始判定、MODピル効果（ID 18〜40の毎フレーム処理）、妻快感度計算、RPG判定を管轄。
  3. `gml_Object_oFutaMatingPress_Alarm_0.gml` (853 bytes / 31 lines)
     - ピストン速度・強度の定期ランダム更新、あえぎトリガー、スパンキング加速を管轄。
  4. `gml_Object_oFutaMatingPress_Draw_0.gml` (194,349 bytes / 3,931 lines)
     - キャラクター描画、ピストンストローク、射精ポンプ処理、スパンキング、UIメニュー、コンドーム着脱・描画を管轄。
  5. `gml_Object_oFutaMatingPress_Draw_64.gml` (249 bytes / 11 lines)
     - **[REGRESSION] 現在はパレット用シェーダー適用コードのみ存在し、挿入時専用HUDが完全に消失している**。
  6. `gml_Object_oCondom_Draw_0.gml` (6 bytes / 1 lines)
     - `exit;` のみ。バニラから描画は `oFutaMatingPress_Draw_0` 内で統括されている。

---

# E. 完成版として認める条件

今後の開発において、AIおよび開発者が「機能の完成・実装完了」と認めるためには、以下の **5段階の必須検証ループ** をすべて満たさなければならない。

1. **第1段階（静的コード存在確認）**:
   正本GML内に該当処理のコードが正確に記述されていること。
2. **第2段階（到達性・実行条件確認）**:
   該当コードに到達する実行経路（イベント、if文条件、フラグ、呼び出し順序）が論理的に成立可能であること。毎フレーム処理かイベント処理かが適切であること。
3. **第3段階（競合・上書き検査）**:
   直前・直後の処理や別イベント（例: `Step_0` と `Alarm_0`、`Draw_0` の描画順）によって変数が意図せず上書き・打ち消しされていないこと。
4. **第4段階（パッチ適用検証）**:
   CSXスクリプト適用後の `data.win` から再度コードを逆コンパイルし、変更後コードが期待値と1文字の齟齬もなく一致していること。
5. **第5段階（実機テスト確認）**:
   ゲームを実際に起動し、所定の操作シナリオ（実機テスト計画に基づく）を実行して、画面描画・音声・変数挙動が仕様通りであることを目視・確認すること。単なる「プロセス起動確認（Responding: True）」は完成の根拠と認めない。

---

# F. 41ピル仕様

全41種ピル（バニラ18種 ＋ MOD23種）の仕様および現在の実装状態。

| ID | ピル名 (JP) | ピル名 (EN) | 区分 | 仕様上の基本効果 [SPECIFICATION] | 現在の実装状態 [VERIFIED FACT] | 判定 |
|:---:|:---|:---|:---:|:---|:---|:---:|
| **0** | ランダム/リセット | Mystery Pill | バニラ | 全ピル解除、パラメータ初期値へ | `Draw_0` メニュー内処理。完全リセット漏れあり | C |
| **1** | メガ精子 | Mega Sperm | バニラ | `ball_size *= 1.3`, 精子数2倍 | `Create_0`, `Alarm_0`, `Step_0`, `Draw_0` | B |
| **2** | 馬並み巨根 | Equine Penis | バニラ | `length *= 1.2`, `width *= 1.2` | `Create_0`, `Step_0` (OD), `Draw_0` | B |
| **3** | 結節ペニス | Knotted Penis | バニラ | 犬根形状、最奥ロック感 | `Create_0`, `Step_0` (OD), `Draw_0` | B |
| **4** | 豊満化 | Extra Thick | バニラ | `boob *= 1.1`, `ass *= 1.1`, `lactate = 1` | `Create_0`, `Step_0` (OD), `Draw_0` | B |
| **5** | 二股ペニス | Diphallia | バニラ | 二股描画、`loads += 1`, 射精2倍 | `Create_0`, `Step_0`, `Draw_0` | B |
| **6** | 排卵誘発 | Ovulation | バニラ | `bottom_fertile = 1`, `timer = 120` | `Create_0`, `Draw_0` | B |
| **7** | 超繁殖モード | Hyper Breeding | バニラ | `max_loads = 999`, `length = 1.4` | `Create_0` のみ。ODシナジー未実装 | C |
| **8** | スタミナ | Stamina | バニラ | `progress_max = 150`, `max_loads *= 5` | `Create_0`, `Step_0` (`condom_break = 999999`) | B |
| **9** | 先走り漏出 | Leaky | バニラ | ピストン1/11、スパンク1/2で漏出 | `Create_0`, `Step_0`, `Draw_0` | B |
| **10** | 3回即イキ | Three Pump Champ | バニラ | `progress_max = 20`, 射精量20倍 | `Create_0`, `Step_0`, `Draw_0` | B |
| **11** | カラーカオス | Color Chaos | バニラ | 体液・スキン色ランダム変化 | `Create_0`, `Step_0` | B |
| **12** | 伸縮子宮 | Stretchy Womb | バニラ | `max_cumflation_size = 10.0` | `Create_0`, `Draw_0` | B |
| **13** | ダンジョン冒険者 | Dungeoneer | バニラ | RPG UI、敵HP、レベルバーON | `Step_0` (`rpg = true`), `Draw_0` | B |
| **14** | 成長連鎖 | Growth Cascade | バニラ | 射精抜去時 +0.15 (上限2.8x) | `Draw_0` のみ。ODシナジー未実装 | C |
| **15** | 寸止め | Gooner | バニラ | `max_loads = 1`, `max_edge = 10` | `Create_0`, `Draw_0` | B |
| **16** | 猛ピストン | Pound Town | バニラ | 射精中 `thrust_speed = 8〜14` | `Create_0`, `Alarm_0`, `Step_0`, `Draw_0` | B |
| **17** | 生配信モード | Livestream | バニラ | 配信UI、コメント、スパチャON | `Draw_0` | B |
| **18** | プチ・タイタン | Petite Titan | MOD | 体格0.65倍化、根元維持 | `Step_0` 271-280行 | B |
| **19** | オーバードーズ | Overdose | MOD | 全ピル効果の増幅マスター触媒 | `Step_0` 262行他 | B |
| **20** | ターボ・ドライブ | Turbo Drive | MOD | `thrust_speed = 40` (OD時 55) | `Step_0` 304-312行 | B |
| **21** | 黄金蜜精液 | Honey Nectar | MOD | `cum_color = 黄金`, スコア加算 | `Step_0` 313-321行 | B |
| **22** | 噴乳覚醒 | Siren Milk | MOD | `lactate = true`, 胸揺れ加算 | `Step_0` 322-326行 | B |
| **23** | 極限寸止め | Edge Meister | MOD | `edge_boost = 10` 解放 | `Step_0` 327-337行 | B |
| **24** | 無限子宮 | Full Container | MOD | `fill_max = 500` ＆ ポンプ毎注入加算 | `Step_0` 338行に `fill_max` のみ。**ポンプ注入消失** | C (退行) |
| **25** | 永久垂れ流し | Endless Drip | MOD | 挿入毎フレーム注入、抜去時滴り | `Step_0` 342-353行 | B |
| **26** | 百発百中受精 | Quick Egg | MOD | 射精時即100%受精、ゴム時破裂 | `Step_0` 354-364行 | B |
| **27** | 灼熱マグマ | Magma Core | MOD | `cum_color = 深紅`, 快感度ブースト | `Step_0` 365-376行 | B |
| **28** | 幻想発光精液 | Crystal Semen | MOD | `cum_color = 蛍光シアン` | `Step_0` 377-384行 | B |
| **29** | 最奥貫通 | Phantom Reach | MOD | 根元密着維持、長さ2.5、太さ1.8 | `Step_0` 385-389行 | B |
| **30** | 777フィーバー | Casino Lucky | MOD | 絶頂時確定でスコア +777 (OD +7777) | `Step_0` 390行。**毎フレーム加算バグあり** | E (仕様矛盾) |
| **31** | 多重連鎖絶頂 | Time Delay | MOD | マシンガン射精 (`orgasm_timer -= 2/3`) | `Step_0` 394-397行 | B |
| **32** | 奇跡の多胎繁殖 | Royal Genesis | MOD | 受精時即4つ子確定 (`fertilizations=4`) | `Step_0` 398-401行 | B |
| **33** | 永遠の逢瀬 | Epilogue Dream | MOD | 上限到達毎に `max_loads += 5/10` | `Step_0` 402-408行 | B |
| **34** | 官能覚醒 | Sensual Moan | MOD | あえぎ確率95%/100%、ピッチ揺らぎ | **現行GMLにコード一切なし** (メニュー表示のみ) | F (退行) |
| **35** | 極限先走り漏出 | Leaky EX | MOD | ピストン30%、スパンク75%漏出 | `Draw_0` 1165-1200行, 3742行 | B |
| **36** | 重装甲ラバー | Titan Rubber | MOD | 耐久100、破裂率1/999999 (OD絶対無敵) | `Step_0` 409-417行 | B |
| **37** | シンクロ・ハート | Sync Heart | MOD | 射精ポンプ毎に妻絶頂同期 | **現行GMLにコード一切なし** (メニュー表示のみ) | F (退行) |
| **38** | 豪腕スラスト | Titan Thrust | MOD | `thrust_strength = 20` (OD時 35) | `Step_0` 418-423行 | B |
| **39** | ピストン連鎖 | Thrust Surge | MOD | ストローク毎に肉体成長 | **現行GMLにコード一切なし** (メニュー表示のみ) | F (退行) |
| **40** | ポンプ連鎖 | Pump Surge | MOD | 射精ポンプ毎に肉体成長 | **現行GMLにコード一切なし** (メニュー表示のみ) | F (退行) |

---

# G. 40シナジー仕様

オーバードーズ（ID 19）併用時における他40ピルの覚醒シナジー効果の監査結果。

1. **ID 0 リセット**: [SPECIFICATION] 覚醒状態を瞬時にニュートラルへ初期化。現在実装はメニュー選択時に実行。判定: B。
2. **ID 1 メガ精子**: [VERIFIED FACT] `Step_0` 289行で `ball_size = max(ball_size, 1.4);` 担保。判定: B。
3. **ID 2 馬並み巨根**: [VERIFIED FACT] `Step_0` 293行で `top_penis_length = max(..., 2.8); top_penis_width = max(..., 2.2);`。判定: B。
4. **ID 3 結節ペニス**: [VERIFIED FACT] `Step_0` 293行で ID 2 と共通処理。判定: B。
5. **ID 4 豊満化**: [VERIFIED FACT] `Step_0` 298行で `top_boob_size = max(..., 2.5); top_ass_size = max(..., 2.5);`。判定: B。
6. **ID 5 二股ペニス**: [SPECIFICATION] 2条の射精がそれぞれ2倍（実質4倍）。[VERIFIED FACT] 現行コードにOD固有分岐なし。判定: D。
7. **ID 6 排卵誘発**: [SPECIFICATION] 受精タイマー2倍。[VERIFIED FACT] 現行コードにOD固有分岐なし。判定: D。
8. **ID 7 超繁殖モード**: [SPECIFICATION] `thrust_strength = 8.0` 加速。[VERIFIED FACT] `Step_0` 284行の共通 `thrust_strength = max(..., 8)` で担保。判定: B。
9. **ID 8 スタミナ**: [VERIFIED FACT] `Step_0` 266行で `condom_breaking_override = true` 発動。判定: B。
10. **ID 9 先走り漏出**: [VERIFIED FACT] `Draw_0` 1172行で `_has_od` 時の確率ブーストあり。判定: B。
11. **ID 10 3回即イキ**: [SPECIFICATION] 射精倍率40倍。[VERIFIED FACT] 現行コードにOD固有分岐なし。判定: D。
12. **ID 11 カラーカオス**: [SPECIFICATION] 発光サイクル2倍。[VERIFIED FACT] 現行コードにOD固有分岐なし。判定: D。
13. **ID 12 伸縮子宮**: [SPECIFICATION] お腹膨張限界10.0x。[VERIFIED FACT] 現行コードにOD固有分岐なし。判定: D。
14. **ID 13 ダンジョン冒険者**: [SPECIFICATION] RPG与ダメージ2倍。[VERIFIED FACT] 現行コードにOD固有分岐なし。判定: D。
15. **ID 14 成長連鎖**: [SPECIFICATION] 射精ごと成長率 +0.30 (上限3.0)。[VERIFIED FACT] 現行コードにOD固有分岐なし（バニラの+0.15, 上限2.8のまま）。判定: D。
16. **ID 15 寸止め**: [SPECIFICATION] エッジ上昇2倍。[VERIFIED FACT] 現行コードにOD固有分岐なし。判定: D。
17. **ID 16 猛ピストン**: [SPECIFICATION] 射精中ピストン速度20〜25。[VERIFIED FACT] 現行コードにOD固有分岐なし（8〜14のまま）。判定: D。
18. **ID 17 生配信モード**: [SPECIFICATION] コメント流速・スパチャ2倍。[VERIFIED FACT] 現行コードにOD固有分岐なし。判定: D。
19. **ID 18 プチ・タイタン**: [VERIFIED FACT] `Step_0` 277行でペニスのみ 2.8x / 2.2x 化。判定: B。
20. **ID 20 ターボ・ドライブ**: [VERIFIED FACT] `Step_0` 306行で `thrust_speed = 55`。判定: B。
21. **ID 21 黄金蜜精液**: [VERIFIED FACT] `Step_0` 316行で `futa_score += 4`。判定: B。
22. **ID 22 噴乳覚醒**: [VERIFIED FACT] `Step_0` 325行で `top_boob_jiggle += 0.4`。判定: B。
23. **ID 23 極限寸止め**: [VERIFIED FACT] `Step_0` 331行で `edge_boost = 10` 即MAX。判定: B。
24. **ID 24 無限子宮**: [REGRESSION] v8に存在したポンプ毎注ぎ込み +40、amount_boost 3倍が消失。Step_0のfill_max=500のみ。判定: C (退行)。
25. **ID 25 永久垂れ流し**: [VERIFIED FACT] `Step_0` 346行で `fill_amount += 4`。判定: B。
26. **ID 26 百発百中受精**: [VERIFIED FACT] `Step_0` 354行で動作。判定: B。
27. **ID 27 灼熱マグマ**: [VERIFIED FACT] `Step_0` 370行で `sex_progress += 1.2`。判定: B。
28. **ID 28 幻想発光精液**: [VERIFIED FACT] 色変化適用。判定: B。
29. **ID 29 最奥貫通**: [VERIFIED FACT] `Step_0` 387行で length 2.8, width 2.2。判定: B。
30. **ID 30 777フィーバー**: [VERIFIED FACT] `Step_0` 392行で OD時 7777 加算（ただし毎フレーム加算バグあり）。判定: E。
31. **ID 31 多重連鎖絶頂**: [VERIFIED FACT] `Step_0` 396行で `orgasm_timer -= 3`。判定: B。
32. **ID 32 奇跡の多胎繁殖**: [VERIFIED FACT] `Step_0` 400行で `fertilizations = max(..., 4)`。判定: B。
33. **ID 33 永遠の逢瀬**: [VERIFIED FACT] `Step_0` 406行で `max_loads += 10`。判定: B。
34. **ID 34 官能覚醒**: [REGRESSION] ピル本体・OD処理ともに完全消失。判定: F (退行)。
35. **ID 35 極限先走り漏出**: [VERIFIED FACT] `Draw_0` 1172行で 100% 漏出処理あり。判定: B。
36. **ID 36 重装甲ラバー**: [VERIFIED FACT] `Step_0` 414行で `condom_breaking_override = true`。判定: B。
37. **ID 37 シンクロ・ハート**: [REGRESSION] ピル本体・OD処理ともに完全消失。判定: F (退行)。
38. **ID 38 豪腕スラスト**: [VERIFIED FACT] `Step_0` 420行で `thrust_strength = 35`。判定: B。
39. **ID 39 ピストン連鎖**: [REGRESSION] ピル本体・OD処理ともに完全消失。判定: F (退行)。
40. **ID 40 ポンプ連鎖**: [REGRESSION] ピル本体・OD処理ともに完全消失。判定: F (退行)。

---

# H. コンドーム仕様

* **[VERIFIED FACT] 基本メカニクス**:
  - 装着: メニューから装着、またはキー操作。
  - 耐久度: `condom_break = 20`（バニラ）。
  - 破裂: `condom_broken = true` となり、中出し受精判定へ移行。
* **[VERIFIED FACT] 未射精時の抜去サイズ誤判定バグ (重大欠陥)**:
  - 発生箇所: `Draw_0.gml` Line 716:
    ```gml
    if (condom == true)
    {
        condom_size = min(3, stat_liters / 5);
        ...
    }
    ```
  - 現象: ゲーム開始後に一度でも射精すると `stat_liters` が加算される。その後新品コンドームを装着して未射精のまま抜去（Line 725 `if (condom_size > 0)`）すると、`stat_liters` を参照した `condom_size` が 0 より大きいため、**射精していないのに精液満タンのコンドームが生成・ドロップする**。
  - `current_condom_has_cum` の実態: 変数は用意されているが、抜去処理では全く参照されておらず、抜去時リセットも行われていない。
* **[SPECIFICATION] 10ケースの監査基準とあるべき仕様**:
  1. コンドーム装着: `condom = true`, `current_condom_has_cum = false`, `condom_size = 0`。
  2. 射精なし: `current_condom_has_cum` は `false` を維持。
  3. コンドーム抜去: `current_condom_has_cum == false` なら `condom_size = 0` で空のゴムを破棄。精液コンドームは生成しない。
  4. 新品コンドーム装着: 再度 `current_condom_has_cum = false` に初期化。
  5. 過去に大量射精済み: `stat_liters` が大きくても、今回のコンドーム内で射精していなければ影響を受けないこと。
  6. 今回はまだ射精していない: 同上。
  7. コンドーム破裂: `condom_broken = true`, `condom = false`, 中出し移行。
  8. コンドーム交換: 状態がクリーンにリセットされること。
  9. ピル解除: ピル効果解除時にコンドーム状態が破損しないこと。
  10. セーブ/ロード後: ゲーム起動時はコンドーム非装着でクリーンに開始すること。

---

# I. 快感・絶頂仕様

* **[VERIFIED FACT] ふたなり絶頂力学**:
  - `sex_progress >= sex_progress_max` またはキー `M` で絶頂発動。
  - `orgasm = true`, `orgasm_pumps = orgasm_pumps_max`, `orgasm_timer = 120`。
  - 射精ポンプごとに `orgasm_pumps -= 1`, 精液放出・子宮充填・スコア加算。
* **[VERIFIED FACT] 妻の快感・絶頂システム**:
  - `Step_0.gml` 224-244行にて、`thrust > 0.85` の最奥ストローク時に `wife_pleasure` が加算される。
  - 閾値 `wife_pleasure >= wife_pleasure_threshold` 到達で `wife_climax = true`, `wife_climax_timer = 360`, `wife_climax_counter += 1`, スコア `+5000 * counter`。
  - 絶頂ボイス再生、弾性振動発生。
* **[REGRESSION] ID 37 (Sync Heart) の同期欠落**:
  本来はふたなり射精ポンプごとに妻の快感をMAXにして同時絶頂させる仕様であったが、v9以降のスクリプト脱落により完全消失している。

---

# J. 体位・スパンキング仕様

* **[VERIFIED FACT] 3大体位**:
  - Position 0: メイティングプレス（正常位・受精可能）。
  - Position 1: バック騎乗位（受精可能）。
  - Position 2: ディープスロート（受精不可、胃袋充填）。
* **[VERIFIED FACT] スパンキング (`slap_boost`)**:
  - お尻クリックで発動。`slap_boost = 5`（または `6`）。
  - `Alarm_0.gml` 11-24行にて `thrust_speed = random_range(10, 16)`, `thrust_strength = random_range(3, 5)` へ急加速。
  - `Step_0.gml` 218行のガード `if (slap_boost <= 0)` により、加速中は固定値への上書きが防止されている。

---

# K. アンコール仕様

* **[VERIFIED FACT] 現行コードのアンコール処理**:
  `Draw_0.gml` Line 3722-3737:
  ```gml
  if (orgasm == true && orgasm_pumps < 3 && encore == false)
  {
      func_add_combo_flair(func_set_lang(98, "ENCORGASM"), 2500);
      ...
      orgasm = true;
      orgasm_pumps = orgasm_pumps_max;
      orgasm_timer = 120;
      encore = true;
      ...
  }
  ```
  射精終了処理（Line 1562）:
  ```gml
  orgasm = false;
  orgasm_timer = 0;
  sex_progress = 0;
  encore = false;
  ```
* **[REGRESSION] REG-001 無限アンコールガズムの退行事実**:
  発動条件に `encore == false` が課されており、発動直後に `encore = true` となるため、同一射精中には2度と発動しない。射精が完全に終了（`orgasm = false`）するまで `encore` が `false` に戻らない構造である。
* **[SPECIFICATION] 本来の無限アンコール仕様**:
  ユーザー要求（`10_youbou.md`）および過去v7/v8仕様に基づき、射精終了寸前（`orgasm_pumps < 5` 等）にスパンキングを行う限り、同一射精中であっても何度でも `orgasm_pumps` が最大値まで回復し、エンドレスに射精を継続できる仕様とする。

---

# L. UI仕様

* **[VERIFIED FACT] 現在の Draw_64 の実態**:
  `current_gml_v4.1/gml_Object_oFutaMatingPress_Draw_64.gml` にはパレットシェーダー処理の11行しか存在しない。
* **[REGRESSION] REG-002 挿入時専用HUDの完全消失**:
  過去版（v7/v8）で `Draw_64` に追加されていた挿入時HUD（ピストン状態、精液注ぎ込み状態、妻絶頂状態、妻快感度、ふたなり絶頂度、挿入深度、射精回数、精液放出率、子宮容量、受精確率、身体サイズ等）が、v9のCSXリファクタリング時に抜け落ち、現在版で完全に消失している。
* **[VERIFIED FACT] サブメニューUI**:
  `Draw_0.gml` にて 41 種のピルが 3 ページ/グリッド形式で表示される。

---

# M. カスタムコンテンツ仕様

* **[VERIFIED FACT] カスタム読み込みフォルダ**:
  - `custom/`: カスタムキャラ（futa）、配偶者（spouse）、寝室（bedroom）を格納。
* **[VERIFIED FACT] 音声探索の制限 (重大仕様矛盾)**:
  `Create_0.gml` Line 311:
  `var _file = file_find_first(string(arg1) + "/*.ogg", 0);`
  **`.ogg` しかスキャンしておらず、`.wav` ファイルは一切読み込まれない**。
* **[VERIFIED FACT] 変数の二重代入バグ**:
  `Create_0.gml` Line 393-394:
  ```gml
  custom_condom = sFutaCondomNormal;
  custom_condom = sFutaCondomBrokenNormal;
  ```
  破れコンドームの初期化変数が `custom_condom` に上書き代入されている。

---

# N. セーブ/ロード仕様

* **[VERIFIED FACT] セーブ対象 (`save_data.sav`)**:
  - オプション設定（音量、全画面、パレット、言語、X線等）。
  - 解除済みピルリスト (`pill_effects_unlocked` via `ds_list_write`)。
  - 累積統計値（総射精量、総時間、総絶頂回数、総コンドーム数等）。
* **[VERIFIED FACT] セーブ非対象（セッション限定）**:
  - 現在アクティブなピルリスト (`pill_effects_active`)。
  - 現在のコンドーム装着状態・射精有無フラグ (`condom`, `current_condom_has_cum`)。
  - 妻の快感度・絶頂カウンター (`wife_pleasure`, `wife_climax_counter`)。
  - カスタムキャラの選択状態。

---

# O. RPG/ゲームモード仕様

* **[VERIFIED FACT] ダンジョン冒険者モード (ID 13)**:
  - `Step_0.gml` 207行で `rpg = true`。
  - 敵HP、プレイヤーレベル、経験値ゲージの描画。
  - ストローク時（`plap`）および射精ポンプ時にダメージ加算（Stepイベントでの毎フレーム誤加算は存在せず正常）。
* **[VERIFIED FACT] 生配信モード (ID 17)**:
  - 視聴者数、コメント流速、スーパーチャット表示。
* **[VERIFIED FACT] バニーガール経済**:
  - スパンキングおよび胸揉みで所持金（`bunny_money`）加算。

---

# P. 既知の問題一覧

1. **[REGRESSION] REG-001**: 無限アンコールガズムが1回制限版に退行している。
2. **[REGRESSION] REG-002**: `Draw_64` の挿入時専用HUDが完全に消失している。
3. **[REGRESSION] REG-003**: ID 34, 37, 39, 40 の4ピルの効果コードがGMLから完全消失している。
4. **[REGRESSION] REG-004**: ID 24 (Full Container) のポンプ毎注入処理が消失している。
5. **[VERIFIED FACT] BUG-001**: コンドーム抜去時に累積 `stat_liters` を参照するため、未射精でも満タンゴムがドロップする。
6. **[VERIFIED FACT] BUG-002**: ID 30 (777フィーバー) が `Step_0` で毎フレーム加算され、スコアが爆発的にインフレする。
7. **[VERIFIED FACT] BUG-003**: カスタム音声で `.ogg` しか探索されず、仕様書やテンプレートにある `.wav` が読み込まれない。
8. **[VERIFIED FACT] BUG-004**: `Create_0` で `custom_condom` に `sFutaCondomBrokenNormal` が二重代入されている。
9. **[VERIFIED FACT] BUG-005**: `Step_0` 255-261行でピルが1つでも有効だと ID 18〜40 が毎フレーム強制全アンロックされる。

---

# Q. 退行一覧

| 退行ID | 対象機能 | 過去世代の実装 | 現在の実装 | 退行発生世代 | 根本原因 |
|:---:|:---|:---|:---|:---:|:---|
| **REG-001** | 無限アンコール | `orgasm_pumps < 5` で `encore = false` 維持し連続発動可能 | `encore == false` 制限と `encore = true` 代入で1回限定 | v9 | v9 CSX作成時に置換ブロックをドロップ |
| **REG-002** | 挿入時専用HUD | `Draw_64` に `hudModGml` を `QueueAppend` | 11行のパレット処理のみ | v9 | v9 CSX作成時に `QueueAppend` をドロップ |
| **REG-003** | 官能覚醒 (ID 34) | あえぎ確率95%/100%、ピッチ0.85〜1.25 | メニュー表示のみ、ロジックなし | v9 | v9 CSX作成時に置換ブロックをドロップ |
| **REG-004** | シンクロハート (ID 37) | 射精ポンプ毎に妻絶頂同期・loveパーティクル | メニュー表示のみ、ロジックなし | v9 | v9 CSX作成時に置換ブロックをドロップ |
| **REG-005** | ピストン連鎖 (ID 39) | ストローク毎に肉体パラメータ成長 (+0.003/+0.006) | メニュー表示のみ、ロジックなし | v9 | v9 CSX作成時に置換ブロックをドロップ |
| **REG-006** | ポンプ連鎖 (ID 40) | 射精ポンプ毎に肉体パラメータ成長 (+0.0075/+0.015) | メニュー表示のみ、ロジックなし | v9 | v9 CSX作成時に置換ブロックをドロップ |
| **REG-007** | 無限子宮注入 (ID 24) | 射精ポンプ毎に `fill_amount += 25/40` | `Step_0` の `fill_max = 500` のみ | v9 | v9 CSX作成時にポンプ置換ブロックをドロップ |

---

# R. 仕様矛盾一覧

1. **ID 30 (Casino Lucky)**:
   - 旧仕様: 絶頂時 1/9 で +777 (OD時 +1554)。
   - 後期仕様 (CHANGELOG): 絶頂時 100% 確定で +777 (OD時 +7777)。
   - 現在コード: 絶頂中（`orgasm == true`）、毎フレーム +777/+7777 加算。
   - **[SPECIFICATION] 裁定案**: 「射精開始時（1射精につき1回のみ）、100%確定で通常 +777、OD時 +7,777 加算」を正式仕様とする。
2. **ID 31 (Time Delay)**:
   - 旧仕様: 絶頂の余韻タイマー延長（タイマー停止バグの原因）。
   - 後期仕様 (CHANGELOG): マシンガン射精（`orgasm_timer -= 2/3` による連射）。
   - 現在コード: マシンガン射精を採用。
   - **[SPECIFICATION] 裁定案**: 後期の「マシンガン連射射精」を正式仕様として統一する。
3. **カスタム音声拡張子**:
   - 既存仕様/配置: `.ogg` および `.wav` 両対応。
   - 現在コード: `file_find_first("*.ogg")` のみ。
   - **[SPECIFICATION] 裁定案**: `.ogg` と `.wav` の両方を探索・ロードするよう仕様を改定する。
4. **コンドーム膨張上限**:
   - 仕様書05: 通常 6.0倍、無限子宮 10.0倍、OD時 20.0倍。
   - 現在コード: `min(3, stat_liters / 5)`（バニラ上限3.0倍固定）。
   - **[SPECIFICATION] 裁定案**: ピル状態に応じた上限解放（通常3.0〜6.0、ID 24時10.0、OD時20.0）を正式仕様とする。

---

# S. 未検証一覧

以下はコード上に存在するが、実機での正確な挙動が未検証の項目である。

1. **ID 26 (Quick Egg) のコンドーム破裂**: 絶頂の瞬間にゴムが破裂し生受精へ移行するか。
2. **ID 32 (Royal Genesis) の受精アニメーション**: 4つ子受精時の卵子描画が正常に機能するか。
3. **ID 33 (Epilogue Dream) の上限延長挙動**: `loads >= max_loads` 時に次フレームで正しくループが抜けるか。
4. **日本語動的フォントの全画面表示**: 解像度変更時に文字の潰れ・位置ズレが発生しないか。
5. **ディープスロート（Position 2）時のX線断面図**: 食道・胃袋断面図のテクスチャ破綻がないか。

---

# T. 実機テスト項目

静的解析では確定できない項目の実機検証手順（詳細は `HARDWARE_TEST_PLAN.md` 参照）。

1. **アンコールガズム連続テスト**: 射精ゲージ低下時にスパンキングを連続で行い、回復するか確認。
2. **コンドーム未射精抜去テスト**: 過去に射精した状態で新品ゴムを着脱し、空のまま外れるか確認。
3. **ID 30 スコア加算テスト**: 1回の射精でスコアが +777 のみ増えるか（数万増えないか）確認。
4. **カスタムWAV音声テスト**: `.wav` ファイルが実際に再生されるか確認。
5. **挿入時HUD描画テスト**: HUDが画面左下に正しくレイアウトされ、各数値が連動するか確認。

---

# U. 今後の修正ルール

1. **コード修正前の完全監査義務**: 仕様書上の「実装済み」を信じず、必ず現行コードとバイトコードを確認すること。
2. **1機能ずつのアトミック修正**: 複数機能を同時に修正せず、1機能ごとに変更・検証を行うこと。
3. **パッチスクリプトの事前アサーション**: 置換対象が存在しない場合は例外を出して停止させること。
4. **3回失敗時の停止ルール**: 同一不具合の修正に3回失敗した場合は、修正を即時中止し前提仕様・data.win構造を再調査すること。
5. **完成の定義**: 静的確認 ➔ パッチ後逆コンパイル照合 ➔ 実機操作確認の3つが揃って初めて「完成」と認定すること。
