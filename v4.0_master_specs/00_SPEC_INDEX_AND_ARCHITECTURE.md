# Wife's Bedroom - v4.0 マスター仕様書インデックス ＆ アーキテクチャ体系
# (00_SPEC_INDEX_AND_ARCHITECTURE.md)

本ドキュメントは、『Wife's Bedroom』拡張MODシステム（v4.0 Apex Complete Edition）の全体構造、モジュール構成、ファイル体系、および各仕様書章の役割を定義するマスターインデックスです。

---

## 1. 仕様書モジュール構成一覧 (v4.0)

| 章番号 | ファイル名 | 主要内容 | ステータス |
| :---: | :--- | :--- | :---: |
| **00** | `00_SPEC_INDEX_AND_ARCHITECTURE.md` | システム全体構成・アーキテクチャ・モジュール索引 | ✅ v4.0 最新 |
| **01** | `01_CORE_PHYSICS_AND_GEOMETRY.md` | ペニス根元幾何学・貫通深度・断面図・BallClenching | ✅ v4.0 最新 |
| **02** | `02_AROUSAL_PLEASURE_AND_CLIMAX_SYSTEM.md` | 快感度蓄積・連続絶頂・喘ぎ声・シンクロ絶頂 | ✅ v4.0 最新 |
| **03** | `03_EJACULATION_STATISTICS_AND_FLUIDS.md` | 射精統計・先走り漏出EX・流体物理・多重連鎖 | ✅ v4.0 最新 |
| **04** | `04_ALL_41_PILLS_AND_SYNERGY_MATRIX.md` | 全41種ピル定義・OD覚醒シナジー・コンドームシナジー | ✅ v4.0 最新 |
| **05** | `05_CONDOM_MECHANICS_AND_DYNAMICS.md` | コンドーム弾性膨張力学(6x/20x)・耐久度・破裂・変色 | ✅ v4.0 最新 |
| **06** | `06_POSITIONS_SPANKING_AND_INTERACTIONS.md` | 体位別物理・無限アンコールガズム・スパンキング | ✅ v4.0 最新 |
| **07** | `07_GAME_MODES_AND_SCORE_ECONOMY.md` | ダンジョンRPG・配信モード・カジノ777・バニー経済 | ✅ v4.0 最新 |
| **08** | `08_DIALOGUE_AND_CUSTOM_MOD_SYSTEM.md` | 日本語TTFフォント・JSON対話・カスタム立ち絵ローダー | ✅ v4.0 最新 |
| **09** | `09_SAVE_SYSTEM_AND_DATA_STRUCTURE.md` | セーブデータ暗号化構造・全ピルHexフラグ・チートツール | ✅ v4.0 最新 |
| **10** | `10_USER_REQUIREMENTS_SUMMARY.md` | ユーザー要望・改善課題・設計方針サマリー | ✅ v4.0 最新 |
| **11** | `11_FEASIBLE_NEW_PILLS_AND_PROPOSALS.md` | 実装可能新規ピル選定・技術検証・アイデア評価 | ✅ v4.0 最新 |
| **12** | `12_IMPLEMENTATION_STATUS_AND_GAP_ANALYSIS.md` | 実機コード対比・総合実装率監査（100%達成） | ✅ v4.0 最新 |
| **13** | `13_DETAILED_CODE_VERIFICATION_AND_GAP_REPORT.md` | 実機バイナリ逆コンパイル証拠・GMLコード監査レポート | ✅ v4.0 最新 |
| **CL** | `CHANGELOG.md` | バージョン履歴（v1.0〜v4.0）と全変更差分 | ✅ v4.0 最新 |

---

## 2. システムアーキテクチャ概要

```
[ ゲームエンジン: GameMaker Studio 2 ]
  │
  ├── [ コアオブジェクト: oFutaMatingPress ]
  │     ├── Create_0 : 限界値3.0x、10段階レーティング関数、TTFフォントローダー、BallClenching初期化
  │     ├── Step_0   : 全41種ピル動的更新、妻快感度蓄積、Titan Thrust物理、速度自己復帰
  │     ├── Draw_0   : ピル選択3列メニュー(41種)、10段階UI描画、ピストン/ポンプ成長、先走りEX、Sync Heart
  │     └── Draw_64  : 左下リアルタイムHUD描画（深度・快感度・絶頂回数・肉体サイズ）
  │
  ├── [ 外部リソース ]
  │     ├── language/lang_japanese.txt, lang_english.txt (全237項目)
  │     ├── language/font.ttf (動的日本語フォント)
  │     ├── clench_sprites/ (睾丸収縮スプライト群)
  │     └── custom/ (カスタムキャラ・立ち絵・背景)
  │
  └── [ ビルド ＆ パッチシステム ]
        ├── tools/apply_clean_master_v8_thrust_and_growth.csx (統合マスターパッチ)
        ├── tools/UTMT_CLI/UndertaleModCli.exe (GMLバイトコードインジェクター)
        └── tools/test_launch_game.py (実機自動起動・クラッシュ検知テスト)
```
