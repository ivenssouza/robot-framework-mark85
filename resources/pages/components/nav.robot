*** Settings ***
Documentation       A resource file containing the trainning app specific keywords and variables for keyword-driven tests that create our own domain specific language. Also SeleniumLibrary itself is imported here so that tests only need to import this resource file.
Library             Browser
Library             String

#Resource           helpers.robot


*** Keywords ***
User Should Be Logged In
    [Arguments]         ${user}

    @{name}             Split String        ${user}[name]
    Get Property        small               innerText       ==      Olá, ${name}[0]