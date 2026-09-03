# Wife's Bedroom - 詳細コード検証 ＆ 動作確認レポート (v4.1)
# (13_DETAILED_CODE_VERIFICATION_AND_GAP_REPORT.md)

本レポートは、『Wife's Bedroom: Apex Refined MOD v4.1』における全改修項目のバイトコードレベルでの検証結果と、修正された不具合の完全ログです。

---

## 1. バイトコードレベル検証サマリー

| 項目 | 検証コード箇所 | 検証結果 |
| :--- | :--- | :---: |
| **動的フォント置換 (Bytecode Hook)** | `Draw_0.gml` 全27箇所の `draw_set_font` 命令 | ✅ 全27箇所フック置換確認済（四角文字化け解消） |
| **多言語セリフ自動スワップ** | `func_get_dialogue_json` ➔ `dialogue_en/` / `dialogue_ja/` | ✅ 言語選択連動確認済 |
| **言語設定永続化** | `save_data.sav` (`[options] language_selected`) | ✅ セーブ＆ロード動作確認済 |
| **マシンガン射精 (ID 31)** | `Step_0.gml` (`orgasm_timer -= 2 / 3`) | ✅ フリーズ解消＆連射ポンプ確認済 |
| **7777 OD フィーバー (ID 30)** | `Step_0.gml` (`futa_score += 777 / 7777`) | ✅ 100%確定加算確認済 |
| **スマート玉サイズ (ID 1 × OD)** | `Step_0.gml` (`ball_size = max(ball_size, 1.4)`) | ✅ 視覚サイズ抑制＆射精量強化確認済 |
| **極限寸止め OD シナジー (ID 23)** | `Step_0.gml` (`edge_boost = 10`) | ✅ 1回抜去で即MAX確認済 |
| **先走り漏出 vs EX 差別化** | `Draw_0.gml` (`leak_chance` 分岐) | ✅ ID 9(2x) vs ID 35(確定) 分離確認済 |
| **スパンキング急加速復旧** | `Step_0.gml` (`slap_boost <= 0` ガード) | ✅ `thrust_speed = 10〜16` 連動確認済 |
| **未射精抜去コンドーム修正** | `Draw_0.gml` (`current_condom_has_cum`) | ✅ 未射精抜去時 `condom_size = 0` 確認済 |
| **公式喘ぎ声音声配置** | `custom/_TEMPLATE_LOVER/` & `_TEMPLATE_PARTNER/` | ✅ 全22種 `.wav` 配置完了確認済 |
| **タイトルMOD名表記** | `Draw_0.gml` (`version_string`) | ✅ `Apex Refined MOD v4.1` 描画確認済 |
| **実機プロセステスト** | `wifes_bedroom.exe` | ✅ `Title: 'Wife's Bedroom', Responding: True` 確認済 |
