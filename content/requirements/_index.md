+++
title = "Requirements and setup"
+++

- Colorlight i5
- Support board
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
# You can customize those, but you are responsible to change them when necessary
export DOWNLOADS_PATH=$HOME/Downloads
export INSTALL_PATH=$HOME

mkdir -p "$DOWNLOADS_PATH"
curl -L -o"$DOWNLOADS_PATH"/oss-cad-suite.tgz https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2023-05-05/oss-cad-suite-linux-x64-20230505.tgz
tar -xzf "$DOWNLOADS_PATH"/oss-cad-suite.tgz --directory "$INSTALL_PATH"
cd "$INSTALL_PATH"/oss-cad-suite
source environment
```

{{% notice style="primary" title="Attention" icon="skull-crossbones" %}}
Currently, the Python distributed with oss-cad doesn't have the right version of pip
and remove the installed migen reference that conflicts with the one we will use for LiteX

MAKE SURE YOU RUN THE FOLLOWING COMMANDS
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
tabbypy3 litex_setup.py --init --install
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

### MacOS

### Windows

{{% notice style="info" title="Windows doesn't have everything" icon="radiation" %}}
Certain tools like VHDL synthesis with GHDL only work on Linux and Mac, making you virtually only able to use Verilog or LiteX on windows unless you use WSL2 or a VM. 
Making USB Jtag devices can also be somewhat tricky.
{{% /notice %}}



You need to install Git: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
(Looks like setting everything to the default except perhaps the editor is your best bet here).

Go to https://github.com/YosysHQ/oss-cad-suite-build/releases/tag/2023-05-05

And download the exe for Windows.

Run it. It will decompress … somewhere… And you can move it where you want it.
Once you are happy with that, open a powershell. Go to that directory and type
```text
./start.bat
python3 -m pip install --upgrade pip
del .\lib\python3.8\site-packages\migen.egg-link
mkdir litex
cd litex
curl -olitex_setup.py https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py # This is a single line starting with curl
python3 litex_setup.py --init --install
cd ..
mkdir projects
cd projects
git clone https://github.com/bjonnh/alscope
cd alscope
python3 ./main.py --ip-address=10.0.0.42 --build
```

#### JTAG programmer drivers

Windows is dumb with regard to drivers. You need to use a WinUSB driver for JTAG programmers (at least that's the case with my DirtyJtag).

Follow the instructions at: https://learn.microsoft.com/en-us/windows-hardware/drivers/usbcon/winusb-installation

### VM using VirtualBox
What we highly recommend for Windows and Mac users is to install a Ubuntu virtual machine, follow the Linux instructions and share the USB device with the VM.

We may be distributing a VM image that has everything preinstalled if we have time to go throught it.

Go to the settings of the VM, Ports, USB and add the device JTAG device.

