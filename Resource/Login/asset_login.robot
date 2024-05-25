*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections
Resource               Resource/asset_master.robot

*** Variables ***
${Text_UserLogin}       //div[@id = 'login_credentials']
${Text_Password}        //div[@class = 'login_password']
${Text_HomeTitle}       //div[@class ='app_logo']

${Input_Username}       //input[@id = 'user-name']
${Input_Password}       //input[@id = 'password']

${Button_Login}         //input[@id = 'login-button']

${PopUp_Message}        //div[@class = 'error-message-container error']


${LoginURL}            https://www.saucedemo.com/
${HomePageURL}         https://www.saucedemo.com/inventory.html

@{UserLogin}
@{Password}

${Message_LockedError}       Epic sadface: Sorry, this user has been locked out.
${Message_InvalidUser}       Epic sadface: Username and password do not match any user in this service

*** Keywords ***
I am on the login page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

I get login user from login page
    @{UserLogin}    Create List
    @{Password}     Create List

    Wait Until Element Is Visible           ${Text_UserLogin}
    ${List_Username}    Get Text            ${Text_UserLogin}
    ${UserLogin}        Data Cleansing      ${List_Username}
    ${List_Password}    Get Text            ${Text_Password}
    @{Password}         Data Cleansing      ${List_Password}

    Set Global Variable    ${UserLogin}
    Set Global Variable    ${Password}

I login with Username
    [Arguments]     ${User}
    Input Text      ${Input_Username}   ${User}

I Login With Password
    [Arguments]    ${Pass}=${Password}[0]
    Input Text      ${Input_Password}   ${Pass}
    Click Element   ${Button_Login}

I Should Successfully Login
    Title Should Be    Swag Labs
    Current URL Should Be    ${HomePageURL}

I Should Failed Login
    Title Should Be    Swag Labs
    Current URL Should Be    ${LoginURL}

I Should See Locked User Error Message
    Validate Message Error    ${Message_LockedError}

I Should See Invalid User Error Message
    Validate Message Error    ${Message_InvalidUser}

Validate Message Error
    [Arguments]     ${Expected_Message}
    ${Message}  Get Text    ${PopUp_Message}
    Should Be Equal As Strings    ${Message}    ${Expected_Message}
