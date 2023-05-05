+++
title = "Requirements and setup"
+++

- Colorlight i5
- Suppor    t board
- Computer with Ethernet and USB and admin access with OSS-CAD installed

## Boards

They will be given to you at the session or before if you want to start playing with it (don't break it!)

## Computer setup

You need a few things installed on your computer BEFORE THE CLASS:

- OSS-CAD
- Yosys
- A text editor you love and trust and are comfortable with

And you need to be able to setup your own networks (so no work locked computers) and install software from the internet (so no parental lock or other insanities).

Make sure you don't try it for the first time on the day of the class, you will be unhappy and we will be as well.

### Linux
{{% notice style="primary" title="Attention" icon="skull-crossbones" %}}
You need to have **cURL**, **git** and other build tools installed. 
On ubuntu, those with:
```shell
apt-get install build-essential curl
```
{{% /notice %}}


Go to 
https://github.com/YosysHQ/oss-cad-suite-build/releases/tag/2023-05-05
and get the one for your platform, put it in /tmp

For example on x64, assuming you want to install in your home directory, it will decompress in ~/oss-cad-suite

This is assumed you will run all those commands in the same terminal.

```shell
export DOWNLOADS_PATH=$HOME/Downloads
export INSTALL_PATH=$HOME
curl -L -o"$DOWNLOADS_PATH"/oss-cad-suite.tgz https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2023-05-05/oss-cad-suite-linux-x64-20230505.tgz
tar -xzf "$DOWNLOADS_PATH"/oss-cad-suite.tgz --directory "$INSTALL_PATH"
source "$INSTALL_PATH"/environment
```

{{% notice style="primary" title="Attention" icon="skull-crossbones" %}}
Currently, the Python distributed with oss-cad doesn't have the right version of pip
and remove the installed migen reference that conflicts with the one we will use for LiteX

MAKE SURE YOU RUN THE FOLLOWING COMMANDS
{{% /notice %}}

```shell
cd ~/oss-cad-suite
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
cd ~/oss-cad-suite
mkdir -p litex
cd litex
curl -olitex_setup.py https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
tabbypy3 litex_setup.py --init --install
sudo bash -c "source ../environment ; tabbypy3 litex_setup.py --gcc=riscv"
- [ ] tabbypip3 install meson ninja
```
#### Testing it
```
cd ~/oss-cad-suite
mkdir -p projects
cd projects
git clone https://github.com/bjonnh/alscope
tabbypy3 ./main.py --ip-address=10.0.0.42 --build
```

If this failed you may not have enough memory to build FPGA programs… Or something failed during the installation

#### Usage
Now, anytime you need to use OSS-CAD:
```shell
# Adapt that if you decided to change INSTALL_PATH obviously
source ~/oss-cad-suite/environment
```
This is all you need, any time you want to do something based on LiteX remember you have to use tabbypy3 and not python3 so you use the version that is packaged with oss-cad not the one from your OS.

### MacOS
### Windows
Poor you, this is probably the most complicated OS to use for all of that.
