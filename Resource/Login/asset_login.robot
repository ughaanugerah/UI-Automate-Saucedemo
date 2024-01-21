*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections
Resource               Resource/asset_master.robot

*** Variables ***
${Text_UserLogin}       //div[@id = 'login_credentials']
${Text_Password}        //div[@class = 'login_password']

${Input_Username}       //input[@id = 'user-name']
${Input_Password}       //input[@id = 'password']

${Button_Login}         //input[@id = 'login-button']

${PopUp_Message}        //div[@class = 'error-message-container error']

${Message_Error1}       Epic sadface: Sorry, this user has been locked out.

@{UserLogin}
@{Password}


*** Keywords ***
Open Browser And Get User Login
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    @{UserLogin}    Create List
    @{Password}     Create List

    Wait Until Element Is Visible           ${Text_UserLogin}
    ${List_Username}    Get Text            ${Text_UserLogin}
    ${UserLogin}        Data Cleansing      ${List_Username}
    ${List_Password}    Get Text            ${Text_Password}
    @{Password}         Data Cleansing      ${List_Password}

    Set Global Variable    ${UserLogin}
    Set Global Variable    ${Password}

Data Cleansing
    [Arguments]     ${data}
    @{NewData}          Split String        ${data}     \n
    Remove From List    ${NewData}          0
    RETURN              ${NewData}

Login User
    [Arguments]     ${User}     ${Pass}=${Password}[0]
    Input Text      ${Input_Username}   ${User}
    Input Text      ${Input_Password}   ${Pass}
    Click Element   ${Button_Login}

Validate Message Error
    [Arguments]     ${Expected_Message}
    ${Message}  Get Text    ${PopUp_Message}
    Evaluate    $Message == $Expected_Message
