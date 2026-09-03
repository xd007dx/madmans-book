# Wife's Bedroom - 機能退行（REGRESSION）完全調査報告書
**文書ID**: `REGRESSION_LIST.md`  
**策定日**: 2026年9月3日  
**正本コード基準**: `_modding_workspace/current_gml_v4.1/`  
**比較対象世代**: v7 (`apply_clean_master_v7_apex.csx`), v8 (`apply_clean_master_v8_thrust_and_growth.csx`), v9〜v12 CSX  

---

## 概要と退行発生メカニズムの特定 [VERIFIED FACT]
本プロジェクトにおける深刻な機能退行の連鎖は、**v8 から v9 への移行時（コミット: APPLYING CLEAN MASTER V9）** に集中的に発生した。

### 根本原因 (Root Cause)
1. **パッチスクリプトのスリム化ミス**:
   過去の開発AIが「スクリプトをクリーンにする」「特定不具合（文字化け・マシンガン射精等）に集中する」という目的で v9 スクリプトを新規作成した際、**v7 および v8 で追加されていた主要なパッチブロック（無限アンコール、Draw_64 HUD、ID 34/37/39/40、ポンプ注入等）を丸ごとコピーし忘れ、ドロップ（脱落）させた**。
2. **UTMTのサイレント成功トラップ**:
   `UndertaleModTool` の `CodeImportGroup.QueueFindReplace` は、置換対象が見つからず 0 件置換だった場合でもエラーを出さず正常終了する。そのため、後続の v10、v11、v12 においても「スクリプトが SUCCESS で完了した」というログだけを根拠に「全機能が正常に適用されている」とAIが誤認し続けた。
3. **現在の正本 (`current_gml_v4.1/`) への波及**:
   現在の正本ディレクトリは v11/v12 適用後の `data.win` を逆コンパイルして出力されたものであるため、v9 で脱落した機能がそのまま消失した状態で固定化されている。

---

# 退行項目一覧

---

### 【REG-001】 無限アンコールガズム (Infinite ENCORGASM) の一回制限退行

* **状態**: **確定退行 (REGRESSION)**
* **退行発生世代**: v9 策定時
* **過去版 (v7 / v8 CSX) での実装 [VERIFIED FACT]**:
  `apply_clean_master_v8_thrust_and_growth.csx` Line 948-975:
  ```csharp
  string oldEncorgasmBlock = @"if (orgasm == true && orgasm_pumps < 3 && encore == false)
  {
      ...
      encore = true;
      ...
  }";
  string newEncorgasmBlock = @"if (orgasm == true && orgasm_pumps < 5)
  {
      func_add_combo_flair(func_set_lang(98, ""ENCORGASM""), 2500);
      top_ass_jiggle = -0.2;
      body_jiggle = -0.1;
      func_top_speak(""sex_encorgasm"");
      orgasm = true;
      orgasm_pumps = orgasm_pumps_max;
      orgasm_timer = 120;
      encore = false;
      ...
  }";
  group.QueueFindReplace(drawCode, oldEncorgasmBlock, newEncorgasmBlock);
  ```
  発動条件から `encore == false` を撤廃し、発動後も `encore = false` を維持することで、射精中にスパンキングする限り何度でもアンコールが全回復する構造になっていた。
* **現在コード (`current_gml_v4.1/gml_Object_oFutaMatingPress_Draw_0.gml`) [VERIFIED FACT]**:
  Line 3722-3731:
  ```gml
  if (orgasm == true && orgasm_pumps < 3 && encore == false)
  {
      func_add_combo_flair(func_set_lang(98, "ENCORGASM"), 2500);
      top_ass_jiggle = -0.2;
      body_jiggle = -0.1;
      func_top_speak("sex_encorgasm");
      orgasm = true;
      orgasm_pumps = orgasm_pumps_max;
      orgasm_timer = 120;
      encore = true;
      ...
  }
  ```
  バニラのコードに戻ってしまっており、1回発動すると `encore = true` となり、射精が完全終了（`orgasm = false`）するまで二度と発動しない。
* **本来仕様 [SPECIFICATION]**:
  射精終了間際（`orgasm_pumps < 5`）にスパンキングを行うことで、何度でも `orgasm_pumps` が `orgasm_pumps_max` に全回復し、エンドレスに射精を継続できること。
* **実機確認方法**:
  ゲーム内で絶頂（Mキー）させ、射精ポンプが減ってきたらお尻をクリックしてスパンキングする。1回目のアンコール発動後、再度ポンプが減った際にもう一度スパンキングし、2回目のアンコールが連続して発動するか確認する。

