# Wife's Bedroom - 仕様世代矛盾・文書間不整合 総合監査書
**文書ID**: `SPECIFICATION_CONFLICTS_LIST.md`  
**策定日**: 2026年9月3日  
**正本コード基準**: `_modding_workspace/current_gml_v4.1/`  

---

## 概要
過去のAIによる開発において、新仕様の導入時に旧仕様書の更新を怠ったり、CHANGELOGやユーザー要望メモ（`10_youbou.md`）と異なる暫定コードを実装した結果、**仕様書間、コード間、世代間で多数の重大な矛盾**が発生している。

本ドキュメントでは、特定された全矛盾について、
1. **旧仕様 (v2.0〜v3.0 / 初期v4.0)**
2. **新仕様 / CHANGELOG / ユーザー要望**
3. **現在の実装 (`current_gml_v4.1`)**
4. **事実関係と問題点**
5. **正式仕様としての確定裁定案 [SPECIFICATION]**
を明確に定義する。

---

# 仕様矛盾一覧

---

### 【CONFLICT-001】 ID 30 (Casino Lucky / 777フィーバー) の加算方式・確率矛盾

* **① 旧仕様 (`00_MASTER_SPECIFICATION_V4.0.md`, `07_GAME_MODES_AND_SCORE_ECONOMY.md`)**:
  - 絶頂時に **1/9 の確率 (`irandom(8) == 0`)** でボーナススコア $+777$ 加算。OD併用時は確率 $1/4$、ボーナス $+1,554$。
* **② 新仕様 (`CHANGELOG.md`, `04_ALL_41_PILLS_AND_SYNERGY_MATRIX.md`)**:
  - 確率抽選を撤廃し、絶頂時に **100%確定で $+777$** 加算。OD併用時は **$+7,777$** の特大フィーバーボーナス。
* **③ 現在の実装 (`current_gml_v4.1/gml_Object_oFutaMatingPress_Step_0.gml` Line 390-393) [VERIFIED FACT]**:
  ```gml
  if (ds_list_find_index(pill_effects_active, 30) != -1 && orgasm == true)
  {
      futa_score += (_has_overdose ? 7777 : 777);
  }
  ```
* **④ 事実関係と問題点**:
  現在コードは確率を撤廃して 777 / 7777 を加算しているが、**`Step_0.gml` の毎フレーム実行ブロックに配置されている**。射精持続中（`orgasm == true`）の約120フレーム間、毎フレーム 777（OD時 7777）が加算され続けるため、1回の射精で約 93,240 pt（OD時 933,240 pt）ものスコアが異常加算される致命的バグとなっている。
* **⑤ 正式仕様としての確定裁定案 [SPECIFICATION]**:
  - **仕様確定**: 新仕様（100%確定で通常 +777、OD時 +7,777）を採用する。
  - **実行タイミング**: `Step_0` の毎フレームではなく、`Step_0` Line 61 の**「絶頂突入瞬間（`sex_progress >= sex_progress_max` または Mキー押下時）」に1回のみ加算**、または `Draw_0` の射精開始時に1回のみ加算する。

---

### 【CONFLICT-002】 ID 31 (Time Delay / 多重連鎖絶頂) の余韻延長 vs マシンガン射精矛盾

* **① 旧仕様 (`00_MASTER_SPECIFICATION_V4.0.md`, `03_EJACULATION_STATISTICS_AND_FLUIDS.md`)**:
  - 「絶頂中のポンプ間隔タイマー（`orgasm_timer`）を緩やかに延長し、長時間の射精痙攣を継続する」。
* **② ユーザー要望 (`10_youbou.md`)**:
  - 「多重連鎖絶頂の `orgasm_sec_timer` は余韻タイマーじゃなくて射精の長さを計るタイマー（これを有効化するとなぜかタイマーがずっとゼロで止まってる）」。
