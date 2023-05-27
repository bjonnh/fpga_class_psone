+++
title = "Linux setup (recommended)"
weight = 1
+++

## Computer setup

You need a few things installed on your computer BEFORE THE CLASS:

- OSS-CAD
- Yosys
- A text editor you love and trust and are comfortable with

And you need to be able to setup your own networks (so no work locked computers) and install software from the internet (so no parental lock or other insanities).

Make sure you don't try it for the first time on the day of the class, you will be unhappy and we will be as well.

### Scripted installation on Debian/Ubuntu

```shell
wget -N  https://raw.githubusercontent.com/bjonnh/fpga_class_psone/main/setup_linux_admin.sh
sudo ./setup_linux_admin.sh
# You will have to logout and login to get the new group pemissions.
wget -N  https://raw.githubusercontent.com/bjonnh/fpga_class_psone/main/setup_linux.sh
./setup_linux.sh
```

(Obviously you need curl installed and your user will need to be able to sudo)

### Fast installation on other distros

You can follow most of the commands from:
https://raw.githubusercontent.com/bjonnh/fpga_class_psone/main/setup_linux.sh

Just replace apt/apt-get by what you use.

### Linux details (useful only if you have issues or another distro)
{{% notice style="primary" title="Attention" icon="skull-crossbones" %}}
You need to have **cURL**, **git** and other build tools installed.
And you need to be a member of the dialout group to be able to access the programmer serial port.
On ubuntu, those with:
```shell
sudo apt-get install build-essential curl git libhidapi-hidraw0
sudo usermod -a -G dialout,plugdev $USER
sudo curl -o /etc/udev/rules.d/99-openfpgaloader.rules https://raw.githubusercontent.com/trabucayre/openFPGALoader/master/99-openfpgaloader.rules
sudo udevadm control --reload-rules && sudo udevadm trigger # force udev to take new rule
# You will have to logout and login again
```
{{% /notice %}}


Go to
https://github.com/YosysHQ/oss-cad-suite-build/releases/tag/2023-05-05
and get the one for your platform, put it in /tmp

For example on x64, assuming you want to install in your home directory, it will decompress in ~/oss-cad-suite

This is assuming you will run all those commands in the same terminal.

```shell
# You can customize those, but you are responsible to change them when necessary
export DOWNLOADS_PATH=$HOME/Downloads
export INSTALL_PATH=$HOME

mkdir -p "$DOWNLOADS_PATH"
curl -L -o"$DOWNLOADS_PATH"/oss-cad-suite.tgz https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2023-05-20/oss-cad-suite-linux-x64-20230520.tgz
tar -xzf "$DOWNLOADS_PATH"/oss-cad-suite.tgz --directory "$INSTALL_PATH"
cd "$INSTALL_PATH"/oss-cad-suite
source environment
```

{{% notice style="primary" title="Attention" icon="skull-crossbones" %}}
Currently, the Python distributed with oss-cad doesn't have the right version of pip
and remove the installed migen reference that conflicts with the one we will use for LiteX

MAKE SURE YOU RUN THE FOLLOWING COMMANDS, they work well on ubuntu, it will work ok on RedHat-like or Arch, but you will have to install the riscv toolchain yourself.
{{% /notice %}}

```shell
tabbypy3 -m pip install --upgrade pip
rm -rf lib/python3.*/site-packages/migen.egg-link
```
It will display something like:
```
Requirement already satisfied: pip in /home/you/Software/fpga/oss-cad-suite/lib/python3.8/site-packages (23.1.1)
Collecting pip
  Downloading pip-23.1.2-py3-none-any.whl (2.1 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 2.1/2.1 MB 30.4 MB/s eta 0:00:00
Installing collected packages: pip
  Attempting uninstall: pip
    Found existing installation: pip 23.1.1
    Uninstalling pip-23.1.1:
      Successfully uninstalled pip-23.1.1
Successfully installed pip-23.1.2
```

#### Install LiteX
This is really long,  please make sure you do that BEFORE the day of the class.

```shell
mkdir -p litex
cd litex
curl -olitex_setup.py https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
tabbypy3 litex_setup.py --init
cd litex
# We need to do that as litex is currently broken
git checkout 53a0bc92e459ad440ae1a9fb9f6f24c600f658d6
cd ..
tabbypy3 litex_setup.py --install
tabbypy3 litex_setup.py --gcc=riscv
```
#### Testing it
```
cd "$INSTALL_PATH"/oss-cad-suite
mkdir -p projects
cd projects
git clone https://github.com/bjonnh/alscope
cd alscope
tabbypy3 ./main.py --ip-address=10.0.0.42 --build
```

If this failed you may not have enough memory to build FPGA programs… Or something failed during the installation

#### Usage
Now, anytime you need to use OSS-CAD:
```shell
export INSTALL_PATH=$HOME
source "$INSTALL_PATH"/oss-cad-suite/environment
```
This is all you need, any time you want to do something based on LiteX remember you have to use **tabbypy3** and not python3 so you use the version that is packaged with oss-cad not the one from your OS.
