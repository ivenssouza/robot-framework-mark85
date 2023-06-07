*** Settings ***
Documentation        Helpers

Library              JSONLibrary
Library              libs/mark85_api.py

Library              Collections
Library              RequestsLibrary

Library              RobotMongoDBLibrary.Insert
Library              RobotMongoDBLibrary.Update
Library              RobotMongoDBLibrary.Find
Library              RobotMongoDBLibrary.Delete

*** Variables ***
# CONNECT WITH CONNECTION STRING CLUSTER
&{MONGODB_CONNECT_STRING_USERS}     connection=mongodb+srv://qax:xperience@cluster0.vcrmeiw.mongodb.net/?retryWrites=true&w=majority    database=test   collection=users

&{MONGODB_CONNECT_STRING_TASKS}     connection=mongodb+srv://qax:xperience@cluster0.vcrmeiw.mongodb.net/?retryWrites=true&w=majority    database=test   collection=tasks

${URL_API}                          http://localhost:3333/

${token}


*** Keywords ***
Load Fixture
    [Arguments]             ${filename}             ${scenario}

    ${data}                 Load Json From File     ${EXECDIR}/resources/fixtures/${filename}.json        encoding=utf-8
    [return]                ${data}[${scenario}]


#API CALLS LIB
API New User Helper
    [Arguments]             ${user}
    
    Api New User Lib        ${user}


#API CALLS BROWSER
API POST User
    [Arguments]             ${user}
    
    ${body}                 Create Dictionary       name=${user}[name]                  email=${user}[email]        password=${user}[password]
    ${response}             POST                    url=${URL_API}users                 json=${body}
    Set Suite Variable      ${token}


API Login Helper
    [Arguments]             ${data}
    
    ${body}                 Create Dictionary       email=${data}[user][email]          password=${data}[user][password]
    ${response}             POST                    url=${URL_API}sessions              json=${body}
    ${token}                Set Variable            ${response.json()}[token]
    Set Suite Variable      ${token}


API POST Task Helper
    [Arguments]             ${data}

    API Login Helper        ${data}
    ${header}               Create Dictionary       authorization=${token}
    ${response}             POST                    url=${URL_API}tasks                 json=${data}[task]      headers=${header}
    Status Should Be        200                     ${response}


API GET Task Helper
    [Arguments]             ${data}

    API Login Helper        ${data}
    ${header}               Create Dictionary       authorization=${token}
    ${response}             GET                     url=${URL_API}tasks                 headers=${header}
    Status Should Be        200                     ${response}
    [return]                ${response.json()}


#MONGODB FUNCTIONS
Find User MONGODB
    [Arguments]             ${filter}

    ${RESULTS}              Find                    ${MONGODB_CONNECT_STRING_USERS}     ${filter}
    [return]                len(${RESULTS})
        

Add User MONGODB
    [Arguments]             ${user}

    ${MSG}                  InsertOne               ${MONGODB_CONNECT_STRING_USERS}     ${user}
    #Should Be Equal         ${MSG}                  INSERTED SUCCESS
    Log                     User added in mongodb


Delete User From MONGODB
    [Arguments]             ${filter}

    ${MSG}                  Delete One              ${MONGODB_CONNECT_STRING_USERS}     ${filter}
    #Should Be Equal         ${MSG}                  DELETED SUCCESS
    Log                     User removed form mongodb


Delete Task From MONGODB
    [Arguments]             ${data}

    ${len}                  Find User MONGODB            ${data}[filter]

    IF  ${len} > 0

        ${tasks}                 API GET Task Helper         ${data}
        IF  len(${tasks}) > 0
            FOR    ${task}    IN    ${tasks}
                ${MSG}                  Delete One By ID        ${MONGODB_CONNECT_STRING_TASKS}       ${task}[0][_id]
                #Should Be Equal         ${MSG}                  DELETED SUCCESS
                Log                     Task removed form mongodb
            END
        END
    END