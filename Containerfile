ARG CORE_BRANCH=main

FROM ghcr.io/commonarch/core:$CORE_BRANCH

ARG CORE_BRANCH=main
ARG VARIANT=general
ARG DESKTOP=nogui

RUN if [ "$VARIANT" != container ]; then install-packages-build linux-zen linux-firmware broadcom-wl-dkms; fi

RUN if [ "$DESKTOP" == gnome ]; then install-packages-build gnome; \
  elif [ "$DESKTOP" == plasma ]; then install-packages-build plasma kde-utilities-meta kde-accessibility-meta; \
  elif [ "$DESKTOP" == xfce ]; then install-packages-build xfce4; \
  elif [ "$DESKTOP" == mate ]; then install-packages-build mate mate-extra; \
  elif [ "$DESKTOP" == budgie ]; then install-packages-build budgie budgie-desktop-view network-manager-applet materia-gtk-theme papirus-icon-theme; \
  fi

RUN if [ "$VARIANT" == nvidia ]; then install-packages-build nvidia-dkms; fi

# Clean up cache
RUN yes | pacman -Scc