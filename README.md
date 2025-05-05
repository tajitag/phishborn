# PhishBorn - サイト起動マネージャー

PhishBornは、ローカルおよび仮想サーバー（Cloudflared）を使用してPHPベースのサイトを素早く起動し、ログイン情報などのPOSTデータを監視できるツールです。**教育目的専用**です。

---

## 特徴

* 複数のサイト（index.php）から選択して起動
* ローカルホスト (`http://localhost:8000`) または Cloudflared を使った仮想公開
* `log.txt` にログイン情報などをリアルタイム監視
* 終了時に自動でサーバープロセスを停止

---

## インストール

```bash
git clone https://github.com/tajitag/phishborn.git
cd phishborn
chmod +x run.sh
```


## 使い方

```bash
./run.sh
```

1. サイト一覧から対象を選ぶ
2. 公開方法（ローカル or Cloudflared）を選ぶ
3. ログイン情報（POST）をリアルタイムに監視（`log.txt`）
4. Ctrl+C で終了し、プロセスも自動停止

---

## 必須要件

* `php`
* `cloudflared`（仮想サーバー使用時）

Cloudflaredがインストールされていない場合は、以下で導入：

```bash
sudo apt install cloudflared
```

---

## 注意

このツールは**教育目的のみに使用**してください。第三者の情報を不正に取得・利用する行為は禁止されています。

---

## 作者

tajitag

**PhishBorn**

PhishBorn by tajitag

---

## ライセンス

MIT License
