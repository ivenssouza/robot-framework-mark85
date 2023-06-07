*** Settings ***
Documentation       Login Test Suite for Mark85

Resource            ${EXECDIR}/resources/resource.robot
Suite Setup         Login Suite Setup       ${filter}        ${user}


*** Variables ***
&{user}                     name=Clark Kent        email=clark.kent@dailyplanet.com     password=kryptonite
&{filter}                   name=Clark Kent        email=clark.kent@dailyplanet.com

@{loginTest}                ok      wrongEmail        wrongPassword        noEmail     noPassword      none

${loginOK}                  LOGIN OK
${loginNOK}                 Ocorreu um erro ao fazer login, verifique suas credenciais.
${loginAlertEmail}          Informe seu e-mail
${loginAlertPassword}       Informe sua senha


*** Test Cases ***
Login Succes
    Open Page                       ${EMPTY}
    Submit Login Form               ${loginTest}[0]      ${user}
    User Should Be Logged In        ${user}


Wrong E-mail
    Open Page                       ${EMPTY}
    Submit Login Form               ${loginTest}[1]      ${user}
    Notice Should Be                ${loginNOK}


Wrong Password
    Open Page                       ${EMPTY}
    Submit Login Form               ${loginTest}[2]      ${user}
    Notice Should Be                ${loginNOK}


Email Field Empty
    Open Page                       ${EMPTY}
    Submit Login Form               ${loginTest}[3]      ${user}
    Alert Should Be                 ${loginAlertEmail}


Password Field Empty
    Open Page                       ${EMPTY}
    Submit Login Form               ${loginTest}[4]      ${user}
    Alert Should Be                 ${loginAlertPassword}


All Fields Empty
    Open Page                       ${EMPTY}
    Submit Login Form               ${loginTest}[5]      ${user}
    Alert Should Be                 ${loginAlertEmail}
    Alert Should Be                 ${loginAlertPassword}