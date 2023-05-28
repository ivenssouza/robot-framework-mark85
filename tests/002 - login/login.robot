*** Settings ***
Documentation       Login Test Suite for Mark85

Resource            ${EXECDIR}/resources/resource.robot
Suite Teardown      Remove User From Mongo     ${filter}


*** Variables ***
&{user}             name=Bruce Wayne        email=bruce.wayne@wayneinc.com     password=iambatman
&{filter}           name=Bruce Wayne        email=bruce.wayne@wayneinc.com

@{loginTest}                all     noEmail     noPassword      none
${loginOK}                  LOGIN OK
${loginAlertEmail}          Informe seu e-mail
${loginAlertPassword}       Informe sua senha


*** Test Cases ***
Login OK
    Open Page                       ${EMPTY}
    Submit Login Form               ${loginTest}[0]      ${user}
    User Should Be Logged In        ${user}


Email Field Empty
    Open Page               ${EMPTY}
    Submit Login Form       ${loginTest}[1]      ${user}
    Alert Should Be         ${loginAlertEmail}


Password Field Empty
    Open Page               ${EMPTY}
    Submit Login Form       ${loginTest}[2]      ${user}
    Alert Should Be         ${loginAlertPassword}


All Fields Empty
    Open Page               ${EMPTY}
    Submit Login Form       ${loginTest}[3]      ${user}
    Alert Should Be         ${loginAlertEmail}
    Alert Should Be         ${loginAlertPassword}