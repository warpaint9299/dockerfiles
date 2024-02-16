FROM archlinux:base-devel AS base

RUN echo -e 'Server = https://mirrors.aliyun.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist && \
	echo -e 'Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrors && \
	echo -e '[multilib]' >> /etc/pacman.conf && \
	echo -e 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf && \
	echo -e '[archlinuxcn]' >> /etc/pacman.conf && \
	echo -e 'Server = https://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf && \
	pacman -Syy --noconfirm && \
	pacman-key --init && \
	pacman-key --lsign-key "farseerfc@archlinux.org" && \
	pacman -S --noconfirm archlinuxcn-keyring && \
	pacman -Scc --noconfirm

RUN pacman -S --noconfirm yay && \
	groupadd sudo && \
    useradd -m -G sudo -s /bin/bash user && \
    echo 'user:password' | chpasswd && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
	pacman -Scc --noconfirm

USER user

WORKDIR /home/user

RUN yay -Syy --noconfirm && \
yay -S --noconfirm tigervnc-server adobe-source-han-mono-cn-fonts nerd-fonts-jetbrains-mono xorg xorg-xinit && \
yay -Scc --noconfirm

RUN yay -S --noconfirm st picom feh blueman network-manager-applet && \
mkdir -p ~/.vnc && \
touch ~/.vnc/config && \
echo "session=dwm" > ~/.vnc/config && \
printf "password\npassword\nn\n" | vncpasswd && \
yay -Scc noconfirm
