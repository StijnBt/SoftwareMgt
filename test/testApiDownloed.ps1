$apirUrl = 'https://dev.azure.com/Cronus/Business Central Product Extensions/_apis/git/repositories/Process-Flow/items?scopePath=/Flow-App-BC16/Flow_16.0.20201123.0.app&api-version=6.0'

$cred = 'pat'
$headers = @{ Authorization = "Basic $cred" }



#$Response = Invoke-WebRequest -URI $apirUrl -Method Get -Headers $headers -UseBasicParsing
#$Response.Content | Out-File -FilePath "C:\Users\bossu\Desktop\ws.txt"



# Create the HTTP client download request
$httpClient = New-Object System.Net.Http.HttpClient
$httpReq = New-Object System.Net.Http.HttpRequestMessage
$httpResp = New-Object System.Net.Http.HttpResponseMessage
$stream = New-Object System.IO.MemoryStream

$httpReq.Method = 'GET'
$httpReq.RequestUri = $apirUrl
$httpClient.DefaultRequestHeaders.Add('Authorization','Basic '+$cred)
#$httpClient.DefaultRequestHeaders.Add('Content-Type','application/octet-stream')

$httpResp = $httpClient.SendAsync($httpReq)

$httpResp.Result.Content.ReadAsStringAsync().Result | Out-File -FilePath "C:\Users\Desktop\ws.app"


#$stream = [IO.MemoryStream]::new([Text.Encoding]::UTF8.GetBytes($httpResp.Result.Content.ReadAsStringAsync().Result))


#Write-Host [Text.Encoding].UTF8.GetString($httpResp.Result.Content.ReadAsStringAsync().Result) | Out-File -FilePath "C:\Users\Desktop\ws.txt"

#([Text.Encoding].UTF8.GetString($httpResp.Result.Content.ReadAsStringAsync().Result)) 