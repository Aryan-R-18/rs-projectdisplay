$match = netstat -aon | Select-String ':5500'
if ($match) {
  $pid = ($match.ToString().Trim() -split '\s+')[-1]
  taskkill /F /PID $pid
  Write-Host "Killed PID $pid"
} else {
  Write-Host "Nothing running on 5500"
}
Start-Process "node" "server.js" -NoNewWindow
Write-Host "Server started on port 5500"
