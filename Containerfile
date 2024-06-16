ARG CORE_BRANCH=main
ARG VARIANT=nvidia

FROM ghcr.io/commonarch/core:$CORE_BRANCH

RUN <<EOF
pacman -Sy --needed linux-zen linux-firmware broadcom-wl-dkms

if [[ "$VARIANT" == nvidia ]]; then
    pacman -Sy --needed nvidia-dkms
fi
EOF