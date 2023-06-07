*** Settings ***
Documentation       Tasks Test Suite for Mark85

Resource            ${EXECDIR}/resources/resource.robot


*** Variables ***



*** Test Cases ***
Create Task
    [Setup]                         Tasks Suite Setup       create
    ${data}                         Load Fixture            tasks           create
    Open Page                       ${EMPTY}
    Submit Login Form               ok                      ${data}[user]
    User Should Be Logged In        ${data}[user]
    Click                           css=a[href$=create]
    Submit Task Form                ${data}[task]
    Task Should Be Registered       ${data}[task][name]


Remove Task
    [Setup]                         Tasks Suite Setup       delete
    ${data}                         Load Fixture            tasks           delete
    API POST Task Helper            ${data}
    Open Page                       ${EMPTY}
    Submit Login Form               ok                      ${data}[user]
    Remove Task                     ${data}[task][name]
    Task Should Not Exist           ${data}[task][name]


Set Task as Done
    [Setup]                         Tasks Suite Setup       done
    ${data}                         Load Fixture            tasks           done
    API POST Task Helper            ${data}
    Open Page                       ${EMPTY}
    Submit Login Form               ok                      ${data}[user]
    Mark as Done Task               ${data}[task][name]
    Task Should be Marked as Done   ${data}[task][name]