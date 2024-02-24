*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections

Resource               Resource/asset_master.robot
Resource               Resource/Detail Card/asset_DetailCard.robot
Resource               Resource/Main Page/asset_MainPage.robot

Test Setup             Open Browser And Login
Test Teardown          Close Browser

*** Test Cases ***
View Detail Card
    Select Card By Picture    Sauce Labs Backpack
    Add To Cart on Detail Card
    Back To Product
    Select Card By Name        Sauce Labs Backpack
    Remove From Cart on Detail Card
    Back To Product