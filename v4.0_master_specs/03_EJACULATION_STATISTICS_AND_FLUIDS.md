# Wife's Bedroom - 射精統計・流体 ＆ 漏出シミュレーション仕様書 (v4.0 決定版)
# (03_EJACULATION_STATISTICS_AND_FLUIDS.md)

本仕様書は、射精ポンプ数、精液排出量（L）、精子数（M/B/T）、射精持続時間、先走り漏出確率式（`leak_chance` / Leaky EX）、体液パーティクル物理、および永続セーブ統計の全計算式を詳細に定義します。

---

## 1. 射精シーケンスのライフサイクル [✅ 実装確認済]

快感度が上限に達した際（`sex_progress >= sex_progress_max`）、射精シーケンスが始動します。

1. **初期化パラメータ**:
   - `orgasm = true`
   - `orgasm_pumps = orgasm_pumps_max`
   - `orgasm_timer = 120`（最初のドクドク噴出までのディレイ）
   - `orgasm_sec_timer = 60`（1秒カウントダウンタイマー）
   - `loads += 1`（二股ペニス時は `+2`）
   - `stat_total_orgasms += 1`
2. **射精中のピストン挙動**:
   - 通常時: 腰の動きが一時停止・緩慢化（`thrust_speed = 2`, `thrust_strength = 3`）
   - **猛ピストン（ID 16）時**: 射精中も腰が一切止まらず超激震（`thrust_speed = random_range(8, 14)`、OD時 `20〜25`）

---

## 2. 射精ポンプ数 ＆ 精液・精子数計算式 [✅ 実装確認済]

### ① 総射精ポンプ数 (`orgasm_pumps_max`)
巨根であるほど射精回数（ドクドク回数）が増加します。

$$\text{orgasm\_pumps\_max} = 20 \times (\text{top\_penis\_length} \times \text{top\_penis\_width})$$

- **標準サイズ（1.0×1.0）**: **20回**
- **最奥貫通（2.5×1.8）**: $20 \times 4.5 =$ **90回** のドクドク超ロング射精

### ② 1ポンプあたりの射精量（Liters）計算式
$$\Delta \text{stat\_liters} = 0.25 \times \text{amount\_boost}$$

ここでの $\text{amount\_boost}$ は以下の累積式で決定されます：
$$\text{amount\_boost} = \text{ball\_size} \times \text{edge\_boost} \times (\text{二股? } 2 : 1) \times (\text{3回即イキ? } 20 : 1) \times (\text{成長連鎖? } \text{loads}/10 : 1)$$

- **通常時（ball=1.0, edge=1.0）**: 1ポンプで **`0.25 L`**（20ポンプで合計 **`5.0 L`**）
- **極限寸止め10倍時**: 1ポンプで **`2.5 L`**（90ポンプで合計 **`225.0 L`** の特大放出）

### ③ 1ポンプあたりの精子数（Sperm Count）計算式
$$\Delta \text{stat\_sperm\_cell} = \text{random\_range}(20, 100)\text{M} \times \text{amount\_boost}$$

- **単位変換とHUD描画**:
  - `0〜999`: `M`（百万人 / Millions）
  - `1,000〜999,999`: `B`（十億人 / Billions）
  - `1,000,000以上`: `T`（兆人 / Trillions）

---

## 3. 射精持続秒数 (`stat_duration`) ＆ アチーブメント [✅ 実装確認済]

射精中、60フレーム（1秒）ごとに `orgasm_sec_timer` がゼロになり秒数が加算されます。

```
[ 射精開始 ] ──▶ [ 60 frames 経過 ] ──▶ stat_duration += 1
                                    ├── 30秒到達: "HALF MINUTE ORGASM" (+5,000 pts)
                                    └── 60秒到達: "FULL MINUTE ORGASM" (+10,000 pts)
```

- **多重連鎖絶頂（ID 31）**: 絶頂中のポンプ間隔タイマー（`orgasm_timer`）を緩やかに延長し、長時間の射精痙攣と正確な秒数計測（`stat_duration`）を両立。

---

## 4. `leak_chance`（先走り漏出確率）の完全仕様 [✅ 実装確認済]

### ① 先走り漏出（ID 9: Leaky）
- **通常ピストン時**: $1/11$（約9%）の確率で漏出。
- **スパンキング（`slap_boost > 0`）時**: $1/2$（**50%**）の高確率で漏出。
- **オーバードーズ併用時**: **100% 確定漏出**。

### ② 極限先走り漏出（ID 35: Leaky EX）
- **通常ピストン時**: **30%** の高確率で白濁液が大量漏出（`fill_amount += 8 * ball_size * edge_boost`）。
- **スパンキング（`slap_boost > 0`）時**: **75%** の超高確率でドバッと漏出。
- **オーバードーズ併用時**: ピストン・スパンキング共に **100% 確定漏出 ＆ 漏出量2倍**。

### ③ 永久垂れ流し（ID 25: Endless Drip）
- **挿入中**: 毎フレーム `fill_amount += 2.0`（オーバードーズ時 `+4.0`）が休みなく注ぎ込まれ続ける。
- **抜去中**: $1/13$（毎秒約5回）の頻度で先端から先走り滴りがドクドクと自発的に垂れ落ちる。

---

## 5. 体液パーティクル仕様 [✅ 実装確認済]

| パーティクル名 | スプライト | 重力 / 速度 | 寿命 (Frames) | 生成トリガー |
| :--- | :--- | :--- | :--- | :--- |
| **`part_cum`** | `sCum` | 速度 $3.0〜3.5$, 拡散 | $60〜120$ | 射精・大量噴射スプラッシュ |
| **`part_cum_leak`** | `sCum` | 重力 $0.1$ (下向き), 縮小 | $120〜180$ | 先走り滴り、子宮口からの漏出 |
| **`part_milk_leak`** | `sCum` | 重力 $0.1$ (270°), 微小 | $45〜90$ | 豊満化・噴乳時の胸揉み母乳 |

---

## 6. 永続セーブ統計パラメータ一覧 [✅ 実装確認済]

- `stat_total_sex_sec`, `stat_total_sex_min`, `stat_total_sex_hour`: 累計行為時間
- `stat_total_distance`: 累計ピストンストローク移動距離（メートル換算）
- `stat_total_slaps`: 累計お尻スパンキング回数
- `stat_total_orgasms`: 累計絶頂回数
- `stat_total_orgasm_pumps`: 累計ドクドク射精ポンプ数
- `stat_total_sperm_cell`: 累計射精精子数
- `stat_total_liters`: 累計射精精液量（リットル）
- `stat_total_orgasm_duration`: 累計射精持続秒数
- `stat_total_fertilizations`: 累計受精回数
- `stat_total_condoms_used`: 累計コンドーム使用本数
