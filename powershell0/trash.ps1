$joinedOutput+= $s;
$joinedOutput+=[environment]::NewLine;

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
 #$outputPath = -join('C:\Program Files\Windows system\output', $counterOutput, '.txt');
