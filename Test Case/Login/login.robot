*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections
Resource               Resource/Login/asset_login.robot

*** Test Cases ***
Login Using Valid User
    Open Browser And Get User Login
    Login User    ${UserLogin}[0]
    Capture Page Screenshot
    Close Browser

Login Using Locked Password
    Open Browser And Get User Login
    Login User    ${UserLogin}[1]
    Validate Message Error    ${Message_Error1}
    Capture Page Screenshot
    Close Browser
