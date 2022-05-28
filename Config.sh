!/bin/bash
if [[ $EUID -ne 0 ]]; then
    mkdir Burp_Suite_Pro
    cd Burp_Suite_Pro
    # Check for Latest Version
    echo -e "\e[1;31mChecking Latest Burp Professional Version"
    wget https://portswigger.net/burp/releases/professional/latest
    latest_burp=$(less latest|grep '<meta property="og:url" content="' |cut -d '"' -f 4)
    rm latest
    clear
    wget $latest_burp -O burp.txt
    version=$(less burp.txt|grep 'version=' |cut -d '=' -f 5|cut -d '&' -f 1|head -1)
    rm burp.txt
    clear
    
    # Download Burp Suite Profesional Latet Version
    echo -e "\e[1;31mDownloading Burp Suite Professional ...."
    Link="https://portswigger-cdn.net/burp/releases/download?product=pro&version=$version&type=jar"
    wget "$Link" -O Burp_Suite_Pro.jar
    clear
    
    # Get Keygenerator and Keyloader files
    echo -e "\e[1;31mDownloading Keygenerator and Keyloader Files"
    git clone https://github.com/SNGWN/Burp-Suite.git
    mv Burp-Suite/* .
    
    echo ""
    echo ""
    
    # execute Keygenerator
    echo -e "\e[1;31mStarting Keygenrator"
    echo ""
    (java -jar keygen.jar) &
    
    # Execute Burp Suite Professional with Keyloader
    echo -e "\e[1;31mExecuting Burp Suite Professional with Keyloader"
    echo ""
    echo "java --illegal-access=permit -Dfile.encoding=utf-8 -javaagent:$(pwd)/loader.jar -noverify -jar $(pwd)/Burp_Suite_Pro.jar &" > burp
    #chmod +x burp
    cp burp /bin/burp
    (./burp)
else
    echo -e "\e[1;31mExecute Command as Root User"
    exit
fi

