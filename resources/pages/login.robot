*** Settings ***
Documentation       A resource file containing the trainning app specific keywords and variables for keyword-driven tests that create our own domain specific language. Also SeleniumLibrary itself is imported here so that tests only need to import this resource file.
Library             Browser
Library             String

*** Variables ***


*** Keywords ***
Submit Login Form
    [Arguments]     ${test}     ${user}
    
    IF  '${test}' == 'ok'
        Fill Text       css=input[name=email]       ${user}[email]
        Fill Text       css=input[name=password]    ${user}[password]
    ELSE IF    '${test}' == 'fail'
        Fill Text       css=input[name=email]       ${user}[email]
        Fill Text       css=input[name=password]    wrongpassword
    ELSE IF    '${test}' == 'noEmail'
        Fill Text       css=input[name=password]    ${user}[password]
    ELSE IF  '${test}' == 'noPassword'
        Fill Text       css=input[name=email]       ${user}[email]
    ELSE
        Fill Text       css=input[name=email]       ${EMPTY}
        Fill Text       css=input[name=password]    ${EMPTY}
    END

    Click           css=button[type=submit] >> text=Entrar

User Should Be Logged In
    [Arguments]     ${user}

    @{name}             Split String        ${user}[name]
    Get Property        small       innerText       ==      Olá, ${name}[0]