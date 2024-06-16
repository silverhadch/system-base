ARG CORE_BRANCH=main

FROM ghcr.io/commonarch/core:$CORE_BRANCH

ARG CORE_BRANCH=main
ARG VARIANT=general
ARG DESKTOP=nogui

RUN if [ "$VARIANT" != container ]; then pacman -Sy --needed --noconfirm linux-zen linux-firmware broadcom-wl-dkms; fi
RUN if [ "$VARIANT" == nvidia ]; then pacman -Sy --needed --noconfirm nvidia-dkms; fi

RUN if [ "$DESKTOP" == gnome ]; then pacman -Sy --needed --noconfirm gnome; \
  elif [ "$DESKTOP" == plasma ]; then pacman -Sy --needed --noconfirm plasma kde-utility-meta kde-accessibility-meta; \
  elif [ "$DESKTOP" == xfce ]; then pacman -Sy --needed --noconfirm xfce4; \
  elif [ "$DESKTOP" == mate ]; then pacman -Sy --needed --noconfirm mate mate-extra; \
  elif [ "$DESKTOP" == budgie ]; then pacman -Sy --needed --noconfirm budgie budgie-desktop-view network-manager-applet materia-gtk-theme papirus-icon-theme; \
  fi