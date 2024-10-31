#!/usr/bin/env bash

sudo apt-get install -y meson wget build-essential ninja-build cmake-extras cmake gettext gettext-base fontconfig libfontconfig-dev libffi-dev libxml2-dev libdrm-dev libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev libpixman-1-dev libudev-dev libseat-dev seatd libxcb-dri3-dev libegl-dev libgles2 libegl1-mesa-dev glslang-tools libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev libxcb-present-dev libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev libtomlplusplus3

sudo apt-get install -y xdg-desktop-portal-wlr

# hyprwayland-scanner version 0.4.2
sudo apt-get install libpugixml-dev
git clone https://github.com/hyprwm/hyprwayland-scanner.git
cd hyprwayland-scanner/
cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build -j `nproc`
sudo cmake --install build
hyprwayland-scanner --version

# aquamarine
git clone https://github.com/hyprwm/aquamarine.git
sudo apt-get install libgbm-dev
sudo apt-get install libdisplay-info-dev
sudo apt-get install wayland-protocols
sudo apt-get install libwayland-dev
git clone https://github.com/hyprwm/hyprutils.git
cd hyprutils/
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd .. && rm -rf hyprutils && cd aquamarine
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
rm -rf aquaremarine


# xdg-desktop-portal-hyprland
sudo apt-get install libpipewire-0.3-dev
sudo apt-get install libspa-0.2-dev
git clone https://github.com/hyprwm/hyprlang.git
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build

https://github.com/Kistler-Group/sdbus-cpp.git
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release ${OTHER_CONFIG_FLAGS}
cmake --build .
sudo cmake --build . --target install

sudo apt-get install libsystemd-dev
sudo apt-get install qt6-base-dev

cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build
sudo cmake --install build



# hyprland
git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
sudo apt-get install libcairo2-dev
sudo apt-get install libpango1.0-dev libpangocairo-1.0-0
sudo apt-get install libxcursor-dev

# hyprcursor
git clone https://github.com/hyprwm/hyprcursor.git
sudo apt-get install libzip-dev
sudo apt-get install librsvg2-dev
sudo apt-get install libtomlplusplus-dev
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build

sudo apt-get install libxcb-errors-dev
make all && sudo make install
