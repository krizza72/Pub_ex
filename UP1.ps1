$publishUrl="http://170.64.192.59:8000/upload"
$packageName = "Ben_Button_Case.docx.jpg"
$username="Ben"
$password="5P1b8Z"

$params = @{
  UseBasicParsing = $true
  Uri             = $publishUrl
  Method          = "PUT"
  InFile          = $packageName
  Headers         = @{
    ContentType   = "image.jpg"
    Authorization = "Basic $([System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$username`:$password")))" 
  }
  Verbose         = $true
}
Invoke-WebRequest @params
