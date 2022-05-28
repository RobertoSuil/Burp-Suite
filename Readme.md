--------------------------------------------------------------------------------------------
				**Prequisites**
	Download .jar file for Burp Suite Pro from**
		https://portswigger-cdn.net/burp/releases/download?product=pro&version=&type=jar
		
	If using in Windows OS, Download and Install Java and JDK**
		For Java --> https://javadl.oracle.com/webapps/download/AutoDL?BundleId=244068_89d678f2be164786b292527658ca1605
		For JDK  --> https://www.oracle.com/in/java/technologies/javase-jdk15-downloads.html


--------------------------------------------------------------------------------------------
				**Windows Burp Suite Professional Installation**
	1. Place all files in 1 folder**
		For Example lets take as --> C:\Users\Siddharth\Downloads\burp-suite\
	2 Run This Command for Windows in CMD Prompt.
		java --illegal-access=permit -Dfile.encoding=utf-8 -javaagent:"C:\Users\siddh\Downloads\burp-suite\loader.jar" -noverify -jar "C:\Users\Siddharth\Downloads\Burp-Suite\Burp-Suite-Pro.jar"
	3. Use keygen.jar to generate the License key
		java -jar keygen.jar
	4 For Windows Follow These Steps
		1. Open Notepad and Paste command at 2.1 and save the file with name burp.bat in C:\Users\Siddharth\Downloads\burp-suite\   Folder.
		2. Open another Notepad and Paste below command and save it with burp.VBS extension in Desktop.
			Set WshShell = CreateObject("WScript.Shell")
			WshShell.Run chr(34) & "C:\Users\Siddharth\Downloads\burp-suite\burp.bat" & Chr(34), 0
			Set WshShell = Nothing
	5 For Executing Burp Suite Pro, Double Click on burp.VBS file.		


--------------------------------------------------------------------------------------------
				**Kali-Linux** 
	--> Execute Kali_Linux_Setup.sh file as root user


--------------------------------------------------------------------------------------------
				**Activate Burp Suite Pro** 
	1. Modify License String like "license to Siddharth"
	2. Copy License key from keygen.jar and paste in Burp Suite Pro and click Next.
	3. Select Manual Activation Option on your bottom Right in Burp Suite Pro.
	4. Copy License Request from BurpSuite_Pro and paste in Keygenerator.
	5. Copy license response from Keygenerator and paste in Burp Suite Pro, then next and Done.
