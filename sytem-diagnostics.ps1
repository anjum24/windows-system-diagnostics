# ================================
# Windows System Health & Diagnostics Tool
# Author: System Admin
# ================================

Write-Host "=== System Diagnostics Report ===`n"

# OS Information
Write-Host "System Information"
Write-Host "------------------"
$os = Get-CimInstance Win32_OperatingSystem
Write-Host "OS Version: $($os.Caption) (Build $($os.BuildNumber))"
Write-Host "Last Boot Time: $($os.LastBootUpTime)`n"

# CPU & RAM Usage
Write-Host "Performance"
Write-Host "-----------"
$cpu = Get-Counter '\Processor(_Total)\% Processor Time'
Write-Host ("CPU Usage: {0:N2}%" -f $cpu.CounterSamples.CookedValue)

$ramTotal = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
$ramFree = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
$ramUsed = $ramTotal - $ramFree
Write-Host "RAM Usage: $ramUsed GB / $ramTotal GB`n"

# Disk Space
Write-Host "Disk Space"
Write-Host "----------"
Get-PSDrive -PSProvider FileSystem | ForEach-Object {
    $free = [math]::Round($_.Free/1GB, 2)
    $total = [math]::Round($_.Used/1GB + $free, 2)
    Write-Host "$($_.Name): $free GB free / $total GB total"
}
Write-Host ""

# Installed Applications
Write-Host "Installed Applications"
Write-Host "----------------------"
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
Select-Object DisplayName, DisplayVersion |
Sort-Object DisplayName |
Format-Table -AutoSize
Write-Host ""

# Network Info
Write-Host "Network Information"
Write-Host "-------------------"
$net = Get-NetIPAddress | Where-Object {$_.AddressFamily -eq "IPv4" -and $_.IPAddress -ne "127.0.0.1"}
Write-Host "IP Address: $($net.IPAddress)"
Write-Host "Interface: $($net.InterfaceAlias)"
Write-Host "DNS Servers: $(Get-DnsClientServerAddress -AddressFamily IPv4 | Select-Object -ExpandProperty ServerAddresses)"
Write-Host ""

# Ping Test
Write-Host "Connectivity Test"
Write-Host "-----------------"
if (Test-Connection -ComputerName "8.8.8.8" -Count 2 -Quiet) {
    Write-Host "Ping Test: Success"
} else {
    Write-Host "Ping Test: Failed"
}
Write-Host ""

# Event Viewer Errors (last 24 hours)
Write-Host "Event Viewer Errors (Last 24 Hours)"
Write-Host "----------------------------------"
$events = Get-WinEvent -FilterHashtable @{LogName='Application'; Level=2; StartTime=(Get-Date).AddHours(-24)}
if ($events.Count -gt 0) {
    Write-Host "Errors Found: $($events.Count)"
    $events | Select-Object TimeCreated, Id, Message | Format-Table -AutoSize
} else {
    Write-Host "No critical errors found."
}

Write-Host "`n=== End of Report ==="
