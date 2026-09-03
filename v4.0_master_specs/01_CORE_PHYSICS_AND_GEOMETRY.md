# Wife's Bedroom - コア物理 ＆ 幾何学断面図計算仕様書 (v4.0 決定版)
# (01_CORE_PHYSICS_AND_GEOMETRY.md)

本仕様書は、ピストンの補間物理、ペニス描画の幾何学補正、X線断面図における子宮膨張と反転防止計算式、豪腕スラストによる突き力学、および絶頂時睾丸収縮アニメーション（BallClenching）の座標制御を詳細に定義します。

---

## 1. ピストン物理シミュレーション式 [✅ 実装確認済]

行為中のペニスのストローク位置（`thrust`: $0.0 = \text{最浅/抜去}$, $1.0 = \text{最深部挿入}$）は、入力目標値 `thrust_set` に対して毎フレーム以下のスプリング補間式によって滑らかに追従します。

$$\text{thrust}_{t+1} = \text{thrust}_t + \left( (\text{thrust\_set} - \text{thrust}_t) \times (\text{thrust\_lerp} \times \text{thrust\_strength}) \right)$$

- **`thrust_lerp`**: 補間係数（通常時 `0.1`、絶頂時引き抜き防止 `0.01`）
- **`thrust_strength`（突き強度）**:
  - 通常時: `3.0`
  - 猛ピストン（ID 16）時: `5.0`
  - 豪腕スラスト（ID 38）時: **`20.0`**（深部まで一瞬でグイグイ押し込む強烈な打撃感）
  - 豪腕スラスト × オーバードーズ（ID 19）: **`35.0`**（画面が激震する究極のヘヴィピストン）
- **ピストン速度による慣性揺れ**:
  $$\text{balls\_jiggle} = \text{balls\_jiggle} - \frac{\text{thrust} - \text{thrust\_prev}}{8}$$
  $$\text{top\_boob\_jiggle} = \text{top\_boob\_jiggle} + (\text{thrust\_speed} \times 0.2)$$

---

## 2. ペニス描画の幾何学補正 ＆ 股間根元完全密着式 [✅ 実装確認済]

### ① 幾何学補正方程式
ペニス長さ倍率を $L$（`top_penis_length`）、太さ倍率を $W$（`top_penis_width`）、基準拡大率を $S$（`base_sex_size = 2`）としたとき、描画Y座標 $Y_{\text{penis}}$ を以下のように補正します。

$$Y_{\text{penis}} = y - (\text{thrust} \times 32 \times S) + (L - 1) \times 16$$

- **効果**: 長さが $2.5\text{倍}$（最奥貫通）、太さが $1.8\text{倍}$、成長連鎖で $3.0\text{倍}$ に巨大化しても、**根元は股間の定位置に1ピクセルも狂わず100%完全密着**します。

---

## 3. X線断面図（X-Ray）における子宮最深部到達補正 [✅ 実装確認済]

X線断面図におけるペニス先端の到達深度オフセット $Y_{\text{xray}}$ は以下の通りです。

$$Y_{\text{xray}} = 40 \times \text{thrust} \times \text{top\_penis\_length}$$

- 最深部ストローク時（`thrust = 1.0`）、ペニス先端が膣腔を押し広げ、**子宮頸管（子宮口）を突き破って子宮の最奥壁（突き当り）に100%密着**します。

---

## 4. 子宮サイズ（`womb_size`）とボテ腹（`cumflation`）の計算式 [✅ 実装確認済]

### ① 子宮断面図の拡大倍率 (`womb_size`)
$$womb\_size = \text{median}\left(1, \frac{\text{fill\_amount}}{\text{fill\_max}}, 6\right)$$
- 基準容量 $\text{fill\_max} = 100$（1回の射精で満タン到達）。
- 満タンを超えて注入されるごとに $womb\_size$ は最大 $6.0\text{倍}$ まで巨大化。

### ② ボテ腹の膨らみ倍率 (`cumflation_amount`)
$$\text{cumflation\_amount} = \text{median}\left(0, \frac{(\text{fill\_amount} / \text{fill\_max}) - 1}{1.5}, \text{max\_cumflation\_size}\right)$$
- **通常上限**: `max_cumflation_size = 2.5`
- **伸縮子宮 (ID 12)**: `max_cumflation_size = 10.0`
- **無限子宮 (ID 24)**: `max_cumflation_size = 20.0`（**オーバードーズ併用時は2倍の `40.0`**。お腹が画面を突き破るレベルで前方に超巨大化）

### ③ 断面図の縮小・反転防止式 (`xray_size`)
$$xray\_size = \max\left(0.4, \, 2 - (\max(0, \text{womb\_size} - 1) \times 0.12)\right)$$
- 子宮がどれほど膨張しても断面図スケールは最小 $0.4$ で下限ガードされ、**反転・消失バグが100%防止**されます。

---

## 5. BallClenching（睾丸脈動アニメーション）描画エンジン [✅ 実装確認済]

絶頂時、睾丸がドクドクと収縮して精液を押し出す5フレームのアニメーションスプライト（`sBallsClenching`）の描画仕様です。

```
Frame 0: 弛緩状態（初期）
Frame 1: 緊張・引き締まり始め
Frame 2: 最大収縮（射精の瞬間）
Frame 3: ドクンと脈打つ解放
Frame 4: 次の収縮への移行
```

### ① アニメーションフレーム決定式
$$\text{Frame} = \left\lfloor \left( \text{clamp}\left(1 - \frac{\text{orgasm\_timer}}{50}, 0, 1\right) \right)^{0.4} \times 4 \right\rfloor$$

### ② 二重描画の抑制ロジック
絶頂時（`orgasm == true` かつ `custom_clench_toggle == true`）、静止画の玉スプライト描画を完全にバイパスし、玉が4つに見えるバグを解消。

### ③ 描画座標補正式
アニメーションスプライトの原点差分を相殺するため、静止画位置より**玉1つ分下方向（`+ ball_size * 12`）**に描画します。

$$Y_{\text{clench}} = y - (\text{thrust} \times 32 \times \text{base\_sex\_size}) + (\text{ball\_size} \times 12)$$
