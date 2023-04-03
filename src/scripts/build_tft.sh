mkdir -p tft_export
CFG_ROOT="."

# SCRIPTS
cp $CFG_ROOT/flake* tft_export/
cp $CFG_ROOT/exports/conn.sh tft_export/
cp $CFG_ROOT/build.sh tft_export/
cp $CFG_ROOT/build_no_inet.sh tft_export/
# SHELLS AND ENVIRONMENTS
mkdir -p tft_export/environments/python/base
cp $CFG_ROOT/environments/python/base/shell.nix tft_export/environments/python/base/shell.nix
# MODULES
cp -r $CFG_ROOT/networking tft_export
mkdir -p tft_export/modules
cp -r $CFG_ROOT/modules/hardware tft_export/modules
cp -r $CFG_ROOT/modules/sys-utils tft_export/modules
cp -r $CFG_ROOT/modules/terminal tft_export/modules
cp -r $CFG_ROOT/modules/desktop tft_export/modules
# HOST
mkdir -p tft_export/hosts/tft/
cp $CFG_ROOT/hosts/configuration.nix tft_export/hosts/configuration.nix
cp $CFG_ROOT/hosts/default.nix tft_export/hosts/default.nix
cp -r $CFG_ROOT/hosts/tft tft_export/hosts
./rm_md.sh tft_export
