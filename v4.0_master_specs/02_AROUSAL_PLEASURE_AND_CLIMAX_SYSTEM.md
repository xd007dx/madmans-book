# Wife's Bedroom - 快感度・絶頂 ＆ 感覚演出仕様書 (v4.0 決定版)
# (02_AROUSAL_PLEASURE_AND_CLIMAX_SYSTEM.md)

本仕様書は、ふたなりの快感度蓄積、寸止め（エッジング）判定、妻の快感度＆連続絶頂（`wife_pleasure`/`wife_climax`）、`thrust_speed` による感度連動、あえぎ声の全発生条件・音源制御、およびハートエフェクトの力学仕様を詳細に定義します。

---

## 1. ふたなり快感度（`sex_progress`）と絶頂判定 [✅ 実装確認済]

### ① 快感度蓄積式
ピストンが最深部（`thrust > 0.85`）に達するごとに加算されます。

$$\Delta \text{sex\_progress} = \min(\text{max\_progress\_rate}, 1.0 \times \text{edge\_boost})$$

- **初期上限**: `sex_progress_max = 50`（Three Pump Champ時は `20`、Stamina時は `150`）
- **絶頂判定**: `sex_progress >= sex_progress_max` またはキーボード `M` 押下で射精シーケンス（`orgasm = true`）へ移行。

### ② 寸止め（エッジング）メカニズム
- **引き抜き判定条件**: `sex_progress >= (sex_progress_max * 0.6)`（快感度60%以上の寸前状態）でペニスを抜去（`thrust < 0.2`）。
- **成功時の処理**:
  1. `edge_boost = min(max_edge, edge_boost + 0.5)`（倍率が上昇。通常上限3倍、Edge Meister時**10倍**）
  2. `sex_progress = sex_progress_max * 0.5`（快感度が50%まで後退し、再ピストン可能に）
  3. `orgasm_pumps_max *= 1.05`（射精時の総ポンプ数が5%ずつ増加）
  4. コンボ表示: `EDGE BOOST xN` が画面左上に表示。

---

## 2. 妻の快感度 ＆ 連続絶頂システム (`wife_pleasure` / `wife_climax`) [✅ 実装確認済]

妻側にも独立した快感度ゲージ（`wife_pleasure`）が存在し、ピストンの激しさや速度に応じて蓄積され、限界に達すると連続絶頂します。

### ① 快感度加算方程式
挿入中（`insert == true`）かつピストン深部（`thrust > 0.85`）時、毎フレーム以下が加算されます。

$$\Delta \text{wife\_pleasure} = \left( 0.6 + (\mathbf{thrust\_speed} \times 0.1) \right) \times \left( 1 + (\text{edge\_boost} \times 0.2) \right) \times (\text{Overdose ? } 2 : 1) + \text{SensualBonus}$$

- **`thrust_speed`（突き速度）の影響**:
  - 通常ピストン (`thrust_speed = 2`): 加算ベース $0.6 + 0.2 = 0.8$
  - 猛ピストン (`thrust_speed = 10`): 加算ベース $0.6 + 1.0 = 1.6$
  - ターボ・ドライブ (`thrust_speed = 40`): 加算ベース $0.6 + 4.0 = 4.6$（通常の約6倍！）
  - ターボ・ドライブ × OD (`thrust_speed = 55`): 加算ベース $(0.6 + 5.5) \times 2 = 12.2$（爆速絶頂！）
- **官能覚醒（ID 34）**: 通常時 `+0.8`、OD時 `+1.5` が毎フレーム常時上乗せ加算。

### ② 妻の絶頂トリガーと状態変化
`wife_pleasure >= wife_pleasure_threshold`（初期閾値 `100`）に達した瞬間に発動：

1. **閾値のプログレッシブ上昇**:
   $$\text{wife\_pleasure\_threshold}_{N+1} = \text{wife\_pleasure\_threshold}_N \times 1.25$$
   （イクごとに妻の持久力がつき、次の絶頂にはより激しい愛撫が必要になる自然な曲線）
2. **絶頂フラグ・タイマー起動**:
   - `wife_climax = true`
   - `wife_climax_timer = 360`（60fps環境で **6秒間** のロング絶頂）
   - `wife_climax_counter += 1`（連続絶頂回数カウント）
3. **スコアボーナス**:
   $$\Delta \text{futa\_score} = 5,000 \times \text{wife\_climax\_counter}$$
4. **身体リアクション ＆ 音声**:
   - `bottom_ass_jiggle = 0.5`（お尻が激しく痙攣・波打つ）
   - `body_jiggle = 0.05`
   - 絶頂喘ぎ音声 `choose(sndMoanOrgasm1, sndMoanOrgasm2, sndMoanOrgasm3, sndMoanOrgasm5)` を再生。
5. **HUD表示変化**:
   - 左下HUDのステータスが `★ 妻が絶頂中！ ★` に切り替わり、テキスト全体が**鮮烈なピンク色（RGB 255, 105, 180）**に発光。

---

