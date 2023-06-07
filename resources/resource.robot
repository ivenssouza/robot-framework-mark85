*** Settings ***
Documentation       A resource file

Library             Collections
Library             RequestsLibrary

Library             RobotMongoDBLibrary.Insert
Library             RobotMongoDBLibrary.Update
Library             RobotMongoDBLibrary.Find
Library             RobotMongoDBLibrary.Delete

Resource            helpers.robot

Resource            pages/components/noticeAlert.robot
Resource            pages/components/nav.robot
Resource            pages/signup.robot
Resource            pages/login.robot
Resource            pages/tasks.robot


*** Variables ***

${BROWSER}      chromium
${HEADLESS}     true
${DELAY}        0
${URL}          http://localhost:3000/
${URL_API}      http://localhost:3333/

*** Keywords ***
Open Page
    [Arguments]                 ${page}

    New Browser                 headless=${HEADLESS}        browser=${BROWSER}
    New Page                    ${URL}${page}


Delete User
    [Arguments]                 ${data}

    Delete User From MONGODB    ${data}[filter]
    ${response}                 POST                        url=${URL_API}users     json=${data}[user]
    Status Should Be            200                         ${response}