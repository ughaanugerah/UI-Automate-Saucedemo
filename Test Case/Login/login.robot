*** Settings ***
Library                Collections
Library                SeleniumLibrary
Library                String

Resource               Resource/Login/asset_login.robot

Test Teardown    End Test Session

*** Test Cases ***
Login Using Valid User
    [Documentation]    Test Login Feature using Valid User Data
    Given I Am On The Login Page
    When I Login With Username    standard_user
    And I Login With Password    secret_sauce
    Then I Should Successfully Login

Login Using Locked User
    [Documentation]    Test Login Feature using Locked User Data
    Given I Am On The Login Page
    When I Login With Username    locked_out_user
    And I Login With Password    secret_sauce
    Then I Should Failed Login
    And I Should See Locked User Error Message

Login Using Invalid Password
    [Documentation]    Test Login Feature using Valid Username and Invalid Password
    Given I Am On The Login Page
    When I Login With Username    standard_user
    And I Login With Password    invalid password
    Then I Should Failed Login
    And I Should See Invalid User Error Message

Login Using Invalid Username
    [Documentation]    Test Login Feature using Invalid Username and Invalid Password
    Given I Am On The Login Page
    When I Login With Username    invalid_user
    And I Login With Password    secret_sauce
    Then I Should Failed Login
    And I Should See Invalid User Error Message