---

### 【REG-002】 挿入時専用HUD (Draw_64 HUD) の完全消失

* **状態**: **確定退行 (REGRESSION)**
* **退行発生世代**: v9 策定時
* **過去版 (v7 / v8 CSX) での実装 [VERIFIED FACT]**:
  `apply_clean_master_v8_thrust_and_growth.csx` Line 1019-1074:
  ```csharp
  string hudModGml = @"
  if (insert == true && title == false && top_sprite != sFutaMatingPressAndroid)
  {
      var _hud_w = 160;
      var _hud_h = 108;
      var _hud_x = 24;
      var _hud_y = display_get_gui_height() - _hud_h - 12;
      ...
      var _status_text = ""ピストン中"";
      if (orgasm == true) _status_text = ""精液注ぎ込み中"";
      else if (wife_climax == true) _status_text = ""★ 妻が絶頂中！ ★"";
      ...
      // 射精回数、放出率、子宮容量、受精確率、妻快感度、挿入深度、身体サイズ(根/太/玉/胸)を描画
      draw_set_font(global.custom_font_small);
      draw_text_color(_hud_x + 8, _hud_y + 8, _hud_info, ...);
  }";
  group.QueueAppend(draw64Code, hudModGml);
  ```
* **現在コード (`current_gml_v4.1/gml_Object_oFutaMatingPress_Draw_64.gml`) [VERIFIED FACT]**:
  Line 1-11:
  ```gml
  if (global.palette > 0)
  {
      application_surface_draw_enable(false);
      scrSetPalette(global.palette);
      draw_surface_ext(application_surface, 0, 0, 1, 1, 0, c_white, 1);
      shader_reset();
  }
  else
  {
      application_surface_draw_enable(true);
  }
  ```
  HUDコードが1行も存在しない。
* **根本原因 [VERIFIED FACT]**:
  v9 のCSXにおいて `draw64Code` に対する `QueueAppend(draw64Code, hudModGml)` が完全に省略され、`draw_set_font` の置換（後にバイトコードフック化）のみに縮小されたため。
* **本来仕様 [SPECIFICATION]**:
  挿入中（`insert == true`）、画面左下に半透明パネルでピストン状態・妻絶頂状態・射精回数・精液放出率・子宮容量・受精確率・妻快感度・挿入深度・ふたなり肉体サイズ（根・太・玉・胸）をリアルタイム描画すること。
* **実機確認方法**:
  挿入状態で画面左下（X:24, Y:画面下部）にHUDウィンドウが表示され、ピストンや射精に応じてテキストと数値が変化することを目視確認する。

---

### 【REG-003】 ID 34 官能覚醒 (Sensual Moan) のロジック完全消失

* **状態**: **確定退行 (REGRESSION)**
* **退行発生世代**: v9 策定時
* **過去版 (v8 CSX) での実装 [VERIFIED FACT]**:
  `apply_clean_master_v8_thrust_and_growth.csx`:
  1. `Step_0` (Line 244):
     `if (ds_list_find_index(pill_effects_active, 34) != -1) _p_add += (ds_list_find_index(pill_effects_active, 19) != -1 ? 1.5 : 0.8);`
  2. `Draw_0` (Line 788-792):
     ```gml
     if (ds_list_find_index(pill_effects_active, 34) != -1 || ...)
     {
         moan_chance = (ds_list_find_index(pill_effects_active, 19) != -1) ? 0 : (irandom(99) < 95 ? 0 : 1);
         moan_pitch = random_range(0.85, 1.25);
     }
     ```
* **現在コード (`current_gml_v4.1`) [VERIFIED FACT]**:
  - `Step_0.gml`: ID 34 の参照なし。
  - `Draw_0.gml`: サブメニューへの追加 `ds_list_add(submenu_list, [func_set_lang(231, "Sensual Moan"), 34]);` (Line 2340) のみ存在。あえぎ処理の中には一切存在しない。
* **根本原因 [VERIFIED FACT]**:
  v9 CSX作成時に `Draw_0` の `oldMoaningBlock` 置換が完全に除外されたため。
* **本来仕様 [SPECIFICATION]**:
  ピル有効時、通常95%、OD時100%の確率でストローク時にあえぎ声を発声し、ボイスピッチを 0.85〜1.25 で官能的に揺らがせ、妻の快感度上昇にボーナス（+0.8 / OD +1.5）を加算する。
