$counterInput = 0;
$counterOutput = 0;

while (1) {
    $path = -join('C:\input',$counterInput, '.txt');
    
    $input = Get-Content $path;
    if($input.length -ge 1){
        $outputPath = -join('C:\output', $counterOutput, '.txt');

        Write-Host $input;   
        $command = Get-Content $path;
        $output = Invoke-Expression $command;
        Foreach($s in $output){
            Add-Content -Path $outputPath -Value $s;
        };
        $counterInput+=1;
        $counterOutput+=0;
        Remove-Item $path;
    };
    
    
    start-sleep -Milliseconds 500;
};