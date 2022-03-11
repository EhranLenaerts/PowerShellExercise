# Start remote PSSession
$sessionpi = New-PSSession -HostName rpiEhran -UserName pi

Start-Sleep -Seconds 10

# Get CPU temperature
Invoke-Command -Session $sessionpi -ScriptBlock {
    # Make a new WebClient so we can later send the data to ThingSpeak
    $HTTP_Client = new-object net.webclient

    # Currently a For loop for testing purposes, perfectly possible to change this to a while loop for indefinite measurements
    For ($i = 1;$i -lt 5;$i++) {
        
    $temp = Get-Content /sys/class/thermal/thermal_zone0/temp
    
# Turn temperature into a readable format in celcius
$temp = $temp / 1000

$temp= [math]::Round($temp, 2)

# Making a small string to print it in the PowerShell CLI for local use
$print_temp = ($temp.ToString()) + "C°"
$print_temp

# ThingSpeak Write API Key
$key = "JAPBCLNNPLGPYCA7"

# ThingSpeak URL
$url = "https://api.thingspeak.com/update?api_key=" + $key + "&field1=" + $temp

# Send CPU temperature to ThingSpeak
$HTTP_Client.DownloadString($url)

# A small timer for the loop to get measurements, this can be altered for the intended result
Start-Sleep -Seconds 15
}
}

Start-Process https://thingspeak.com/channels/1345029

# Removing the previously made Remote Session to clear up processing power
Remove-PSSession -Session $sessionpi