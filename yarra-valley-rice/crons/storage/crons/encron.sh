#!/usr/bin/bash

base_folder="/media/ntfs/home/leshen"
dens="${base_folder}/dens"
encrypted_dens="${base_folder}/encrypted-dens"
cloud="${dens}/cloud"
music="${HOME}/storage/music"
encrypted_grizzly_den="${encrypted_dens}/grizzly-den"
encrypted_wolf_den="${encrypted_dens}/wolf-den"
onedrive="onedrive-kj1594-protonmail:"
yandex="yandex-kj1594:"
dropbox="dropbox-piratecaveman:"
cloud_grizzly="dens/grizzly-den/"
cloud_wolf="dens/wolf-den/"
cloud_music="music/"
cloud_cloud="cloud/"


function run_rclone()
{
    source="${1}"
    destination="${2}"

    /usr/bin/rclone --transfers=16 sync -P "${source}/" "${onedrive}${destination}"
    /usr/bin/rclone --transfers=16 sync -P "${source}/" "${yandex}${destination}"
    /usr/bin/rclone --transfers=16 sync -P "${source}/" "${dropbox}${destination}"
}

echo "Syncing grizzly-den"
run_rclone "${encrypted_grizzly_den}" "${cloud_grizzly}"

echo "Syncing wolf den"
run_rclone "${encrypted_wolf_den}" "${cloud_wolf}"

echo "Syncing music"
run_rclone "${music}" "${cloud_music}"

echo "Syncing cloud"
run_rclone "${cloud}" "${cloud_cloud}"