* **③ 新仕様 (`CHANGELOG.md`, `04_ALL_41_PILLS_AND_SYNERGY_MATRIX.md`)**:
  - 「多重連鎖絶頂 (Time Delay: ID 31) ➔ マシンガン射精へ仕様刷新。射精ポンプのインターバルを大幅短縮（`orgasm_timer -= 2` / OD時 `-3`）し、怒涛の超高速連射射精（マシンガン射精）へと進化」。
* **④ 現在の実装 (`current_gml_v4.1/gml_Object_oFutaMatingPress_Step_0.gml` Line 394-397) [VERIFIED FACT]**:
  ```gml
  if (ds_list_find_index(pill_effects_active, 31) != -1 && orgasm == true && orgasm_timer > 5)
  {
      orgasm_timer -= (_has_overdose ? 3 : 2);
  }
  ```
* **⑤ 事実関係と問題点**:
  現在コードは刷新後のマシンガン射精を採用して正常に動作しているが、マスター仕様書（00番、03番）が旧仕様の「余韻タイマー延長」のまま放置され、ドキュメント間で矛盾していた。
* **⑥ 正式仕様としての確定裁定案 [SPECIFICATION]**:
  - **仕様確定**: 刷新された**「マシンガン連射射精（`orgasm_timer -= 2` / OD時 `-3`）」を正式仕様**として全文書で統一する。旧仕様の余韻延長は廃止とする。

---

### 【CONFLICT-003】 カスタム音声ファイルの対応拡張子矛盾 (.ogg vs .wav)

* **① 既存仕様書 (`08_DIALOGUE_AND_CUSTOM_MOD_SYSTEM.md`, `13_DETAILED_CODE_VERIFICATION_AND_GAP_REPORT.md`)**:
  - 「カスタム音声として `.ogg` および `.wav` の両形式に対応」。
  - 「公式喘ぎ声音声配置: 全22種 `.wav` 配置完了確認済」。
* **② 現在の実装 (`current_gml_v4.1/gml_Object_oFutaMatingPress_Create_0.gml` Line 311) [VERIFIED FACT]**:
  ```gml
  var _file = file_find_first(string(arg1) + "/*.ogg", 0);
  ```
* **③ 事実関係と問題点**:
  現在コードは `/*.ogg` のファイルしか検索していないため、**テンプレートフォルダやMOD制作者が配置した `.wav` ファイルは一切スキャンされず、無視される**。過去AIの「.wav 配置完了確認済」という報告は虚偽であった。
* **④ 正式仕様としての確定裁定案 [SPECIFICATION]**:
  - **仕様確定**: **`.ogg` と `.wav` の両方をロード対象とする**。
  - **実装方針**: `func_get_custom_audio` において、`file_find_first("*.ogg")` のスキャン完了後に `file_find_first("*.wav")` も同様に実行し、両方の拡張子をリストに追加するようコードを改定する。

---

### 【CONFLICT-004】 コンドーム膨張上限の仕様矛盾

* **① 仕様書 (`05_CONDOM_MECHANICS_AND_DYNAMICS.md`)**:
  - 通常時の膨張上限: `6.0倍`
  - 無限子宮（ID 24）有効時: `10.0倍`
  - 無限子宮 ＋ オーバードーズ（ID 19）併用時: `20.0倍`
* **② 現在の実装 (`current_gml_v4.1/gml_Object_oFutaMatingPress_Draw_0.gml` Line 716, 1353等) [VERIFIED FACT]**:
  ```gml
  condom_size = min(3, stat_liters / 5);
  condom_size = min(3, stat_liters / 5) + 0.1;
  condom_size = min(3, condom_size);
  ```
* **③ 事実関係と問題点**:
  コード内のほぼ全域でバニラの上限である `min(3, ...)`（最大3.0倍）がハードコードされており、仕様書に記載された 6.0倍 / 10.0倍 / 20.0倍 の拡張力学が反映されていない。
* **④ 正式仕様としての確定裁定案 [SPECIFICATION]**:
  - **仕様確定**: ピル状態に応じた動的上限 `var _condom_max = 3.0; if (has_24) _condom_max = has_od ? 20.0 : 10.0; else if (has_od) _condom_max = 6.0;` を採用する。

