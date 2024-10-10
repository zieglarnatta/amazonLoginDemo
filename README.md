# amazonLoginDemo
This repo is for QA & SDeT automation of both the Web site and Mobile app (Android). 

Scope: Regular and headless Robot Framework-Selenium GUI automation via Firefox, and Robot Framework-Appium Android mobile app.

NOTE: Documentation is still work in progress especially the setup: Robot Framework & Appium Onboarding

Pre-requisites: Python installed https://www.python.org/downloads/ 
Check first in command line:

    python3 –version

Pip installer installed https://pip.pypa.io/en/stable/installation/ 
Check first in command line:

    pip3 –version

Or via command line:

    sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py

Home Brew version control installed 

https://docs.brew.sh/Installation

NPM installed 
https://docs.npmjs.com/downloading-and-installing-node-js-and-npm

    node -v
    npm -v
    npm install -g npm

Node JS https://nodejs.org/en

Robot Framework installed: 
https://robotframework.org/ https://pypi.org/project/robotframework/

    pip3 install robotframework


============================

Selenium Specific setup:

    pip3 install selenium

Install gecko driver
    pip install geckodriver-autoinstaller






============================

Appium specific setup & installs:

Robot-Appium installed https://docs.robotframework.org/docs/different_libraries/appium

    pip3 install robotframework-appiumlibrary


Android Studio: https://developer.android.com/studio

https://appium.readthedocs.io/en/latest/en/about-appium/getting-started/

https://appium.io/docs/en/latest/quickstart/requirements/


Ensure JDK (Java Development Kit) is installed: 

https://openjdk.org/install/


Set up Paths & Environment Variables (MacOS) 

https://techpp.com/2021/09/08/set-path-variable-in-macos-guide/

Launch the command line editor nano to edit the z shell RC (Catalina & later)

    nano ~/.zshrc  
else

    nano ~/.zsh_profile
In the nano, copy & paste the following, substituting your computer name in the path:

    export PATH=$PATH:/Users/<yourComputerName>/Library/Python/3.9/bin
    export PATH=$PATH:/Users/<yourComputerName>/workspace/jdk-22.jdk/Contents/Home
    export ANDROID_HOME=/Users/<yourComputerName>/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/platform-tools
    export JAVA_HOME=/Users/<yourComputerName>/workspace/jdk-22.jdk/Contents/Home
    export PATH=$PATH:/Users/<yourComputerName>/Library/Android/sdk/tools/bin/uiautomatorviewer
    export ANDROID_SWT=/Users/<yourComputerName>/Library/Android/sdk/tools/lib/x86_64
Fire up the Appium Server:

    appium -p 4726 --base-path /wd/hub --allow-cors


Install the Appium Inspector

https://github.com/appium/appium-inspector

You will see the needed information in the startup of the Appium server. Grab those details

