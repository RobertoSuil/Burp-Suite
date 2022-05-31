# Name is Important
echo "
                     #####  #     #  #####  #     # #     # 
                    #     # ##    # #     # #  #  # ##    # 
                    #       # #   # #       #  #  # # #   # 
                     #####  #  #  # #  #### #  #  # #  #  # 
                          # #   # # #     # #  #  # #   # # 
                    #     # #    ## #     # #  #  # #    ## 
                     #####  #     #  #####   ## ##  #     # 
"

# Downloading and Installing Necessary Files
echo "`t`tDownnloading Java JDK-18 ...."
wget "https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.exe" -O jdk-18.exe
echo "`n`t`tJDK-18 Downloaded, lets start the Installation process"
start -wait jdk-18.exe
echo "`n`t`tDownloading Java JRE ...."
wget "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=246474_2dee051a5d0647d5be72a7c0abff270e" -O jre-8.exe
echo "`n`t`tJRE-8 Downloaded, lets start the Installation process"
start -wait jre-8.exe
echo "`n`t`tDownloading Latest Burp Suite Professional ...."
wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=&type=jar" -O Burp-Suite-Pro.jar


# Creating Burp.bat file with command for execution
if (Test-Path burp.bat) {
    Remove-Item burp.bat }
echo "java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED -javaagent:'$pwd\loader.jar' -jar '$pwdBurp-Suite-Pro.jar'" > burp.bat


# Creating Burp-Suite-Pro.vbs File for background execution
if (Test-Path Burp-Suite-Pro.vbs) {
    Remove-Item Burp-Suite-Pro.vbs}
echo 'Set WshShell = CreateObject("WScript.Shell")' > Burp-Suite-Pro.vbs
add-content Burp-Suite-Pro.vbs "WshShell.Run chr(34) & '$pwd/burp.bat' & Chr(34), 0"
add-content Burp-Suite-Pro.vbs 'Set WshShell = Nothing'


# Lets Activate Burp Suite Professional with keygenerator and Keyloader
start-process java.exe -argumentlist "-jar keygen.jar"
java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED -javaagent:"loader.jar" -jar "Burp-Suite-Pro.jar"