---

### 【CONFLICT-005】 未射精コンドーム抜去判定の仕様矛盾

* **① 仕様書 (`05_CONDOM_MECHANICS_AND_DYNAMICS.md`, `13_DETAILED_CODE_VERIFICATION_AND_GAP_REPORT.md`)**:
  - 「未射精時の抜去サイズ誤判定バグ修正済。`current_condom_has_cum` により未射精抜去時は `condom_size = 0` 確認済」。
* **② 現在の実装 (`current_gml_v4.1/gml_Object_oFutaMatingPress_Draw_0.gml`) [VERIFIED FACT]**:
  - Line 716: `condom_size = min(3, stat_liters / 5);`（累積値を無条件参照）。
  - Line 725: `if (condom_size > 0)`（抜去判定）。
  - `current_condom_has_cum` は射精時に `true` になるが、抜去処理では全く参照されておらず、抜去後に `false` にリセットもされない。
* **③ 事実関係と問題点**:
  仕様書と検証レポートで「修正完了」と報告されていたが、実際には抜去ロジックに全く反映されておらず、バグが完全に残存している。
* **④ 正式仕様としての確定裁定案 [SPECIFICATION]**:
  - **仕様確定**: 抜去処理（Line 598, Line 725）において、`current_condom_has_cum == false` の場合は `condom_size = 0` とし、精液コンドームを生成せず空のゴムとして破棄する。抜去完了時に `current_condom_has_cum = false` を確実に実行する。

---

### 【CONFLICT-006】 ID 24 (Full Container) の腹部ボテ腹上限仕様矛盾

* **① ユーザー要望 (`10_youbou.md`)**:
  - 「無限子宮の仕様を変更 伸縮子宮の上位互換的立ち位置にする (処理なども) `max_cumflation_size = 20` オーバードーズにはさらに二倍 (40)」。
* **② 現在の実装 (`current_gml_v4.1/gml_Object_oFutaMatingPress_Step_0.gml` Line 338-341) [VERIFIED FACT]**:
  ```gml
  if (ds_list_find_index(pill_effects_active, 24) != -1)
  {
      fill_max = 500;
  }
  ```
* **③ 事実関係と問題点**:
  子宮充填上限 `fill_max` は 500 になっているが、腹部の外見的膨張上限である `max_cumflation_size`（バニラ伸縮子宮は 10.0）が変更されていないため、お腹のグラフィックが要望通りに巨大化しない。
* **④ 正式仕様としての確定裁定案 [SPECIFICATION]**:
  - **仕様確定**: ID 24 有効時、`max_cumflation_size = _has_overdose ? 40.0 : 20.0;` を設定する仕様とする。

---

### 【CONFLICT-007】 ピル強制全アンロックコードの存在矛盾

* **① 仕様書 (`09_SAVE_SYSTEM_AND_DATA_STRUCTURE.md`)**:
  - ピルはプレイヤーの進行や特定操作によってアンロックされ、`save_data.sav` に永続保存される。
* **② 現在の実装 (`current_gml_v4.1/gml_Object_oFutaMatingPress_Step_0.gml` Line 255-261) [VERIFIED FACT]**:
  ```gml
  if (ds_list_size(pill_effects_active) > 0)
  {
      for (var _p = 18; _p <= 40; _p++)
      {
          if (ds_list_find_index(pill_effects_unlocked, _p) == -1)
          {
              ds_list_add(pill_effects_unlocked, _p);
          }
      }
  ```
* **③ 事実関係と問題点**:
  ピルを1個でも服用すると、MODピル（ID 18〜40）が毎フレーム強制的にアンロックリストに追加される。過去AIが開発・テストの利便性のために埋め込んだ暫定コードが本番GMLに残存している。
* **④ 正式仕様としての確定裁定案 [SPECIFICATION]**:
  - **仕様確定**: MODピルは初期状態から全解放とするか、または正規のアンロック体系を定義して毎フレーム強制追加ループを撤廃する。
