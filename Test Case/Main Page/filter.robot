*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections

Resource               Resource/asset_master.robot
Resource               Resource/Main Page/asset_bdd_filter.robot

Test Setup             Open Browser And Login
Test Teardown          End Test Session

*** Variables ***


*** Test Cases ***
Validate Filter Name Ascending
    Given I Am On Main Page
    When I Set Filter To Name A To Z
    Then Item Sorted By Name A To Z

Validate Filter Name Descending
    Given I Am On Main Page
    When I Set Filter To Name Z To A
    Then Item Sorted By Name Z To A

Validate Filter Price Ascending
    Given I Am On Main Page
    When I Set Filter To Price Low To High
    Then Item Sorted By Price Low To High

Validate Filter Price Descending
    Given I Am On Main Page
    When I Set Filter To Price High To Low
    Then Item Sorted By Price High To Low

