rp_module_id="turbografx16"
rp_module_desc="TurboGrafx 16 LibretroCore"
rp_module_menus="2+"

function sources_turbografx16() {
    gitPullOrClone "$rootdir/emulatorcores/mednafen-pce-libretro/" https://github.com/petrockblog/mednafen-pce-libretro.git
}

function build_turbografx16() {
    pushd "$rootdir/emulatorcores/mednafen-pce-libretro/"
    make clean
    make
    if [[ ! -f `find $rootdir/emulatorcores/mednafen-pce-libretro/ -name "*libretro*.so"` ]]; then
        __ERRMSGS="$__ERRMSGS Could not successfully compile PC Engine core."
    fi
    popd
}

function configure_turbografx16() {
    mkdir -p $romdir/pcengine-libretro

    rps_retronet_prepareConfig
    setESSystem "TurboGrafx 16 (PC Engine)" "pcengine-libretro" "~/RetroPie/roms/pcengine-libretro" ".pce .PCE" "$rootdir/supplementary/runcommand/runcommand.sh 1 \"$rootdir/emulators/RetroArch/installdir/bin/retroarch -L `find $rootdir/emulatorcores/mednafen-pce-libretro/ -name \"*libretro*.so\" | head -1` --config $rootdir/configs/all/retroarch.cfg --appendconfig $rootdir/configs/pcengine/retroarch.cfg %ROM%\"" "pcengine" "pcengine"
}