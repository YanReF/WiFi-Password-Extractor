$OutputFile = "wifi.txt"
$ComputerName = $env:COMPUTERNAME

function Add-ToFile {
    param (
        [string]$Text
    )
    $Text | Out-File -Append -FilePath $OutputFile
}

function Show-Error {
    param (
        [string]$Message
    )
    Write-Host "Erro: $Message" -ForegroundColor Red
    exit
}

if (-not (Get-Command netsh -ErrorAction SilentlyContinue)) {
    Show-Error "O comando 'netsh' não está disponível em seu computador."
}

$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

if (-not (Test-Path $OutputFile)) {
    Add-ToFile ("$Timestamp Informações de Wi-Fi para o computador: $ComputerName`n")
} else {
    Add-ToFile ("`n$Timestamp Informações de Wi-Fi para o computador: $ComputerName`n")
}

try {
    $All_Networks = (netsh wlan show profiles) | Select-String ":\s*(.+)$" | ForEach-Object {
        $name = $_.Matches.Groups[1].Value.Trim()

        # Captura informações do perfil
        $profileInfo = netsh wlan show profiles name="$name" key="clear"

        # Extrai SSID e senha
        $SSID = ($profileInfo | Select-String -Pattern "Nome SSID\s*:\s*(.+)" | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }) -replace '"', ''
        $Key = ($profileInfo | Select-String -Pattern "da Chave\s*:\s*(.+)" | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }) -replace '"', ''

        # Cria um objeto com o nome da rede e a senha
        [PSCustomObject]@{ 
            Network = $SSID
            Password = $Key
        }
    }

    $All_Networks | ForEach-Object {
        Add-ToFile ("Network: " + $_.Network + " | Password: " + $_.Password)
    }

    Write-Host "Informações salvas em $OutputFile" -ForegroundColor Green
} catch {
    Show-Error "Ocorreu um erro ao executar o script."
}
