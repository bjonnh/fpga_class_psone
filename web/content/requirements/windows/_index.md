+++
title = "Windows setup"
+++

## Computer setup

You need a few things installed on your computer BEFORE THE CLASS:

- OSS-CAD
- Yosys
- A text editor you love and trust and are comfortable with

And you need to be able to setup your own networks (so no work locked computers) and install software from the internet (so no parental lock or other insanities).

Make sure you don't try it for the first time on the day of the class, you will be unhappy and we will be as well.

### Install on Windows
(This has only been tried on Windows 11 so far)

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