* **実機確認方法**:
  ID 34 を服用してピストンを行い、ほぼ毎ストローク喘ぎ声が出るか、ピッチが変動するかを確認する。

---

### 【REG-004】 ID 37 シンクロ・ハート (Sync Heart) の同期ロジック完全消失

* **状態**: **確定退行 (REGRESSION)**
* **退行発生世代**: v9 策定時
* **過去版 (v8 CSX) での実装 [VERIFIED FACT]**:
  `apply_clean_master_v8_thrust_and_growth.csx` Line 869-883:
  ```gml
  // Sync Heart (ID 37) Orgasm Pump Sync
  if (ds_list_find_index(pill_effects_active, 37) != -1)
  {
      wife_pleasure = wife_pleasure_threshold;
      wife_climax = true;
      wife_climax_timer = 240;
      wife_climax_counter += 1;
      futa_score += 5000;
      body_jiggle = 0.08;
      bottom_ass_jiggle = 0.6;
      var _p_done = max(0, orgasm_pumps_max - orgasm_pumps);
      var _s_vol = _od_active ? min(1.0, 0.65 + (_p_done * 0.08)) : 0.85;
      var _s_pitch = _od_active ? min(1.5, 0.95 + (_p_done * 0.07)) : 1.0;
      audio_play_sound(choose(sndMoanOrgasm1, sndMoanOrgasm2, sndMoanOrgasm3, sndMoanOrgasm5), 0, false, _s_vol, 0, _s_pitch);
      part_particles_create(global.ps_back, x + random_range(-64, 64), (y - 40) + random_range(-32, 32), part_love, 8);
  }
  ```
* **現在コード (`current_gml_v4.1`) [VERIFIED FACT]**:
  - `Draw_0.gml` Line 1508 付近の射精ポンプ処理に ID 37 のコードが一切存在しない（バニラの `stat_liters += liters;` のみ）。
  - サブメニュー追加（Line 2343）に名前があるのみ。
* **根本原因 [VERIFIED FACT]**:
  v9 CSX作成時に `Draw_0` の `oldOrgasmBlock` 置換が丸ごと削られたため。
* **本来仕様 [SPECIFICATION]**:
  ふたなりの射精ポンプごとに、妻の快感度を最大化して `wife_climax = true`（同時多重絶頂）を発動させ、絶頂ボイスとハートパーティクル（`part_love`）を連続発生させる。
* **実機確認方法**:
  ID 37 を服用して射精させ、射精ポンプが作動するたびに妻の絶頂演出・ボイス・ハートエフェクトが出るか確認する。

---

### 【REG-005】 ID 39 ピストン連鎖 (Thrust Surge) の成長ロジック完全消失

* **状態**: **確定退行 (REGRESSION)**
* **退行発生世代**: v9 策定時
* **過去版 (v8 CSX) での実装 [VERIFIED FACT]**:
  `apply_clean_master_v8_thrust_and_growth.csx` Line 731-741:
  ```gml
  if (ds_list_find_index(pill_effects_active, 39) != -1)
  {
      var _has_od_piston = (ds_list_find_index(pill_effects_active, 19) != -1);
      var _p_grow = _has_od_piston ? 0.006 : 0.003;
      var _p_lim = _has_od_piston ? 3.0 : 2.8;
      if (top_penis_length < _p_lim) top_penis_length = min(_p_lim, top_penis_length + _p_grow);
      if (top_penis_width < _p_lim) top_penis_width = min(_p_lim, top_penis_width + _p_grow);
      if (top_ass_size < _p_lim) top_ass_size = min(_p_lim, top_ass_size + _p_grow);
      if (ball_size < _p_lim) ball_size = min(_p_lim, ball_size + _p_grow);
      if (top_boob_size < _p_lim) top_boob_size = min(_p_lim, top_boob_size + _p_grow);
  }
  ```
* **現在コード (`current_gml_v4.1`) [VERIFIED FACT]**:
  - `Draw_0.gml` Line 1080 付近の `plap == false` ストローク処理に ID 39 のコードが一切存在しない。
  - サブメニュー追加（Line 2428）に名前があるのみ。
* **根本原因 [VERIFIED FACT]**:
  v9 CSX作成時に `Draw_0` の `oldThrustStrokeAnchor` 置換が除外されたため。
