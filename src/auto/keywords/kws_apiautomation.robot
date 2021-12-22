*** Settings ***
Documentation           Keywords referentes aos testes cases de automação de API

Resource                ../../configs/package.robot
Library    String
Library    JSONLibrary

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
    ${RESPOSTA}             GET On Session         booksAPI                      ${API_BOOKS.ENDPOINT}/${ID_LIVRO}
    Log                                                   ${RESPOSTA.text}
    Set Test Variable                                     ${RESPOSTA}
Conferir se retorna todos os dados corretos do livro 20
    ${JSON_DATA}            Set Variable                  ${RESPOSTA.json()}
    ${ID}                   Get From Dictionary           ${JSON_DATA}           ${DATA.ID}
    ${TITLE}                Get From Dictionary           ${JSON_DATA}           ${DATA.TITLE}
    ${PUBLISH_DATE}         Get From Dictionary           ${JSON_DATA}           ${DATA.PUBLISH_DATE}
Cadastrar um novo livro
    ${JSON}                 Format String                               ${DIR.JSON}
    ${SCHEMA_BODY}            Convert String to JSON                    ${JSON}

    ${RESPOSTA}             POST On Session         booksAPI            ${API_BOOKS.ENDPOINT}        json=${SCHEMA_BODY}
    Log                                                                 ${RESPOSTA.text}
    Set Test Variable                                                   ${RESPOSTA}

Conferir se retorna todos os dados cadastrados do livro "${ID_LIVRO}"
    ${JSON_DATA}                          Set Variable                  ${RESPOSTA.json()}
    ${ID}                                 Get From Dictionary           ${JSON_DATA}           ${DATA.ID}
    ${TITLE}                              Get From Dictionary           ${JSON_DATA}           ${DATA.TITLE}
    ${DESCRIPTION}                        Get From Dictionary           ${JSON_DATA}           ${DATA.DESCRIPTION}
    ${PUBLISH_DATE}                       Get From Dictionary           ${JSON_DATA}           ${DATA.PUBLISH_DATE}
