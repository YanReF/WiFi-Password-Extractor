# WiFi Password Extractor

Este repositório contém scripts para extrair senhas de redes Wi-Fi salvas no seu computador. O principal script é escrito em PowerShell e é executado através de um arquivo de inicialização em batch (`start.bat`).

## Como Usar

   **Clone o Repositório**

   Clone este repositório para o seu computador:

   ```sh
   git clone https://github.com/YanReF/WiFi-Password-Extractor.git
   ```

## Observações

  - **Política de Execução do PowerShell: O script start.bat configura temporariamente a política de execução do PowerShell para RemoteSigned e, após a execução do script PowerShell, reverte a política para Undefined.**
  
  - **Informações Coletadas: O script PowerShell (main.ps1) coleta informações sobre redes Wi-Fi salvas e extrai as senhas para um arquivo de texto.**
  
  - **Formato do Arquivo de Saída: O arquivo wifi.txt inclui o nome da rede e a senha, além do nome do computador. Se o arquivo já existir, as novas informações serão adicionadas com um carimbo de data e hora.**

  - **Idioma: Este script e suas mensagens de saída estão configurados para funcionar apenas em português brasileiro (PT-BR).**
