*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections

Resource               Resource/asset_master.robot
Resource               Resource/Checkout/asset_checkout.robot
Resource               Resource/Main Page/asset_MainPage.robot

Test Setup             Open Browser And Login
Test Teardown          Close Browser

*** Test Cases ***
Check Out 1 Item
    Select Item                Sauce Labs Backpack
    Click Cart
    Validate Item Cart
    Click Checkout
    Input Information          Ugha    anugerah    123456
    Calculate Price
    Calculate Tax
    Calculate Grand Total
    Finish Transaction

Check Out 3 Items
    Select Item                Sauce Labs Backpack
    Select Item                Test.allTheThings() T-Shirt (Red)
    Select Item                Sauce Labs Bolt T-Shirt
    Click Cart
    Validate Item Cart
    Click Checkout
    Input Information          Ugha    anugerah    123456

    Finish Transaction
    
