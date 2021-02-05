#!/bin/bash

## update system ##
sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y

## add dev packages ##
sudo apt install git build-essential nodejs npm python3-pip -y

## add user packages ##
sudo apt install flatpak p7zip-full p7zip-rar rar x11-utils gnome-tweaks -y

## add npm packages ##
sudo npm install --global yarn

## add pip packages ##
pip3 install virtualenv

## add snap packages ##
sudo snap install code --classic
sudo snap install docker

## add flathub repository ##
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

## add flatpak packages ##
sudo flatpak install flathub org.gnome.Boxes -y
sudo flatpak install flathub org.gnome.Cheese -y
sudo flatpak install flathub org.gnome.Totem -y
sudo flatpak install flathub org.gimp.GIMP -y
sudo flatpak install flathub com.transmissionbt.Transmission -y
sudo flatpak install flathub com.discordapp.Discord -y
sudo flatpak install flathub com.wps.Office -y
sudo flatpak install flathub com.valvesoftware.Steam -y

## download external packages ##
wget -qO- 'https://git.io/papirus-icon-theme-install' | DESTDIR="$HOME/.icons" sh
wget -c 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
wget -c 'https://dl.strem.io/shell-linux/v4.4.120/Stremio+4.4.120.flatpak'
wget -O Extension_bundles.zip 'https://gitlab.gnome.org/GNOME/gnome-shell-extensions/-/jobs/1111100/artifacts/download'
wget -c 'https://cutewallpaper.org/21/cute-box-robot-wallpaper/Amazon-Wallpaper-48-images-on-Genchi.info.jpg'
git clone 'https://github.com/daniruiz/Flat-Remix-GTK.git'
git clone 'https://github.com/daniruiz/flat-remix-gnome.git'
git clone 'https://github.com/hardpixel/unite-shell.git'

## add external deb ##
for app in $(ls *.deb); do
    sudo apt install ./$app -y
    rm $app
done

## add external flatpak ##
for app in $(ls *.flatpak); do
    sudo flatpak install $app -y
    rm $app
done

## repair icons ##
cp /var/lib/flatpak/app/com.stremio.Stremio/current/active/export/share/applications/com.stremio.Stremio.desktop ~/.local/share/applications
sed -i "s/Icon=com.stremio.Stremio/Icon=stremio/g" ~/.local/share/applications/com.stremio.Stremio.desktop

## add gnome extensions ##
unzip -j Extension_bundles.zip zip-files/user-theme@gnome-shell-extensions.gcampax.github.com.shell-extension.zip
unzip user-theme@gnome-shell-extensions.gcampax.github.com.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/user-theme@gnome-shell-extensions.gcampax.github.com
rm *.zip
cp -r ~/unite-shell/unite@hardpixel.eu ~/.local/share/gnome-shell/extensions
rm -r unite-shell
killall -SIGQUIT gnome-shell

## add gtk and shell themes ##
mkdir ~/.themes
cp -r flat-remix-gnome/Flat-Remix-Blue-Dark-fullPanel ~/.themes
cp -r Flat-Remix-GTK/Flat-Remix-GTK-Blue-Darker ~/.themes
rm -rf Flat-Remix-GTK flat-remix-gnome

## update system ##
sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y

## set favorite bar ##
dconf write /org/gnome/shell/favorite-apps "['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'com.valvesoftware.Steam.desktop', 'com.stremio.Stremio.desktop', 'com.discordapp.Discord.desktop', 'code_code.desktop']"

## set wallpaper ##
#gsettings set org.gnome.desktop.background picture-uri 'Amazon-Wallpaper-48-images-on-Genchi.info.jpg'
#rm Amazon-Wallpaper-48-images-on-Genchi.info.jpg

## set gnome extensions ##
firefox https://raw.githubusercontent.com/hardpixel/unite-shell/master/settings.png &

## manual settings ##
gnome-tweaks
gnome-control-center

## done ##
echo "Done!"
