#!/bin/bash
if [[ $EUID -eq 0 ]]; then
    mkdir Burp_Suite_Pro
    chown $whoami Burp_Suite_Pro
    cd Burp_Suite_Pro

    # Check for Latest Version
    echo "Checking Latest Burp Professional Version"
    wget https://portswigger.net/burp/releases/professional/latest -O Page -b
    latest_burp=$(less Page|grep '<meta property="og:url" content="' |cut -d '"' -f 4)
    rm Page
    sleep 1
    clear
    wget $latest_burp -O Page -b
    version=$(less Page|grep 'version=' |cut -d '=' -f 5|cut -d '&' -f 1|head -1)
    rm page
    sleep 1
    clear
    
    # Download Burp Suite Profesional Latet Version
    echo "Downloading Burp Suite Professional ...."
    Link="https://portswigger-cdn.net/burp/releases/download?product=pro&version=$version&type=jar"
    wget "$Link" -O Burp_Suite_Pro.jar
    clear
    
    # Get Keygenerator and Keyloader files
    echo "Downloading Keygenerator and Keyloader Files"
    git clone https://github.com/SNGWN/Burp-Suite.git
    mv Burp-Suite/* .
    sleep 1
    
    clear

    # execute Keygenerator
    echo "Starting Keygenerator"
    (java -jar keygen.jar) &
    sleep 5s
    
    # Execute Burp Suite Professional with Keyloader
    echo "Executing Burp Suite Professional with Keyloader"
    echo "java --illegal-access=permit -Dfile.encoding=utf-8 -javaagent:$(pwd)/loader.jar -noverify -jar $(pwd)/Burp_Suite_Pro.jar &" > burp
    chmod +x burp
    cp burp /bin/burp 
    (./burp)
else
    echo "Execute Command as Root User"
    exit
fi

