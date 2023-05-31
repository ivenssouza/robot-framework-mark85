*** Settings ***
Documentation       A resource file containing the trainning app specific keywords and variables for keyword-driven tests that create our own domain specific language. Also SeleniumLibrary itself is imported here so that tests only need to import this resource file.
Library             Browser
Library             String


*** Variables ***


*** Keywords ***
Register User
    [Arguments]     ${test}     ${user}

    IF  '${test}' == 'all'
        Fill Text       css=input[name=name]        ${user}[name]
        Fill Text       css=input[name=email]       ${user}[email]
        Fill Text       css=input[name=password]    ${user}[password]
    ELSE IF    '${test}' == 'noUser'
        Fill Text       css=input[name=email]       ${user}[email]
        Fill Text       css=input[name=password]    ${user}[password]
    ELSE IF    '${test}' == 'noEmail'
        Fill Text       css=input[name=name]        ${user}[name]
        Fill Text       css=input[name=password]    ${user}[password]
    ELSE IF  '${test}' == 'noPassword'
        Fill Text       css=input[name=name]        ${user}[name]
        Fill Text       css=input[name=email]       ${user}[email]
    ELSE
        Fill Text       css=input[name=name]        ${EMPTY}
        Fill Text       css=input[name=email]       ${EMPTY}
        Fill Text       css=input[name=password]    ${EMPTY}
    END
    Click           css=button[type=submit] >> text=Cadastrar