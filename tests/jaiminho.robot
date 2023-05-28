*** Settings ***
Documentation       Minha primeira suite de teste automatizado

Resource            ${EXECDIR}/resources/resource.robot
Suite Teardown      Remove User From Mongo     ${filter}


*** Variables ***
&{user}             name=Bruce Wayne        email=bruce.wayne@wayneinc.com     password=iambatman
&{filter}           name=Bruce Wayne        email=bruce.wayne@wayneinc.com

@{signupTest}       all     noUser      noEmail     noPassword      none
${signupNOK}        Oops! Já existe um cadastro com e-mail informado.
${signupOK}         Boas vindas ao Mark85, o seu gerenciador de tarefas.
${signupAlertNome}        Informe seu nome completo
${signupAlertEmail}       Informe seu e-email
${signupAlertPassword}    Informe uma senha com pelo menos 6 digitos

@{loginTest}                all     noEmail     noPassword      none
${loginOK}                  LOGIN OK
${loginAlertEmail}          Informe seu e-mail
${loginAlertPassword}       Informe sua senha


*** Test Cases ***
Cadastro - Novo Usuário
    Open Page           signup
    Register user       ${signupTest}[0]      ${user}
    Notice Should Be    ${signupOK}


Cadastro - Usuário Duplicado
    Open Page           signup
    Register User       ${signupTest}[0]      ${user}
    Notice Should Be    ${signupNOK}


Cadastro - Nome Obrigatório
    Open Page           signup
    Register User       ${signupTest}[1]      ${user}
    Alert Should Be     ${signupAlertNome}


Cadastro - Email Obrigatório
    Open Page           signup
    Register User       ${signupTest}[2]      ${user}
    Alert Should Be     ${signupAlertEmail}


Cadastro - Senha Obrigatória
    Open Page           signup
    Register User       ${signupTest}[3]      ${user}
    Alert Should Be     ${signupAlertPassword}

Cadastro - Campos Vazios
    Open Page           signup
    Register User       ${signupTest}[4]      ${user}
    Alert Should Be     ${signupAlertNome}
    Alert Should Be     ${signupAlertEmail}
    Alert Should Be     ${signupAlertPassword}

  
Realizar Login
    Open Page                       ${EMPTY}
    Submit Login Form               ${loginTest}[0]      ${user}
    User Should Be Logged In        ${user}


Realizar Login - Email Obrigatório
    Open Page               ${EMPTY}
    Submit Login Form       ${loginTest}[1]      ${user}
    Alert Should Be         ${loginAlertEmail}


Realizar Login - Senha Obrigatória
    Open Page               ${EMPTY}
    Submit Login Form       ${loginTest}[2]      ${user}
    Alert Should Be         ${loginAlertPassword}


Realizar Login - Campos Vazios
    Open Page               ${EMPTY}
    Submit Login Form       ${loginTest}[3]      ${user}
    Alert Should Be         ${loginAlertEmail}
    Alert Should Be         ${loginAlertPassword}