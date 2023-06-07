*** Settings ***
Documentation       A resource file containing the trainning app specific keywords and variables for keyword-driven tests that create our own domain specific language. Also SeleniumLibrary itself is imported here so that tests only need to import this resource file.
Library             Browser
Library             String

*** Variables ***


*** Keywords ***
Login Suite Setup
    [Documentation]             Delete the user from MongoDB and create a new user calling the API Lib
    
    [Arguments]                 ${filter}       ${user}

    Delete User From MONGODB    ${filter}
    API New User Helper         ${user}

    
Submit Login Form
    [Arguments]                 ${test}         ${user}
    
    IF  '${test}' == 'ok'
        Fill Text       css=input[name=email]       ${user}[email]
        Fill Text       css=input[name=password]    ${user}[password]
    ELSE IF    '${test}' == 'wrongEmail'
        Fill Text       css=input[name=email]       wrong@email.com
        Fill Text       css=input[name=password]    ${user}[password]
    ELSE IF    '${test}' == 'wrongPassword'
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