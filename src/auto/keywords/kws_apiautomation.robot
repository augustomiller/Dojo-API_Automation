*** Settings ***
Documentation           Keywords referentes aos testes cases de automação de API

Resource                ../../configs/package.robot

*** Keywords ***
Conectar com a minha API
    Create Session                        booksAPI            ${API_BOOKS.BASE_URL}        disable_warnings=${True}
    ${HEADERS}                            Create Directory    content-type=application/json
    Set Test Variable                     ${HEADERS}

Requisitar todos os livros
    ${RESPOSTA}                           GET On Session      booksAPI       ${API_BOOKS.ENDPOINT}        
    Log                                   ${RESPOSTA.text}
    Set Test Variable                     ${RESPOSTA}

Conferir o status code    
    [Arguments]          ${STATUS_CODE}
    Should Be Equal As Strings            ${RESPOSTA.status_code}    ${STATUS_CODE}

Conferir o reason  
    [Arguments]          ${REASON}   
    Should Be Equal As Strings            ${RESPOSTA.reason}         ${REASON}

Conferir se retorna uma lista com "${QUANTIDADE}" livros
    Length Should Be                      ${RESPOSTA.json()}         ${QUANTIDADE}

Requisitar o livro "${ID_LIVRO}"

Conferir se retorna todos os dados corretos do livro 20

Cadastrar um novo livro

Conferir se retorna todos os dados cadastrados do livro "${ID_LIVRO}"
    
