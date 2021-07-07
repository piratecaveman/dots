file=$HOME/.config/Kvantum/kvantum.kvconfig
line=$(grep -n "theme=" $file | cut -f1 -d':')
current=$(sed -n "${line}p" $file)

dark="KvMojave"
light="KvMojaveLight"

if [[ $current == "theme=${dark}" ]];then
	sed -i "${line}s/.*/theme=${light}/" $file &
	notify-send "Changed to Light Theme! (kvantum)"

elif [[ $current == "theme=${light}" ]];then
	sed -i "${line}s/.*/theme=${dark}/" $file &
	notify-send "Changed to Dark Theme (kvantum)"

else
	echo "nothing to do (kvantum)"
fi
