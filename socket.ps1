$FTPServer = '192.168.0.133';
$FTPPort = '7676';

$tcpConnection = New-Object System.Net.Sockets.TcpClient($FTPServer, $FTPPort);
$tcpStream = $tcpConnection.GetStream();
$reader = New-Object System.IO.StreamReader($tcpStream);
$writer = New-Object System.IO.StreamWriter($tcpStream);
$writer.AutoFlush = $true;
$inputCounter = 0;
$outputCounter = 0;
$buffer = new-object System.Byte[] 1024;
$encoding = new-object System.Text.AsciiEncoding;


while ($tcpConnection.Connected) {
    while ($tcpStream.DataAvailable -or $reader.Peek() -ne -1 ) {   
        $path = -join('C:\Program Files\AAA\input', $inputCounter,'.txt');
        Set-Content -Path $path -Value $reader.ReadLine();
        $inputCounter+=1;
    };


    $pathOutput = -join('C:\Program Files\AAA\output',$outputCounter,'.txt');
    if(Test-Path $pathOutput){
        $output = Get-Content $pathOutput;
        if($output.length -ge 1){
            Foreach($s in $output){
                $writer.WriteLine($s);
            };  
        };
        $outputCounter+=1;
        Remove-Item $pathOutput;
    };

    start-sleep -Milliseconds 120;
};

$reader.Close();
$writer.Close();
$tcpConnection.Close();