*** Settings ***
Documentation            Aqui estarão presentes os testes de API do Dojo

Resource                ../../src/configs/package.robot

Test Setup               Conectar com a minha API

*** Variables ***
${BASE_URL}                       https://fakerestapi.azurewebsites.net

&{JSON_BODY}
...    id=787799
...    title=Livro do Denzel
...    description=My Nigga
...    pageCount=123
...    excerpt=voluptate sunt est
...    publishDate=2021-12-17T09:39:01.228Z

*** Test Cases ***
Cenario: Buscar a listagem de todos os livros (GET em todos os livros)
    [Tags]            TESTE_1
    Requisitar todos os livros
    Conferir o status code      200
    Conferir o reason           OK
    Conferir se retorna uma lista com "200" livros

Cenario: Buscar um livro específico(GET em um Livro específico)
    [Tags]            TESTE_2
    Requisitar o livro "20"
    Conferir o status code      200
    Conferir o reason           OK
    Conferir se retorna todos os dados corretos do livro 20

Cenario: Cadastrar um novo livro (POST)
    [Tags]          TESTE_3
    Cadastrar um novo livro
    Conferir o status code      200
    Conferir o reason           OK
    Conferir se retorna todos os dados cadastrados do livro "201"