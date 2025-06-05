# fprime-featherm4-freertos-reference

## Overview

Welcome to fprime-featherm4-freertos-reference, a repository that contains a complete FSW reference for a system that uses the <a href="https://fprime.jpl.nasa.gov/">F' Flight Software Framework</a> on a featherM4 board with the <a href="https://www.freertos.org/">FreeRTOS</a> open-source RTOS for microcontrollers and small microprocessors. This repository is designed to be paired with platform, board, and OS specific repositories to build F' systems. Some additional details can be found in the READMEs for other relevant repositories for the featherm4-freertos platform which are shown below.

- fprime-featherm4-freertos-reference (this repository) - an example of a basic build using a specific platform
    - <a href="https://github.com/laboratory10/fprime-featherm4-freertos">fprime-featherm4-freertos</a> - a platform repository which is defined by a combination of board and OS
        - <a href="https://github.com/fprime-community/fprime-arduino">fprime-arduino</a> - board-specific platform/toolchain/driver files
        - <a href="https://github.com/laboratory10/fprime-freertos">fprime-freertos</a> - a port connecting the F' OSAL to FreeRTOS
 
This reference deployment was developed using a Windows machine and the ATSAMD51J19 (specifically, the <a href="https://www.adafruit.com/product/3857">Adafruit Feather M4</a>). The rest of this README will provide detailed setup instructions that should take you from nothing to executing commands with FSW running on your target. Before proceeding, make sure the correct version of fprime (as well as fprime-tools and fprime-bootstrap) and all of the system requirements are met by following the instructions specified on the <a href="https://fprime.jpl.nasa.gov/latest/docs/getting-started/installing-fprime/">Installing F'</a> page or by using the following steps as a guide:

- F' requires Linux, macOS, or WSL on Windows. Here are the details on how I setup my WSL on Windows environment with F'
    - Open PowerShell in administrator mode
    - Run PowerShell command to install WSL 
        ```sh
        wsl --install
        ```
    - Restart machine
    - Open PowerShell in administrator mode
    - Run PowerShell command to configure WSL
        ```sh
        wsl --set-default-version 1
        ```
        - If you get an error message stating WSL 1 isn’t supported, go to Control Panel -> Programs -> Programs and Features -> Turn Windows Features on or off -> Select box for WSL -> Press Ok -> restart -> rerun set default command above
    - Run WSL and get Linux terminal
    - Run Linux command 
        ```sh
        sudo apt update && sudo apt upgrade
        ```
    - Run Linux command to install git
        ```sh 
        sudo apt install git
        ```
    - Run Linux command to install cmake
        ```sh
        sudo apt install cmake
        ```
    - Run Linux command to install clang
        ```sh
        sudo apt install clang
        ```
    - Run Linux command and ensure python version 3.8+ is installed
        ```sh
        python3 --version
        ```
    - Run Linux command to install pip
        ```sh
        sudo apt install python3-pip
        ```
    - Run Linux command to install venv
        ```sh
        sudo apt install python3-venv
        ```
    - Create a top level directory to contain the virtual environment and F' project directories
        ```sh
        mkdir fprime_freertos_example
        ```
    - Change your working directory to the newly created top level directory
        ```sh
        cd fprime_freertos_example
        ```
    - Create a virtual environment
        ```sh
        python3 -m venv fprime-venv
        ```
    - Activate virtual environment. Note: anything done past this point needs the fprime-venv activated.
        ```sh
        . fprime-venv/bin/activate
        ```

## Section 1: Finalize Environment Setup and Package Installation

Before continuing, F' version typically tends to matter. If you want to use a specific version of F' that is out of date try looking through the repository history for versions that should be compatible with earlier versions.

- Install fprime-tools
    ```sh
    pip install fprime-tools==3.5.1
    ```
- Install fprime-bootstrap
    ```sh
    pip install fprime-bootstrap==1.2.1
    ```

Now, we need to make sure relevant Arduino libraries and tools are present. I chose to leverage the Arduino tools available to make it easier to interact with the board and compile/link the final binary.

- Install board packages and relevant Arduino libraries by running these terminal commands in order
    The version of arduino-cli used to develop this procedure was version 1.2.2 but newer versions should work.
    ```sh
    curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=$VIRTUAL_ENV/bin sh
    ```
    The version of arduino-cli-cmake-wrapper used to develop this procedure was version 0.2.0a1 but newer versions should work.
    ```sh
    pip install arduino-cli-cmake-wrapper
    ```
    ```sh
    arduino-cli config init
    ```
    ```sh
    arduino-cli config add board_manager.additional_urls https://adafruit.github.io/arduino-board-index/package_adafruit_index.json
    ```
    ```sh
    arduino-cli core update-index
    ```
    The version of adafruit:samd used to develop this procedure was version 1.7.16 but newer versions should work.
    ```sh
    arduino-cli core install adafruit:samd
    ```
    The version of arduino:samd used to develop this procedure was version 1.8.14 but newer versions should work.
    ```sh
    arduino-cli core install arduino:samd
    ```
    The version of Time used to develop this procedure was version 1.6.1 but newer versions should work.
    ```sh
    arduino-cli lib install Time
    ```
    The version of FreeRTOS_SAMD51 used to develop this procedure was version 1.6.1 but newer versions should work.
    ```sh
    arduino-cli lib install FreeRTOS_SAMD51
    ```

