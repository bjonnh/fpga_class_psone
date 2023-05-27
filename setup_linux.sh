#!/usr/bin/env bash
#
set -e

. /etc/os-release

case "$ID" in
  ubuntu) echo 'This is Ubuntu Linux, I can work with that' ;;
  debian) echo 'This is Debian Linux, I can work with that' ;;
  pop) echo 'This is Pop Linux, Pop Goes the World!' ;;
       *) echo 'Sorry this will only just work on things we have tested, but I would appreciate your help adapting it'; exit 1 ;;
esac

# check to see if user is in the dialout group,
if  groups | grep -qw dialout
then
    echo "user is in dialout group"
else
    echo "user is not in dialout group"
    echo "did you run linux_setup_admin.sh and logout and in again?"
fi

# check to see if user is in the plugdev group,
if  groups | grep -qw plugdev
then
    echo "user is in plugdev group"
else
    echo "user is not in plugdev group"
    echo "did you run linux_setup_admin.sh and logout and in again?"
fi

echo "This is going to download a lot of things from the internet and run things for you"
echo "If you are not ready for that, just exit (ctrl+c) and do it yourself following"
echo "the manual instructions"
echo "I will wait 10 seconds for you to stop me"
sleep 10

export DOWNLOADS_PATH=$HOME/Downloads
export INSTALL_PATH=$HOME

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
python3 litex_setup.py --install

echo "Everything is installed we can now test"

cd "$INSTALL_PATH"/oss-cad-suite
mkdir -p projects
cd projects
git clone https://github.com/bjonnh/alscope
cd alscope
python3 ./main.py --ip-address=10.0.0.42 --build
