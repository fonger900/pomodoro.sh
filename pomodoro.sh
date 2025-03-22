#!/bin/bash

LOGFILE="$HOME/pomodoro_log.txt"
DATE=$(date +"%Y-%m-%d")

# Kiểm tra xem ngày hôm nay đã có trong log chưa
if ! grep -q "$DATE" "$LOGFILE"; then
    echo "📅 Ngày $DATE" >> "$LOGFILE"
fi

COUNT=0  # Đếm số Pomodoro

# Hàm hiển thị đếm ngược
countdown() {
    local seconds=$1
    while [ $seconds -gt 0 ]; do
        echo -ne "\r⏳ Còn lại: $(printf "%02d:%02d" $((seconds/60)) $((seconds%60))) "
        sleep 1
        ((seconds--))
    done
    echo -e "\r✅ Hết thời gian!                 "
}

for i in {1..4}; do 
    echo "🍅 Pomodoro $i: 25 phút làm việc"
    countdown 1500  # 25 phút
    echo -e "\a"  # Âm thanh thông báo

    ((COUNT++))
    echo "$(date +"%H:%M") - Pomodoro $COUNT hoàn thành" >> "$LOGFILE"

    if [ $i -lt 4 ]; then 
        echo "☕ Nghỉ 5 phút"
        countdown 300  # 5 phút nghỉ
    else 
        echo "🎉 Nghỉ dài 15 phút"
        countdown 900  # 15 phút nghỉ dài
    fi

    echo -e "\a"  # Âm thanh khi hết thời gian nghỉ
done

echo "✅ Hoàn thành $COUNT Pomodoro hôm nay! 🎊"  
echo -e "\a"  # Âm thanh cuối cùng

# Ghi tổng số Pomodoro vào cuối ngày
echo "Tổng số Pomodoro hôm nay: $COUNT" >> "$LOGFILE"
echo "--------------------------------" >> "$LOGFILE"

