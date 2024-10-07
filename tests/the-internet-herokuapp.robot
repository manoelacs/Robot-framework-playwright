*** Settings ***
Resource  ../resources/the-internet-herokuapp.resource
Test Teardown  Tirar Print


*** Test Cases ***
Interagindo com Dropdown
  Acessar "https://the-internet.herokuapp.com/dropdown"
  Selecionar opção "Option 1"

Interagindo com iFrames
  Acessar "https://the-internet.herokuapp.com/iframe"
  Obter frase de dentro do iFrame

Interagindo com Tabelas
  Acessar "https://the-internet.herokuapp.com/tables"
  Conferindo valores em tabelas

Interagindo com novas abas (pages)
  Acessar "https://the-internet.herokuapp.com/windows"
  ${page_id}    Get Page Ids
  Clicar e ir para a nova página aberta
  Voltar para a página inicial  ${page_id}