## Section 2: Clone and Build the Reference Deployment

It is finally time to clone the reference repository, make some FreeRTOS config changes, and build the binary.

- Clone the project repository
    ```sh
    fprime-bootstrap clone https://github.com/laboratory10/fprime-featherm4-freertos-reference.git
    ```
- Change current directory to the newly cloned project
    ```sh
    cd fprime-featherm4-freertos-reference
    ```
- Make FreeRTOS arduino library configuration changes
    - Open the FreeRTOSConfig.h file wherever your arduino libraries are stored. For me the filepath is /home/username/Arduino/libraries/FreeRTOS_SAMD51/src/FreeRTOSConfig.h
    - Change config_TOTAL_HEAP_SIZE to 112 KB
        ```.h
        #define configTOTAL_HEAP_SIZE			( ( size_t ) ( 112 * 1024 ) )
        ```
    - Also add the following to somewhere in the file:
        ```.h
        #define INCLUDE_xSemaphoreGetMutexHolder 1
        ```
- Generate F' build files
    ```sh
    fprime-util generate
    ```
- Build ReferenceDeployment
    ```sh
    fprime-util build
    ```
- After the build command completes, you should see the size breakdown of the memory segments of the final target image
- Confirm the binary was created in ./build-artifacts/FeatherM4_FreeRTOS/ReferenceDeployment/bin/ReferenceDeployment.elf.bin 

## Section 3: Flash the Image to the Target and Interact Using F' GDS

- Flash image to the target
    - Force the Feather M4 to enter programming mode by doing EITHER:
        - Double tap the physical reset button on the microcontroller
        - Using a serial monitor, open a connection to the board with a 1200 baud rate then immediately close it. Once programming mode is entered, it is recommended to switch the baud to 115200 immediately to prevent an inadvertent entry into programming mode.
    - Using the Windows explorer GUI or another preferred method, copy the `ReferenceDeployment.elf.bin` binary from the WSL filesystem into one directly accessible by Windows. The “Documents” folder will be used here and referenced later on during the command to flash the image.
    - Confirm the adafruit libraries required for the FeatherM4 are installed in Windows using the Arduino IDE (adafruit and arduino M0/SAMD packages). Specifically, the `bossac.exe` file is needed.
    - Determine the COM port your board is currently connected to by issuing this command in PowerShell on the Windows machine (not in the WSL terminal). To do this, you will first need to install usbipd.
        ```sh
        winget install --interactive --exact dorssel.usbipd-win
        ```
        ```sh
        usbipd list
        ```
    - Flash the image using the following PowerShell command. Be sure the COM port and filepaths for `bossac.exe` and the `ReferenceDeployment.elf.bin` binary match reality.
        ```sh
        C:\Users\<username>\AppData\Local\Arduino15\packages\adafruit\tools\bossac\1.8.0-48-gb176eee/bossac.exe -i -d --port=COM27 -U -i --offset=0x4000 -w -v C:\Users\<username>\Documents\ReferenceDeployment.elf.bin -R
        ```
    - Once flashing completes, a serial monitor of your choice can be used before continuing to confirm the target is active and writing to the serial interface.

- Interact with the target via F' Ground Data System
    - Bind and attach the target device to WSL so the serial data can be fed to the GDS using the following PowerShell command and the appropriate busid from the usbipd command above.
        ```sh
        usbipd bind --busid 1-9
        ```
        ```sh
        usbipd attach --wsl --busid 1-9
        ```
    - For this to succeed, the serial port must not be currently monitored by any other application. Once attached, Windows applications won't be able to access this COM port. If you need to detach it, you can power cycle the board or run the command `usbipd detach --busid 1-9` in PowerShell.
    - In the WSL terminal, the following two commands can be optionally used to see that the attach command was successful. It will usually be attached as ttyACM0.
        ```sh
        sudo apt install usbutils
        ```
        ```sh
        lsusb
        ```
        ```sh
        ls /dev/tty*
        ```
    - Before being able to have fprime-gds connect to the board via serial, you must update permissions (one time only)
        ```sh
        sudo usermod -a -G dialout $USER
        ```
    - Run the GDS with the following Linux command:
        ```sh
        fprime-gds -n --dictionary ./build-artifacts/FeatherM4_FreeRTOS/ReferenceDeployment/dict/ReferenceDeploymentTopologyAppDictionary.xml --communication-selection uart --uart-device /dev/ttyACM0 --uart-baud 115200
        ```
    - Navigate to <a href="http://127.0.0.1:5000">http://127.0.0.1:5000</a> in a browser or wherever the terminal output shows the GDS UI is available
    - Send a few commands and make sure event and channelized telemetry are updating
    - Congratulations, you have the F' and FreeRTOS running on a physical board!
