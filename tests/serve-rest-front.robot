*** Settings ***
Resource        ../resources/serve-rest-front.resource

Suite Setup     Cadastrar Usuário e Logar


*** Test Cases ***
Login com sucesso Serve Rest Front
    Open Navigator
    Go to Serve Rest Front website
    Signup a user
    Check if the user was created

Desafio: Conferir se o novo usuário é mostrado na listagem de usuários
    Open the Site Serve Rest Front login
    Get user list
    Check if there is the an user in a list

Create product and get in the list
    Open the Site Serve Rest Front login
    Register a new product
    Check if there is the product in the product list

Exemplo utilizando Requisições HTTP
    Open Navigator
    Go to Serve Rest Front website
    Criar usuário via API
    Logar com o usuário cadastrado via API

Using Storage in the context
    Open the Site Serve Rest Front login
    Get user list
