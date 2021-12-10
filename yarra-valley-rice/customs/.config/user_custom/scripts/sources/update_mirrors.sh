#!/usr/bin/env bash

update_mirrors() {
    local outdir
    outdir="${OUTPUT_DIR:-HOME}"

    rate-mirrors \
        --country-neighbors-per-country 5 \
        --country-test-mirrors-per-country 5 \
        --save "${outdir}/mirrors.txt" \
        arch
}
