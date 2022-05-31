# Downloading and Installing Necessary Files
echo "Downnloading Java JDK-18 ...."
wget "https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.exe" -O jdk-18.exe
echo "JDK-18 Downloaded, lets start the Installation process"
start -wait jdk-18.exe
echo "Downloading Java JRE ...."
wget "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=246474_2dee051a5d0647d5be72a7c0abff270e" -O jre-8.exe
echo "JRE-8 Downloaded, lets start the Installation process"
start -wait jre-8.exe
echo "Downloading Latest Burp Suite Professional ...."
wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=&type=jar" -O Burp-Suite-Pro.jar


# Lets Create a bat file for execution and VBS File to hide CMD from Background while running Burp
new-item -path $pwd -name burp.bat
add-content burp.bat 'java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED -javaagent:"' --NoNewline
add-content burp.bat $pwd'\loader.jar"' -NoNewline
add-content burp.bat '-jar "' -NoNewline
add-content burp.bat $pwd'Burp-Suite-Pro.jar"'
new-item -path $pwd -name Burp-Suite-Pro.vbs 
add-content Burp-Suite-Pro.vbs 'Set WshShell = CreateObject("WScript.Shell")'
add-content Burp-Suite-Pro.vbs "WshShell.Run chr(34) & '" -NoNewline
add-content Burp-Suite-Pro.vbs $pwd"/burp.bat' & Chr(34), 0"
add-content Burp-Suite-Pro.vbs 'Set WshShell = Nothing'


# Lets create Start menu Entry
new-item -path $pwd -name createshortcut.vbs
add-content createshortcut.vbs "$TargetFile = '" -NoNewline
add-content createshortcut.vbs $pwd"\Burp-Suite-Pro.vbs'"
add-content createshortcut.vbs "$ShortcutFile = '" -NoNewline
add-content createshortcut.vbs $home"\Desktop\Burp-Suite-Pro.lnk'"
add-content createshortcut.vbs '$WScriptShell = New-Object -ComObject WScript.Shell'
add-content createshortcut.vbs '$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)'
add-content createshortcut.vbs '$Shortcut.TargetPath = $TargetFile'
add-content createshortcut.vbs '$Shortcut.Save()'
copy $home\Desktop\Burp-Suite-Pro.lnk 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Burp-Suite.lnk'


# Lets Activate Burp Suite Professional with keygenerator and Keyloader
start-process java.exe -argumentlist "-jar keygen.jar"
java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED -javaagent:"loader.jar" -jar "Burp-Suite-Pro.jar"
