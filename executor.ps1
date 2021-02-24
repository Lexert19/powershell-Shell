$counterInput = 0;
$counterOutput = 0;

while (1) {
    $path = -join('C:\Program Files\AAA\input',$counterInput, '.txt');
    

    if(Test-Path $path){

        $input = Get-Content $path;
        if($input.length -ge 1){
            $outputPath = -join('C:\Program Files\AAA\output', $counterOutput, '.txt');

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
        Remove-Item $path;
    };
    
    
    start-sleep -Milliseconds 120;
};