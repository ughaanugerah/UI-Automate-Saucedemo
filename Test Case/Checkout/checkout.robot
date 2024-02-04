*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections

Resource               Resource/asset_master.robot
Resource               Resource/Checkout/asset_checkout.robot

*** Test Cases ***
Check Out 1 Item
    Open Browser And Login
    Select Item                Sauce Labs Backpack
    Select Item                Sauce Labs Bike Light
    Click Cart
    Validate Item Cart
    Click Checkout
    Input Information          Ugha    anugerah    123456
    #Calculate Price
    Finish Transaction
