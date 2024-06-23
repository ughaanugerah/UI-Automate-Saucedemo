*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections

Resource               Resource/Checkout/asset_checkout.robot


*** Variables ***


*** Keywords ***

I Add 1 Item To Cart
    [Arguments]    ${Item_Name}
    Select Item Then Open Cart    ${Item_Name}

I Click Checkout Button
    Click Checkout

I Checkout 1 Item
    [Arguments]    ${Item_Name}
    Select Item Then Open Cart    ${Item_Name}
    Click Checkout

I Input Valid Personal Information
    Input Information    Ugha    Anugerah    90234

I Input Empty On First Name Personal Information
    Input Information    ${EMPTY}    Anugerah    90234

I Input Empty On Last Name Personal Information
    Input Information    Ugha    ${EMPTY}    90234
    
I Input Empty On Postal Code Personal Information
    Input Information    Ugha    Anugerah    ${EMPTY}

I Calculate Item Price
    Calculate Price

I Calculate Item Tax
    Calculate Tax

Checkout Information Form Will Visible
    Validate Checkout Information Page

Checkout Overview Will Visible
    Validate Checkout Overview Page

Error Message On Checkout Information Will Visible
    [Arguments]     ${Expected_Message}
    Validate Error Message Text    ${Expected_Message}

Item Total Price Will Be Sum of All Items
    Validate Item Total Price

Item Total Tax Will Be 8 Percent
    Validate Item Tax