*** Settings ***
Documentation       A resource file containing the trainning app specific keywords and variables for keyword-driven tests that create our own domain specific language. Also SeleniumLibrary itself is imported here so that tests only need to import this resource file.
Library             Browser
Library             String

Library   RobotMongoDBLibrary.Insert
Library   RobotMongoDBLibrary.Update
Library   RobotMongoDBLibrary.Find
Library   RobotMongoDBLibrary.Delete

*** Variables ***
# CONNECT WITH CONNECTION STRING CLUSTER
&{MONGODB_CONNECT_STRING}=   connection=mongodb+srv://qax:xperience@cluster0.vcrmeiw.mongodb.net/?retryWrites=true&w=majority    database=test   collection=users


${BROWSER}      chromium
${DELAY}        0
${URL}          http://localhost:3000/

*** Keywords ***
Open Page
    [Documentation]     Returns the title of the webpage found at the given URL.

    [Arguments]         ${page}

    New Browser         headless=false      browser=${BROWSER}
    New Page            ${URL}${page}


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


Notice Should Be
    [Arguments]     ${message}

    ${notice}       Set Variable        css=.notice p
    Wait For Elements State        ${notice}    visible    5
    Get Text        ${notice}        equal      ${message}


Alert Should Be
    [Arguments]     ${message}

    ${alert}       Set Variable        css=.alert-error >> text=${message}
    Wait For Elements State        ${alert}    visible    5
    Get Text        ${alert}        equal      ${message}


Submit Login Form
    [Arguments]     ${test}     ${user}
    
    IF  '${test}' == 'all'
        Fill Text       css=input[name=email]       ${user}[email]
        Fill Text       css=input[name=password]    ${user}[password]
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

    @{name}             Split String        ${user}[name]       ${SPACE}
    Get Property        small       innerText       ==      Olá, ${name}[0]


Remove User From Mongo
    [Arguments]     ${filter}
    ${MSG}      Delete One      ${MONGODB_CONNECT_STRING}       ${filter}
###########################################################




Toast Should Be
    [Arguments]    ${message}
    ${element}    Set Variable    css=span[data-notify=message]
    Wait For Elements State    ${element}    visible    5 
    Get Text    ${element} span    equal    ${message}

Start Session
    New Browser        browser=chromium    headless=False
    New Page           http://localhost:3000

Go to signup
    Go To           http://localhost:3000/signup
    Get Text        css=form h1        equal        Faça seu cadastro