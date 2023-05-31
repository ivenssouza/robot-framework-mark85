*** Settings ***
Documentation       Sign Up Test Suite for Mark85

Resource            ${EXECDIR}/resources/resource.robot


*** Variables ***
&{user}             name=Bruce Wayne        email=bruce.wayne@wayneinc.com     password=iambatman
&{filter}           name=Bruce Wayne        email=bruce.wayne@wayneinc.com

@{signupTest}       all     noUser      noEmail     noPassword      none
${signupNOK}        Oops! Já existe um cadastro com e-mail informado.
${signupOK}         Boas vindas ao Mark85, o seu gerenciador de tarefas.
${signupAlertNome}        Informe seu nome completo
${signupAlertEmail}       Informe seu e-email
${signupAlertPassword}    Informe uma senha com pelo menos 6 digitos


*** Test Cases ***
New User
    Open Page           signup
    Register user       ${signupTest}[0]      ${user}
    Notice Should Be    ${signupOK}

User Already Exists
    Open Page           signup
    Register User       ${signupTest}[0]      ${user}
    Notice Should Be    ${signupNOK}

Name Field Empty
    Open Page           signup
    Register User       ${signupTest}[1]      ${user}
    Alert Should Be     ${signupAlertNome}

Email Field Empty
    Open Page           signup
    Register User       ${signupTest}[2]      ${user}
    Alert Should Be     ${signupAlertEmail}

Password Field Empty
    Open Page           signup
    Register User       ${signupTest}[3]      ${user}
    Alert Should Be     ${signupAlertPassword}

All Fields Empty
    Open Page           signup
    Register User       ${signupTest}[4]      ${user}
    Alert Should Be     ${signupAlertNome}
    Alert Should Be     ${signupAlertEmail}
    Alert Should Be     ${signupAlertPassword}