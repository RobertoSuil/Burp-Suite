# Name is Important
echo "
                #####    #     #    #####    #     #   #     # 
               #     #   ##    #   #     #   #     #   ##    # 
               #         # #   #   #         #     #   # #   # 
                #####    #  #  #   #  ####   #  #  #   #  #  # 
                     #   #   # #   #     #   #  #  #   #   # # 
               #     #   #    ##   #     #   #  #  #   #    ## 
                #####    #     #    #####     ## ##    #     # 
"

# Set Wget Progress to Silent, Becuase it slows down Downloading by 50x
echo "Setting Wget Progress to Silent, Becuase it slows down Downloading by 50x"
$ProgressPreference = 'SilentlyContinue'

# Check JDK-18 Availability or Download JDK-18
if (!(Get-WmiObject -Class Win32_Product -filter "Vendor='Oracle Corporation'" |where Caption -clike "Java(TM) SE Development Kit 18*")){
    echo "`t`tDownnloading Java JDK-18 ...."
    wget "https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.exe" -O jdk-18.exe    
    echo "`n`t`tJDK-18 Downloaded, lets start the Installation process"
    start -wait jdk-18.exe
    rm jdk-18.exe
}else{
    echo "Required JDK-18 is Installed"
    Get-WmiObject -Class Win32_Product -filter "Vendor='Oracle Corporation'" |where Caption -clike "Java(TM) SE Development Kit 18*"
}

# Check JRE-8 Availability or Download JRE-8
if (!(Get-WmiObject -Class Win32_Product -filter "Vendor='Oracle Corporation'" |where Caption -clike "Java 8 Update *")){
    echo "`n`t`tDownloading Java JRE ...."
    wget "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=246474_2dee051a5d0647d5be72a7c0abff270e" -O jre-8.exe
    echo "`n`t`tJRE-8 Downloaded, lets start the Installation process"
    start -wait jre-8.exe
    rm jre-8.exe
}else{
    echo "`n`nRequired JRE-8 is Installed`n"
    Get-WmiObject -Class Win32_Product -filter "Vendor='Oracle Corporation'" |where Caption -clike "Java 8 Update *"
}

# Downloading Burp Suite Professional
if (Test-Path Burp-Suite-Pro.jar){
    echo "Burp Suite Professional JAR file is available.`nChecking its Integrity ...."
    if (((Get-Item Burp-Suite-Pro.jar).length/1MB) -lt 500 ){
        echo "`n`t`tFiles Seems to be corrupted `n`t`tDownloading Latest Burp Suite Professional ...."
        wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=&type=jar" -O "Burp-Suite-Pro.jar"
        echo "Burp Suite Professional is Downloaded.`n"
    }else {echo "File Looks fine. Lets proceed for Execution"}
}else {
    echo "`n`t`tDownloading Latest Burp Suite Professional ...."
    wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=&type=jar" -O Burp-Suite-Pro.jar
    echo "Burp Suite Professional is Downloaded.`n"
}



# Creating Burp.bat file with command for execution
if (Test-Path burp.bat) {
   Remove-Item burp.bat }
echo "java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED -javaagent:'$pwd\loader.jar' -noverify -jar '$pwd\Burp-Suite-Pro.jar'" > Burp.bat
echo "Burp.bat file is created`n"


# Creating Burp-Suite-Pro.vbs File for background execution
if (Test-Path Burp-Suite-Pro.vbs) {
   Remove-Item Burp-Suite-Pro.vbs}
echo 'Set WshShell = CreateObject("WScript.Shell")' > Burp-Suite-Pro.vbs
add-content Burp-Suite-Pro.vbs "WshShell.Run chr(34) & '$pwd\Burp.bat' & Chr(34), 0"
add-content Burp-Suite-Pro.vbs 'Set WshShell = Nothing'
echo "Burp-Suite-Pro.vbs file is created.`n"

# Lets Activate Burp Suite Professional with keygenerator and Keyloader
echo "`n`nStarting Keygenerator ...."
start-process java.exe -argumentlist "-jar keygen.jar"
echo "`n`nStarting Burp Suite Professional"
java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED -javaagent:"loader.jar" -noverify -jar "Burp-Suite-Pro.jar"
