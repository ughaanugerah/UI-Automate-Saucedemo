*** Settings ***
Resource               Resource/Login/asset_login.robot

*** Variables ***
${URL}                 https://www.saucedemo.com/
${BROWSER}             Chrome

${Badge_Cart}            //span[@class = 'shopping_cart_badge']

${Text_Title}            //span[@class = 'title']

&{Title_Dict}    Home=Products    Cart=Your Cart
...              Checkout Information=Checkout: Your Information
...              Checkout Overview=Checkout: Overview
...              Checkout Complete=Checkout: Complete!


*** Keywords ***
Open Browser And Login
    I am on the login page
    I get login user from login page
    I Login With Username        ${UserLogin}[0]
    I Login With Password
    @{List_Cart}    Create List
    Set Global Variable        @{List_Cart}

Clean Data Price
    [Arguments]    ${OriginalPrice}
    ${cleaned_value}    Split String    ${OriginalPrice}    $
    ${float_value}      Convert To Number    ${cleaned_value}[1]
    [Return]    ${float_value}
    
Get Cart Item Total
    ${Status}        Run Keyword And Return Status    Get Text            ${Badge_Cart}
    IF    not ${Status}
        ${Item_Count}    Set Variable    ${0}
    ELSE
        ${Item_Count}    Get Text            ${Badge_Cart}
        ${Item_Count}    Convert To Number    ${Item_Count}
    END
    [Return]    ${Item_Count}

Validate Page Title
    [Arguments]    ${Page}
    ${Current_Page}    Get Text    ${Text_Title}
    ${Expected_Page}    Get From Dictionary    ${Title_Dict}    ${Page}
    Should Be Equal As Strings    ${Current_Page}    ${Expected_Page}

Current URL Should Be
    [Arguments]    ${ExpectedURL}
    ${CurrentURL}    Get Location
    Should Be Equal As Strings        ${CurrentURL}    ${ExpectedURL}


Data Cleansing
    [Arguments]     ${data}
    @{NewData}          Split String        ${data}     \n
    Remove From List    ${NewData}          0
    RETURN              ${NewData}

End Test Session
    Capture Page Screenshot
    Close Browser