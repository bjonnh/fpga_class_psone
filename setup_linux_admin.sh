#!/usr/bin/env bash
#
set -e

. /etc/os-release

case "$ID" in
  ubuntu) echo 'This is Ubuntu Linux, I can work with that' ;;
  debian) echo 'This is Debian Linux, I can work with that' ;;
       *) echo 'Sorry this will only work on Ubuntu, but I would appreciate your help adapting it'; exit 1 ;;
esac


apt-get install -y build-essential curl git libhidapi-hidraw0
usermod -a -G dialout,plugdev $(whoami)
# If setting up a docker container, skip the rest.
if [ ! -f /.dockerenv ]; then
    # install udev rules from https://github.com/trabucayre/openFPGALoader
    curl https://raw.githubusercontent.com/trabucayre/openFPGALoader/master/99-openfpgaloader.rules -o /etc/udev/rules.d/99-openfpgaloader.rules
    # force udev to take new rule
    udevadm control --reload-rules
    udevadm trigger
fi
echo "Your system is now setup and we can install the FPGA specific software"
echo "run ./linux_setup.sh (no sudo needed.)"