## 3. あえぎ声（Moaning）の全発生条件 ＆ 音声制御仕様 [✅ 実装確認済]

あえぎ声システムは `moaning == true`（設定でON）のときに機能します。

### ① あえぎ声の音源リスト
- **低興奮・スロー時 (`moan_slow_list`)**:
  `sndMoanOpenSlow1`, `sndMoanOpenSlow2`, `sndMoanOpenSlow3`, `sndMoanClosedSlow1`, `sndMoanClosedSlow2`, `sndMoanClosedSlow3`, `sndMoanClosedSlow4`, `sndMoanExtra1`, `sndMoanExtra2`, `sndMoanExtra3`, `sndMoanExtra4`
- **高興奮・激しいピストン時 (`moan_fast_list`)**:
  `sndMoanOpenFast1`, `sndMoanOpenFast2`, `sndMoanOpenFast3`, `sndMoanClosedFast1`, `sndMoanClosedFast2`, `sndMoanClosedFast3`, `sndMoanClosedFast4`
- **絶頂時 (`orgasm_list`)**:
  `sndMoanOrgasm1`, `sndMoanOrgasm2`, `sndMoanOrgasm3`, `sndMoanOrgasm5`

### ② あえぎ声の発生条件一覧

| 状況 / トリガー | 判定条件 | 発生確率 / 挙動 | 使用音源リスト |
| :--- | :--- | :--- | :--- |
| **通常ピストン（低〜中興奮）** | `sex_progress < sex_progress_max * 0.6` | ピストンごとに $1/9$（約11%）の確率 | `moan_slow_list` |
| **激しいピストン（高興奮時）** | `sex_progress >= sex_progress_max * 0.6` | ピストンごとに $1/5$（20%）の確率 | `moan_fast_list` |
| **官能覚醒（ID 34） / 噴乳覚醒（ID 22）** | ID 34 / 22 有効時 | ピストンごとに **95%の超高確率（オーバードーズ時 100% 確定）** | `moan_slow_list` / `fast` |
| **3回即イキピル（ID 10）** | ID 10 アクティブ時 | ピストンごとに **100%（確実にあえぐ）** | `moan_slow_list` / `fast` |
| **射精ポンプ中** | `orgasm == true && orgasm_timer < 1` | ポンプごとに $1/6$ の確率 | `moan_slow_list` |
| **射精直後の余韻** | 射精シーケンス終了時 | **100%単発再生**（息切れ・余韻あえぎ） | `moan_slow_list` |
| **スパンキング（尻叩き）** | お尻をクリックした瞬間 | **100%即時再生** | `moan_fast_list` |
| **アンコールガズム** | 射精終了直前にスパンキング | 前の音声を即座に停止し、**絶頂あえぎを即時再生** | `orgasm_list` |
| **ふたなり側絶頂の瞬間** | `orgasm = true` になった瞬間 | 前の音声を停止し、**絶頂あえぎを最優先再生** | `orgasm_list` |
| **妻の絶頂の瞬間** | `wife_pleasure >= threshold` | 音量 `0.9` の大音量で**絶頂あえぎを即時再生** | `orgasm_list` |

- **ピッチ揺らぎ**: 通常 `random_range(0.9, 1.1)`、官能覚醒時 `random_range(0.85, 1.25)`。
- **連続再生防止**: 直前に再生された音声ID `moan_previous` は抽選リストから一時除外。
- **カスタム音声対応**: `custom/パートナー名/moan_slow/`, `moan_fast/`, `orgasm/` フォルダ内にWAV/OGGを配置することで完全置換可能。

---

## 4. ハートエフェクト（Love Hearts）の力学 ＆ 描画仕様 [✅ 実装確認済]

```
       ▲  [ 浮上消滅 (Life: 60〜180 frames) ]
     ♡   ♥
   ♥       ♡
 [ 発生源: (x ± 128, y - 40 ± 64) ]
```

### ① 出現トリガー条件
1. **高興奮状態でのピストン**:
   - 条件: `sex_progress >= (sex_progress_max * 0.6)`（快感度60%以上）
   - 発生頻度: 15フレーム（毎秒4回）ごとに1個ずつ生成。
2. **キス（Kissing）実行時**:
   - 顔・口元をクリックした際、`part_love` が浮上。
3. **シンクロ・ハート（ID 37）絶頂時**:
   - 射精ポンプに合わせて大量のハートパーティクルが爆発発生。

### ② パーティクル物理パラメータ定義
- **パーティクル型**: `part_love`
- **使用スプライト**: `sHearts`（サブイメージ `2`）
- **発生座標**: $X = x + \text{random\_range}(-128, 128)$, $Y = (y - 40) + \text{random\_range}(-64, 64)$
- **移動方向**: $90^\circ$（真上方向へまっすぐ上昇）
- **移動速度**: `0.1`（ゆっくり漂うように上昇）
- **寿命（Life）**: `60〜180 フレーム`（1.0秒〜3.0秒でフェードアウト消滅）
- **描画レイヤー**: `global.ps_back`（キャラクターの背後に美しく舞う）
