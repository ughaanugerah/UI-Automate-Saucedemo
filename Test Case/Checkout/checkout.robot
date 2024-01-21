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
    Get Data Item              Sauce Labs Backpack
    Click Cart
    Validate Item Cart
    Capture Page Screenshot

Looping for
    FOR    ${data}    IN RANGE    1     5
        Log    ${data}
    END