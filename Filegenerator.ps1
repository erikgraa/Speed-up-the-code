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
$logLines = for ($i=0; $i -lt 50000; $i++) {
    #$timestamp = $d.AddSeconds(-$i).ToString("yyyy-MM-dd HH:mm:ss")
    $timestamp = (Get-Date).AddSeconds(-$i).ToString("yyyy-MM-dd HH:mm:ss")
    #$plc = $plcNames | Get-Random
    $plc = Get-Random -InputObject $plcNames
    #$operator = Get-Random -Minimum 101 -Maximum 121
    $operator = [System.Random]::New().Next(101,121)
    #$batch = Get-Random -Minimum 1000 -Maximum 1101
    $batch = [System.Random]::New().Next(1000,1101)
    #$status = $statusCodes | Get-Random
    $status = Get-Random -InputObject $statusCodes
    #$machineTemp = [math]::Round((Get-Random -Minimum 60 -Maximum 110) + (Get-Random),2)
    $machineTemp = [math]::Round([System.Random]::New().Next(60,110)+ [System.Random]::New().Next(),2)
    #$load = Get-Random -Minimum 0 -Maximum 101
    $load = [System.Random]::New().Next(0,101)
 
    #if ((Get-Random -Minimum 1 -Maximum 8) -eq 4) {
    if (([System.Random]::New().Next(1,8)) -eq 4) {
        #$errorType = $errorTypes | Get-Random 
        $errorType = Get-Random -InputObject $errorTypes
        if ($errorType -eq 'Sandextrator overload') {
            #$value = (Get-Random -Minimum 1 -Maximum 11)
            $value = [System.Random]::New().Next(1,11)
            "ERROR; $timestamp; $plc; $errorType; $value; $status; $operator; $batch; $machineTemp; $load"
        } else {
            "ERROR; $timestamp; $plc; $errorType; ; $status; $operator; $batch; $machineTemp; $load"
        }
    } else {
        "INFO; $timestamp; $plc; System running normally; ; $status; $operator; $batch; $machineTemp; $load"
    }
}
 
Set-Content -Path $bigFileName -Value $logLines
#[System.IO.File]::WriteAllText($bigFileName, $logLines)
Write-Output "PLC log file generated."
}
