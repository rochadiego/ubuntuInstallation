#!/bin/bash

## add repositories ##
sudo add-apt-repository ppa:papirus/papirus -y
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update -y

## add dev packages ##
sudo apt install git curl gdebi build-essential nodejs npm python3-pip -y
sudo apt install --no-install-recommends yarn -y

## add user packages ##
sudo apt install vlc virtualbox papirus-icon-theme transmission-gtk cheese gnome-tweaks p7zip-full p7zip-rar rar chrome-gnome-shell -y

## add pip packages ##
pip3 install virtualenv

## add snap packages ##
sudo snap install code --classic
sudo snap install spotify

## add external packages ##
wget -c 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
wget -c 'https://dl.strem.io/linux/v4.4.106/stremio_4.4.106-1_amd64.deb'
wget -c 'https://discord.com/api/download?platform=linux&format=deb'
wget -c 'https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/9719/wps-office_11.1.0.9719.XA_amd64.deb'
for app in $(ls *.deb); do
    sudo gdebi --option=APT::Get::force-yes="true" --option=APT::Get::Assume-Yes="true" -n $app
    rm $app
done

## add gnome extensions ##
firefox https://extensions.gnome.org/extension/1287/unite/
firefox https://raw.githubusercontent.com/hardpixel/unite-shell/master/settings.png
firefox https://extensions.gnome.org/extension/19/user-themes/

## add gtk and shell themes ##
git clone https://github.com/daniruiz/Flat-Remix-GTK
git clone https://github.com/daniruiz/flat-remix-gnome

cp -r Flat-Remix-GTK/Flat-Remix-GTK-Blue-Darker Flat-Remix-GTK/Flat-Remix-Blue-Dark-fullPanel .themes
gsettings set org.gnome.shell.extensions.user-theme name "Flat-Remix-GTK-Blue-Darker"
gsettings set org.gnome.shell.extensions.user-theme name "Flat-Remix-Blue-Dark-fullPanel"

## set default apps ##
gio mime x-scheme-handler/magnet transmission-gtk.desktop

## remove packages ##
sudo apt remove mpv chrome-gnome-shell -y

## update system ##
sudo apt update -y && sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y

## set favorite bar ##
dconf write /org/gnome/shell/favorite-apps "['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'spotify_spotify.desktop', 'smartcode-stremio.desktop', 'code_code.desktop', 'discord.desktop']"

## set wallpaper ##
wget -c 'https://cutewallpaper.org/21/cute-box-robot-wallpaper/Amazon-Wallpaper-48-images-on-Genchi.info.jpg'
gsettings get org.gnome.desktop.background picture-uri 'Amazon-Wallpaper-48-images-on-Genchi.info.jpg'
rm Amazon-Wallpaper-48-images-on-Genchi.info.jpg

## manual settings ##
gnome-tweaks
gnome-control-center

## done ##
echo "Done!"