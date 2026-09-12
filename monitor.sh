#!/bin/bash

                                 
CONFIG_FILE="$HOME/studies/tg_monitor.conf"
LOG_FILE="$HOME/studies/tg_monitor.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') — $1" >> "$LOG_FILE"
}


if [ ! -f "$CONFIG_FILE" ]; then
    echo "Файл не найден $CONFIG_FILE"
    exit 1
fi

source "$CONFIG_FILE"


while true; do


RESPONSE=$(curl -s "https://api.telegram.org/bot$BOT_TOKEN/getUpdates?offset=$OFFSET&timeout=30&limit=1")
UPDATE_ID=$(echo "$RESPONSE" | jq -r ".result[-1].update_id // empty")
log "UPDATE_ID: $UPDATE_ID"

if [ -n "$UPDATE_ID" ]; then
    CHAT_ID=$(echo "$RESPONSE" | jq -r '.result[-1].message.chat.id // empty')
    
    if [ "$ADMIN_ID" == "$CHAT_ID" ]; then
        TEXT_MSG=$(echo "$RESPONSE" | jq -r '.result[-1].message.text // empty')


        if [[ "$TEXT_MSG" == "/inf" ]]; then


#ОЗУ/RAM
            RAM=($(LC_ALL=C free -m))

            TEXT_RAM="📊Загрузка RAM:
- Всего: <b>${RAM[7]} Мб</b> 
- Занято: <b>${RAM[8]} Мб</b>
- Своб: <b>${RAM[9]} Мб</b> 
- Общая: <b>${RAM[10]} Мб</b>
- Буф/врем.: <b>${RAM[11]} Мб</b>
- Доступно: <b>${RAM[12]} Мб</b>
    
Подкачка: 
Всего: <b>${RAM[14]} Мб</b> 
Занято: <b>${RAM[15]} Мб</b> 
Доступно: <b>${RAM[16]} Мб</b>"

            curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
                -d "chat_id=$CHAT_ID" \
                -d "text=$TEXT_RAM" \
                -d "parse_mode=HTML" &
        
        fi
    fi
    OFFSET=$((UPDATE_ID+1))
fi



done
