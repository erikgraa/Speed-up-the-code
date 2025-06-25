Measure-Command{
$bigFileName = "plc_log.txt"
$plcNames = 'PLC_A','PLC_B','PLC_C','PLC_D'
$errorTypes = @(
    'Sandextrator overload',
    'Conveyor misalignment',
    'Valve stuck',
    'Temperature warning'
)
$statusCodes = 'OK','WARN','ERR'

#$d = get-date
#$d = [datetime]::now
$tostringformat = "yyyy-MM-dd HH:mm:ss"
$s = 'Sandextrator overload'
$logLines = for ($i=0; $i -lt 50000; $i++) {
    $random = [system.random]::new()
    #$timestamp = $d.AddSeconds(-$i).ToString("yyyy-MM-dd HH:mm:ss")
    #$timestamp = (Get-Date).AddSeconds(-$i).ToString("yyyy-MM-dd HH:mm:ss")
    #$timestamp = [datetime]::now.Add([timespan]::new(0,0,-$i)).tostring($tostringformat)    
    $timestamp = [datetime]::now.AddSeconds(-$i).ToString($tostringformat)
    #$plc = $plcNames | Get-Random
    $plc = Get-Random $plcNames
    #$operator = Get-Random -Minimum 101 -Maximum 121
    #$operator = [System.Random]::New().Next(101,121)
    $operator = $random.Next(101,121)
    #$batch = Get-Random -Minimum 1000 -Maximum 1101
    #$batch = [System.Random]::New().Next(1000,1101)
    $batch = $random.Next(1000,1101)
    #$status = $statusCodes | Get-Random
    $status = Get-Random $statusCodes
    #$machineTemp = [math]::Round((Get-Random -Minimum 60 -Maximum 110) + (Get-Random),2)
    #$machineTemp = [math]::Round([System.Random]::New().Next(60,110)+ [System.Random]::New().Next(),2)
    $machineTemp = [math]::Round($random.Next(60,110)+ $random.Next(),2)
    #$load = Get-Random -Minimum 0 -Maximum 101
    #$load = [System.Random]::New().Next(0,101)
    $load = $random.Next(0,101)

    #if ((Get-Random -Minimum 1 -Maximum 8) -eq 4) {
    #if (([System.Random]::New().Next(1,8)) -eq 4) {
    if (($random.Next(1,8)) -eq 4) {
        #$errorType = $errorTypes | Get-Random 
        #$errorType = Get-Random $errorTypes
        #if ($errorType -eq 'Sandextrator( overload'){
        #if (($errorType = Get-Random $errorTypes) -eq 'Sandextrator overload') {
        if (($errorType = Get-Random $errorTypes) -eq $s) {
            #$value = (Get-Random -Minimum 1 -Maximum 11)
            #$value = [System.Random]::New().Next(1,11)
            #write-output "ERROR; $timestamp; $plc; $errorType; $value; $status; $operator; $batch; $machineTemp; $load"             
            "ERROR; $timestamp; $plc; $errorType; $value; $status; $operator; $batch; $machineTemp; $load"
            #"ERROR; $timestamp; $plc; $errorType; ${random.Next(1,101)}; $status; $operator; $batch; $machineTemp; $load"
            #("ERROR; {0}; {1}; {2}; {3}; {4}; {5}; {6}; {7}; {8}" -f $timestamp, $plc, $errorType, $load, $status, $operator, $batch, $machineTemp, $load)            
            #("ERROR; {0}; {1}; {2}; {3}; {4}; {5}; {6}; {7}; {8}" -f $timestamp, $plc, $errorType, [System.Random]::New().Next(1,101), $status, $operator, $batch, $machineTemp, $load)
            #("ERROR; {0}; {1}; {2}; {3}; {4}; {5}; {6}; {7}; {8}" -f $timestamp, $plc, $errorType, $random.Next(1,101), $status, $operator, $batch, $machineTemp, $load)
        } else {
            "ERROR; $timestamp; $plc; $errorType; ; $status; $operator; $batch; $machineTemp; $load"
            #write-output "ERROR; $timestamp; $plc; $errorType; ; $status; $operator; $batch; $machineTemp; $load"
            #("ERROR; {0}; {1}; {2}; ; {3}; {4}; {5}; {6}; {7}" -f $timestamp, $plc, $errorType, $status, $operator, $batch, $machineTemp, $load)
        }
    } else {
        "INFO; $timestamp; $plc; System running normally; ; $status; $operator; $batch; $machineTemp; $load"
        #write-output "INFO; $timestamp; $plc; System running normally; ; $status; $operator; $batch; $machineTemp; $load"
        #("INFO; {0}; {1}; System running normally; ; {2}; {3}; {4}; {5}; {6}" -f $timestamp, $plc, $status, $operator, $batch, $machineTemp, $load)
    }
}
 
Set-Content -Path $bigFileName -Value $logLines
#$loglines | Set-Content -Path $bigFileName
#$loglines | out-file $bigFileName
#[System.IO.File]::WriteAllText($bigFileName, $logLines)
#Write-Output "PLC log file generated."
"PLC log file generated."
}
