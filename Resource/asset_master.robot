*** Settings ***
Resource               Resource/Login/asset_login.robot

*** Variables ***
${URL}                 https://www.saucedemo.com/
${BROWSER}             Chrome

*** Keywords ***
Open Browser And Login
    Open Browser And Get User Login
    Login User    ${UserLogin}[0]
    @{List_Cart}    Create List
    Set Global Variable        @{List_Cart}