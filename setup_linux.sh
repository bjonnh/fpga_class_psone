#!/usr/bin/env bash
#
set -e

. /etc/os-release

case "$ID" in
  ubuntu) echo 'This is Ubuntu Linux, I can work with that' ;;
       *) echo 'Sorry this will only work on Ubuntu, but I would appreciate your help adapting it'; exit 1 ;;
esac


echo "This is going to download a lot of things from the internet and run things for you"
echo "If you are not ready for that, just exit (ctrl+c) and do it yourself following"
echo "the manual instructions"
read a

export DOWNLOADS_PATH=$HOME/Downloads
export INSTALL_PATH=$HOME
export RELEASE_PATH=https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2023-05-20/oss-cad-suite-linux-x64-20230520.tgz


sudo apt-get install -y build-essential curl git libhidapi-hidraw0
sudo usermod -a -G dialout,plugdev $(whoami)
if [ ! -f /.dockerenv ]; then
    sudo curl -o /etc/udev/rules.d/99-openfpgaloader.rules https://raw.githubusercontent.com/trabucayre/openFPGALoader/master/99-openfpgaloader.rules
    sudo udevadm control --reload-rules && sudo udevadm trigger # force udev to take new rule
fi
echo "Your system is now setup and we can install the FPGA specific software"

mkdir -p "$DOWNLOADS_PATH"
curl -L -o"$DOWNLOADS_PATH"/oss-cad-suite.tgz https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2023-05-20/oss-cad-suite-linux-x64-20230520.tgz
tar -xzf "$DOWNLOADS_PATH"/oss-cad-suite.tgz --directory "$INSTALL_PATH"
cd "$INSTALL_PATH"/oss-cad-suite
source environment

python3 -m pip install --upgrade pip
rm -rf lib/python3.*/site-packages/migen.egg-link

mkdir -p litex
cd litex
curl -olitex_setup.py https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
python3 litex_setup.py --init
cd litex
# We need to do that as litex is currently broken
git checkout 53a0bc92e459ad440ae1a9fb9f6f24c600f658d6
cd ..
python3 litex_setup.py --install

echo "Everything is installed we can now test"

cd "$INSTALL_PATH"/oss-cad-suite
mkdir -p projects
cd projects
git clone https://github.com/bjonnh/alscope
cd alscope
python3 ./main.py --ip-address=10.0.0.42 --build
