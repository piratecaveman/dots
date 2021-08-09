#!/usr/bin/env bash

OUTPUT_DIR="${PWD}"

if [[ ! -d "${OUTPUT_DIR}" ]]; then
    mkdir -p "${OUTPUT_DIR}"
fi

box_1="box-1"
box_2="box-2"
box_general="box-general"
mega_iamabot_another="mega-iamabot-another"
mega_iamabot_yandex="mega-iamabot-yandex"
mega_iamabot001="mega-iamabot001"
mega_iamrobox001="mega-iamrobox001"
mega_kj1594="mega-kj1594"
mega_mega_1="mega-mega-1"
mega_nohjeodpourg="mega-nohjeodpourg"
pcloud_iamabot001="pcloud-iamabot001"
pcloud_pcloud_1="pcloud-pcloud-1"
pcloud_pcloud_2="pcloud-pcloud-2"

function get_listing() {
    echo "Getting listings for ${1}: ..."
    /usr/bin/rclone lsd -R "${1}:" >"${OUTPUT_DIR}/${1}.txt"
}

if [[ -n "${1}" ]]; then
    get_listing "${1}"
else
    get_listing "${box_1}"
    get_listing "${box_2}"
    get_listing "${box_general}"
    get_listing "${mega_iamabot_another}"
    get_listing "${mega_iamabot_yandex}"
    get_listing "${mega_iamabot001}"
    get_listing "${mega_iamrobox001}"
    get_listing "${mega_kj1594}"
    get_listing "${mega_mega_1}"
    get_listing "${mega_nohjeodpourg}"
    get_listing "${pcloud_iamabot001}"
    get_listing "${pcloud_pcloud_1}"
    get_listing "${pcloud_pcloud_2}"
fi
