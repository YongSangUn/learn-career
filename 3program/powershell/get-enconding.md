# 获取文本的编码

```powershell
function Get-Encoding
{
  param
  (
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
    [Alias('FullName')]
    [string]
    $Path
  )

  process
  {
    $bom = New-Object -TypeName System.Byte[](4)

    $file = New-Object System.IO.FileStream($Path, 'Open', 'Read')

    $null = $file.Read($bom,0,4)
    $file.Close()
    $file.Dispose()

    $enc = [Text.Encoding]::ASCII
    if ($bom[0] -eq 0x2b -and $bom[1] -eq 0x2f -and $bom[2] -eq 0x76)
      { $enc =  [Text.Encoding]::UTF7 }
    if ($bom[0] -eq 0xff -and $bom[1] -eq 0xfe)
      { $enc =  [Text.Encoding]::Unicode }
    if ($bom[0] -eq 0xfe -and $bom[1] -eq 0xff)
      { $enc =  [Text.Encoding]::BigEndianUnicode }
    if ($bom[0] -eq 0x00 -and $bom[1] -eq 0x00 -and $bom[2] -eq 0xfe -and $bom[3] -eq 0xff)
      { $enc =  [Text.Encoding]::UTF32}
    if ($bom[0] -eq 0xef -and $bom[1] -eq 0xbb -and $bom[2] -eq 0xbf)
      { $enc =  [Text.Encoding]::UTF8}

    [PSCustomObject]@{
      Encoding = $enc
      Path = $Path
    }
  }
}


PS> dir $home -Filter *.txt -Recurse | Get-Encoding

Encoding                    Path
--------                    ----
System.Text.UnicodeEncoding C:\Users\tobwe\E006_psconfeu2019.txt
System.Text.UnicodeEncoding C:\Users\tobwe\E009_psconfeu2019.txt
System.Text.UnicodeEncoding C:\Users\tobwe\E027_psconfeu2019.txt
System.Text.ASCIIEncoding   C:\Users\tobwe\.nuget\packages\Aspose.Words\18.12.0\...
System.Text.ASCIIEncoding   C:\Users\tobwe\.vscode\extensions\ms-vscode.powers...
System.Text.UTF8Encoding    C:\Users\tobwe\.vscode\extensions\ms-vscode.powers...
```