* **本来仕様 [SPECIFICATION]**:
  ピストンのストローク（最奥到達・plap発生）ごとに、ふたなりのペニス長・ペニス太・お尻・玉・胸が +0.003（OD時 +0.006）ずつリアルタイムに成長する（上限 2.8 / OD 3.0）。
* **実機確認方法**:
  ID 39 を服用してピストンを行い、ストロークを繰り返すことで肉体各部が徐々に巨大化するか確認する。

---

### 【REG-006】 ID 40 ポンプ連鎖 (Pump Surge) の成長ロジック完全消失

* **状態**: **確定退行 (REGRESSION)**
* **退行発生世代**: v9 策定時
* **過去版 (v8 CSX) での実装 [VERIFIED FACT]**:
  `apply_clean_master_v8_thrust_and_growth.csx` Line 886-895:
  ```gml
  // ★ Pump Surge (ID 40): Grow on every orgasm pump!
  if (ds_list_find_index(pill_effects_active, 40) != -1)
  {
      var _pump_grow = _od_active ? 0.015 : 0.0075;
      var _pump_lim = _od_active ? 3.0 : 2.8;
      if (top_penis_length < _pump_lim) top_penis_length = min(_pump_lim, top_penis_length + _pump_grow);
      if (top_penis_width < _pump_lim) top_penis_width = min(_pump_lim, top_penis_width + _pump_grow);
      if (top_ass_size < _pump_lim) top_ass_size = min(_pump_lim, top_ass_size + _pump_grow);
      if (ball_size < _pump_lim) ball_size = min(_pump_lim, ball_size + _pump_grow);
      if (top_boob_size < _pump_lim) top_boob_size = min(_pump_lim, top_boob_size + _pump_grow);
  }
  ```
* **現在コード (`current_gml_v4.1`) [VERIFIED FACT]**:
  - `Draw_0.gml` 射精ポンプ処理内に ID 40 のコードは一切存在しない。
* **根本原因 [VERIFIED FACT]**:
  v9 CSX作成時に `Draw_0` の `oldOrgasmBlock` 置換が除外されたため。
* **本来仕様 [SPECIFICATION]**:
  射精ポンプが作動するたびに、ペニス長・太・尻・玉・胸が +0.0075（OD時 +0.015）ずつギュンギュン巨大化する（上限 2.8 / OD 3.0）。
* **実機確認方法**:
  ID 40 を服用して射精させ、精液が注ぎ込まれる毎に肉体サイズが目に見えて大きくなるか確認する。

---

### 【REG-007】 ID 24 無限子宮 (Full Container) のポンプ注入処理消失

* **状態**: **部分退行 (REGRESSION / PARTIAL)**
* **退行発生世代**: v9 策定時
* **過去版 (v8 CSX) での実装 [VERIFIED FACT]**:
  `apply_clean_master_v8_thrust_and_growth.csx` Line 861-866:
  ```gml
  // Full Container (ID 24) Injection
  if (ds_list_find_index(pill_effects_active, 24) != -1)
  {
      fill_amount += (_od_active ? 40 : 25);
      fill_lerp = fill_amount + 5;
      amount_boost *= (_od_active ? 3 : 2);
  }
  ```
* **現在コード (`current_gml_v4.1`) [VERIFIED FACT]**:
  `Step_0.gml` Line 338-341 に `fill_max = 500;` だけが存在し、射精ポンプ毎の大量注入コードは消失している。
* **本来仕様 [SPECIFICATION]**:
  上限が 500 に拡張されるだけでなく、射精ポンプ作動ごとに通常 +25（OD時 +40）の子宮充填が行われ、射精量倍率（amount_boost）が 2倍（OD時 3倍）に強化されること。
* **実機確認方法**:
  ID 24 を服用して射精させ、お腹の膨張速度と精液注ぎ込み量が劇的に増加するか確認する。

---

### 【REG-008】 Cum Limit (精液上限パーティクル数) 拡張の脱落

* **状態**: **確定退行 (REGRESSION)**
* **過去版 (v8 CSX) [VERIFIED FACT]**:
  `apply_clean_master_v8_thrust_and_growth.csx` Line 1077-1080:
  メニューの Cum Limit 表記と `Step_0` の最大パーティクル制限を `max(20, round(max_particles * 500))` から `max(500, round(max_particles * 10000))` へ20倍拡張していた。
* **現在コード (`current_gml_v4.1`) [VERIFIED FACT]**:
  `Step_0.gml` 159行には `var cum_limit = max(500, 10000 * max_particles);` が残っているが、メニュー描画のテキスト更新がバニラに戻っている。
