*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections

Resource               Resource/asset_master.robot
Resource               Resource/Checkout/asset_bdd_checkout.robot

Test Setup             Open Browser And Login
Test Teardown          End Test Session

*** Test Cases ***
Check Checkout Information Form
    Given I Add 1 Item To Cart    Sauce Labs Backpack
    When I Click Checkout Button
    Then Checkout Information Form Will Visible

Check Checkout Information Form Valid Input
    Given I Add 1 Item To Cart    Sauce Labs Backpack
    And I Click Checkout Button
    When I Input Valid Personal Information
    Then Checkout Overview Will Visible

Check Checkout Information Form Invalid Input on First Name
    Given I Add 1 Item To Cart    Sauce Labs Backpack
    And I Click Checkout Button
    When I Input Empty On First Name Personal Information
    Then Error Message On Checkout Information Will Visible    Error: First Name is required

Check Checkout Information Form Invalid Input on Last Name
    Given I Add 1 Item To Cart    Sauce Labs Backpack
    And I Click Checkout Button
    When I Input Empty On Last Name Personal Information
    Then Error Message On Checkout Information Will Visible    Error: Last Name is required

Check Checkout Information Form Invalid Input on Postal Code
    Given I Add 1 Item To Cart    Sauce Labs Backpack
    And I Click Checkout Button
    When I Input Empty On Postal Code Personal Information
    Then Error Message On Checkout Information Will Visible    Error: Postal Code is required

Check Sub Total on Checkout Overview
    Given I Add 1 Item To Cart    Sauce Labs Backpack
    And I Click Checkout Button
    And I Input Valid Personal Information
    When I Calculate Item Price
    Then Item Total Price Will Be Sum Of All Items

Check Tax Item on Checkout Overview
    Given I Add 1 Item To Cart    Sauce Labs Backpack
    And I Click Checkout Button
    And I Input Valid Personal Information
    When I Calculate Item Tax
    Then Item Total Price Will Be Sum Of All Items

Check Item Total on Checkout Overview
    Given I Add 1 Item To Cart    Sauce Labs Backpack
    And I Click Checkout Button
    And I Input Valid Personal Information
    When I Calculate Item Tax
    Then Item Total Price Will Be Sum Of All Items



