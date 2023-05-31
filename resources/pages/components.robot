*** Settings ***
Documentation       COMPONENTS
Library             Browser


*** Keywords ***
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