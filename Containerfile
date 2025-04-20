ARG CORE_BRANCH=main

# Pull from my fork of core image instead.
FROM ghcr.io/silverhadch/core:$CORE_BRANCH

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

RUN if [ "$DESKTOP" == gnome ]; then install-packages-build xorg-server gdm; systemctl enable gdm; \
  elif [ "$DESKTOP" == plasma ]; then install-packages-build xorg-server sddm; systemctl enable sddm; \
  elif [ "$DESKTOP" == xfce ]; then install-packages-build xorg-server lightdm lightdm-gtk-greeter; systemctl enable lightdm; \
  elif [ "$DESKTOP" == mate ]; then install-packages-build xorg-server lightdm lightdm-gtk-greeter; systemctl enable lightdm; \
  elif [ "$DESKTOP" == budgie ]; then install-packages-build xorg-server lightdm lightdm-gtk-greeter; systemctl enable lightdm; \
  fi

RUN if [ "$VARIANT" == nvidia ]; then install-packages-build nvidia-dkms; fi

RUN install-packages-build grub efibootmgr

RUN install-packages-build python-yaml python-click python-fasteners skopeo umoci jq

COPY overlays/common /

RUN systemctl enable commonarch-update-cleanup

# Clean up cache
RUN yes | pacman -Scc
