rp_module_id="vice"
rp_module_desc="C64 emulator VICE"
rp_module_menus="2+"

function sources_vice() {
    rmDirExists "$rootdir/emulators/vice-2.4"
    mkdir -p "$rootdir/emulators"
    wget -O vice-2.4.tar.gz http://downloads.petrockblock.com/retropiearchives/vice-2.4.tar.gz
    tar xzvf vice-2.4.tar.gz -C "$rootdir/emulators/"
    rm vice-2.4.tar.gz
}

function build_vice() {
    if dpkg-query -Wf'${db:Status-abbrev}' vice 2>/dev/null | grep -q '^i'; then
        printf 'Package vice is already installed - removing package\n' "${1}"
        apt-get remove -y vice
    fi
    echo 'deb-src http://mirrordirector.raspbian.org/raspbian/ wheezy main contrib non-free rpi' >> /etc/apt/sources.list
    aptInstall libxaw7-dev automake checkinstall
    pushd "$rootdir/emulators/vice-2.4"
    ./configure --prefix="$rootdir/emulators/vice-2.4/installdir" --enable-sdlui --without-pulse --with-sdlsound
    make
    popd
}

function install_vice() {
    pushd "$rootdir/emulators/vice-2.4"
    make install
    popd
}

function configure_vice() {
    mkdir -p "$romdir/c64"

    setESSystem "C64" "c64" "~/RetroPie/roms/c64" ".crt .CRT .d64 .D64 .g64 .G64 .t64 .T64 .tap .TAP .x64 .X64 .zip .ZIP" "$rootdir/supplementary/runcommand/runcommand.sh 4 \"$rootdir/emulators/vice-2.4/installdir/bin/x64 -sdlbitdepth 16 %ROM%\"" "c64" "c64"

}