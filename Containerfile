ARG CORE_BRANCH=main

FROM ghcr.io/commonarch/core:$CORE_BRANCH

ARG CORE_BRANCH=main
ARG VARIANT=general

RUN if [ "$VARIANT" != container ]; pacman -Sy --needed --noconfirm linux-zen linux-firmware broadcom-wl-dkms; fi
RUN if [ "$VARIANT" == nvidia ]; then pacman -Sy --needed --noconfirm nvidia-dkms; fi