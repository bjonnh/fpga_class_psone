+++
title = "MacOS setup"
weight = 1
+++

## MacOS

{{% notice style="primary" title="Attention" icon="skull-crossbones" %}}
You need to have a few tools installed. 
We are giving instructions with brew, but if you know or use anything else, feel free to send us the commands to use.
It looks like that just installing brew installs all the tools necessary.

{{% /notice %}}


Go to 
https://github.com/YosysHQ/oss-cad-suite-build/releases/tag/2023-05-05
and get the one for your platform, put it in /tmp

For example on x64, assuming you want to install in your home directory, it will decompress in ~/oss-cad-suite
(for M1 replace x64 by arm64)
This is assumed you will run all those commands in the same terminal.

```shell
# You can customize those, but you are responsible to change them when necessary
export DOWNLOADS_PATH=$HOME/Downloads
export INSTALL_PATH=$HOME
export ARCH=x64

mkdir -p "$DOWNLOADS_PATH"
curl -L -o"$DOWNLOADS_PATH"/oss-cad-suite.tgz https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2023-05-05/oss-cad-suite-darwin-$ARCH-20230505.tgz
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
tabbypy3 litex_setup.py --init
cd litex
# We need to do that as litex is currently broken
git checkout 53a0bc92e459ad440ae1a9fb9f6f24c600f658d6
cd ..
tabbypy3 litex_setup.py --install
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
