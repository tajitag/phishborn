# PhishBorn - サイト起動マネージャー

PhishBornは、ローカルおよび仮想サーバーを使用してPHPベースのサイトを素早く起動し、ログイン情報などのPOSTデータを監視できるツールです。**教育目的専用**です。

---

## 特徴

* 複数のサイト（index.php）から選択して起動
* ローカルホスト (`http://localhost:8000`) または Cloudflared を使った仮想公開
* `log.txt` にログイン情報などをリアルタイム監視
* 終了時に自動でサーバープロセスを停止

---

## 使い方

```bash
git clone https://github.com/tajitag/phishborn.git
```
```bash
cd phishborn
```
```bash
chmod +x born.sh
```
```bash
./born.sh
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



# PhishBorn（Educational Edition）

## 【重要：このツールは教育・研究目的以外での使用を禁止します】

本ツールは**フィッシングの手法を理解し、セキュリティ対策を学ぶことを目的**としています。  
以下のような目的・使用を固く禁じます：

- 他人のIDやパスワードを収集する目的での使用
- インターネット上での公開・拡散
- GitHub以外の場所への無断転載

**このツールはローカル環境（localhost）以外での使用を想定していません。**

---

## 【合法的な使用例】

- セキュリティ教育の講義における模擬攻撃デモ
- 自己学習のためのWebセキュリティ演習
- CTFやハニーポット構築のための検証目的

---

## 【免責事項（Disclaimer）】

本ソフトウェアは「現状のまま」提供されます。  
**このツールの使用によって生じた損害・犯罪行為には、開発者は一切責任を負いません。**

---

## This tool is for **educational and ethical hacking training purposes only.**  
Any form of unauthorized phishing, credential harvesting, or online deployment is strictly prohibited.

**Use only in a local environment. Never upload or use this tool on live websites or networks.**

---

## 作者

tajitag

---

