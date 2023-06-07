*** Settings ***
Documentation       A resource file containing the trainning app specific keywords and variables for keyword-driven tests that create our own domain specific language. Also SeleniumLibrary itself is imported here so that tests only need to import this resource file.

Library     Browser
Library     abc.py

Resource    ${EXECDIR}/resources/helpers.robot


*** Variables ***


*** Keywords ***
Tasks Suite Setup
    [Arguments]                 ${scenario}
    
    ${data}                     Load Fixture            tasks           ${scenario}
    TRY
        Delete Task From MONGODB    ${data}
    EXCEPT
        Log To Console              User not exist
    FINALLY
        Delete User From MONGODB    ${data}[filter]
        API POST User               ${data}[user]
    END


Submit Task Form
    [Arguments]                 ${task}

    Fill Text                   css=input[placeholder="Nome da tarefa"]     ${task}[name]
    FOR  ${tag}  IN  @{task}[tags]
        Fill Text           css=input[name=tags]        ${tag}
        Keyboard Key        press                       Enter
    END
    Click                       css=button[type=submit] >> text=Cadastrar


Task Should Be Registered
    [Arguments]                 ${task_name}

    Wait For Elements State     css=.task-item >> text=${task_name}     visible     5


Remove Task
    [Arguments]                 ${task_name}
    
    Click                       xpath=//strong[text()="${task_name}"]/..//button[@class="task-remove"]


Task Should Not Exist
    [Arguments]                 ${task_name}

    Wait For Elements State     css=.task-item >> text=${task_name}     detached    5


Mark as Done Task
    [Arguments]                 ${task_name}
    
    Click                       xpath=//strong[text()="${task_name}"]/..//button[@class="item-toggle"]


Task Should be Marked as Done
    [Arguments]                 ${task_name}

    Wait For Elements State     xpath=//strong[text()="${task_name}"]/..//button[@class="item-toggle-selected"]