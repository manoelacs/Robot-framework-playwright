*** Settings ***
Library     Browser
# ...    timeout=00:00:05
# ...    enable_presenter_mode=${true}
Library     FakerLibrary
Library     DateTime


*** Variables ***
${BROWSER}              webkit
${HEADLESS}             ${true}
${SITE_SERVE_REST}      https://front.serverest.dev/


*** Keywords ***
Open Navigator
    New Browser    browser=${BROWSER}
    ...    headless=${HEADLESS}

    ${TRACE_NAME}    FakerLibrary.Uuid 4
    ${NOW}    Get Current Date    result_format=%d-%m-%Y_%H%M%S
    New Context    viewport={'width': 1200, 'height': 800}
    # ...    tracing=${OUTPUT_DIR}/evidencies/traces/${NOW}/${TRACE_NAME}.zip
    # ...    recordVideo={'dir':'${OUTPUT_DIR}/evidencies/videos/${NOW}'}

Go to Serve Rest Front website
    New Page    url=${SITE_SERVE_REST}
    ${title}    Get Title    ==    Front - ServeRest
    Log    ${title}

Signup a user
    # Record Selector
    # Click    css=.btn-link
    # Click    text="Cadastre-se"
    Click    css=a[data-testid='cadastrar']
    ${EMAIL}    FakerLibrary.Email
    Set Suite Variable    ${EMAIL}
    Fill Text    css=input[data-testid='nome']    Maria Aparecida
    Fill Text    css=input[data-testid='email']    ${EMAIL}
    Fill Text    css=input[data-testid='password']    123456
    Check Checkbox    css=input[data-testid='checkbox']
    # Click    css=button[data-testid='cadastrar']
    Click    xpath=//*[@id="root"]//button >> text="Cadastrar"

Check if the user was created
    Wait For Elements State    h1    visible
    Get Text    h1    ==    Bem Vindo Maria Aparecida
    Get Element States    css=button[data-testid='logout']    validate    value & visible

Create new user
    Open navigator
    Go to Serve Rest Front website
    Signup a user
    Check if the user was created

Get user list
    Click    css=a[data-testid='listarUsuarios']

Check if there is the an user in a list
    ${elemento}    Get Table Cell Element    css=table    "Nome"    "${EMAIL}"
    ${usuario_nome}    Get Text    ${elemento}    ==    Maria Aparecida
    Highlight Elements    ${elemento}
    Take Screenshot    fullPage=${true}

Register a new product
    Click    css=a[data-testid='cadastrarProdutos']
    ${NOME_PRODUTO}    FakerLibrary.Word
    Set Test Variable    ${NOME_PRODUTO}
    Fill Text    css=input[data-testid='nome']    ${NOME_PRODUTO}
    Fill Text    css=input[data-testid='preco']    10
    Fill Text    css=textarea[data-testid='descricao']    Produto Teste Robot Framework
    Fill Text    css=input[data-testid='quantity']    5
    Click    text="Cadastrar"

Check if there is the product in the product list
    ${elemento}    Get Table Cell Element    css=table    "Descrição"    "${NOME_PRODUTO}"
    ${descricao}    Get Text    ${elemento}    ==    Produto Teste Robot Framework
    Highlight Elements    ${elemento}
    Take Screenshot    fullPage=${true}

Create a new user by API
    ${EMAIL}    FakerLibrary.Email
    Set Suite Variable    ${EMAIL}

    ${resposta}    Http    url=https://serverest.dev/usuarios
    ...    method=POST
    ...    body={"nome": "Maria Aparecida","email": "${EMAIL}","password": "123456","administrador": "true"}

    Should Be Equal As Integers    ${resposta["status"]}    201

Login with the new user via API
    [Tags]    login_with_api
    ${resposta}    Http    url=https://serverest.dev/login
    ...    method=POST
    ...    body={"email": "${EMAIL}","password": "123456"}

    Should Be Equal As Integers    ${resposta["status"]}    200

    LocalStorage Set Item    serverest/userEmail    ${EMAIL}
    LocalStorage Set Item    serverest/userToken    ${resposta["body"]["authorization"]}
    LocalStorage Set Item    serverest/userNome    Maria Aparecida

    Go To    url=https://front.serverest.dev/admin/home

    Take Screenshot

Register user and log in
    New Browser
    New Page    url=${SITE_SERVE_REST}
    Create a new user by API
    Login with the new user via API
    ${STORAGE_FILE}    Save Storage State
    Set Suite Variable    ${STORAGE_FILE}

Open the Site Serve Rest Front login
    [Tags]    open_server_rest_loging
    New Browser    browser=${BROWSER}
    ...    headless=${HEADLESS}
    New Context    viewport={'width': 1200, 'height': 800}
    ...    storageState=${STORAGE_FILE}
    New Page    url=https://front.serverest.dev/admin/home
    Get Text    h1    ==    Bem Vindo Maria Aparecida
    Take Screenshot
