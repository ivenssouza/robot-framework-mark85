*** Settings ***
Documentation       A resource file containing the trainning app specific keywords and variables for keyword-driven tests that create our own domain specific language. Also SeleniumLibrary itself is imported here so that tests only need to import this resource file.
#Library             Browser
#Library             String

Library   RobotMongoDBLibrary.Insert
Library   RobotMongoDBLibrary.Update
Library   RobotMongoDBLibrary.Find
Library   RobotMongoDBLibrary.Delete

Resource           pages/components.robot
Resource           pages/signup.robot
Resource           pages/login.robot

*** Variables ***
# CONNECT WITH CONNECTION STRING CLUSTER
@{MONGODB_COLLECTIONS}          users       tasks
&{MONGODB_CONNECT_STRING}       connection=mongodb+srv://qax:xperience@cluster0.vcrmeiw.mongodb.net/?retryWrites=true&w=majority    database=test   collection=users


${BROWSER}      chromium
${HEADLESS}     true
${DELAY}        0
${URL}          http://localhost:3000/

*** Keywords ***
#Start Session
#    New Browser        browser=chromium    headless=False
#    New Page           http://localhost:3000

#Go to signup
#    Go To           http://localhost:3000/signup
#    Get Text        css=form h1        equal        Faça seu cadastro


Open Page
    [Documentation]     Returns the title of the webpage found at the given URL.

    [Arguments]         ${page}

    New Browser         headless=${HEADLESS}      browser=${BROWSER}
    New Page            ${URL}${page}


Remove User From Mongo
    [Arguments]     ${filter}
    ${MSG}      Delete One      ${MONGODB_CONNECT_STRING}       ${filter}
    Log        Users removed form mongodb