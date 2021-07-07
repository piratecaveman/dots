file=$HOME/.config/gtk-3.0/settings.ini
line=$(grep -n "gtk-theme-name=" $file | cut -f1 -d':')
current=$(sed -n "${line}p" $file)


light="McOS-CTLina-Mint"
dark="McOS-CTLina-Mint-Dark"

if [[ $current =~ $dark ]]; then

	sed -i "${line}s/.*/gtk-theme-name=${light}/" $file &
	notify-send "Switched to Light Theme! (GTK)"

elif [[ $current =~ $light ]]; then
	sed -i "${line}s/.*/gtk-theme-name=${dark}/" $file &
	notify-send "Switched to Dark Theme! (GTK)"

else
	echo "Nothing to do"
fi
