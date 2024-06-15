*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections

Resource               Resource/Main Page/asset_filter.robot

*** Keywords ***
I Am On Main Page
    Validate Main Page

I Set Filter to Name A to Z
    Select Filter    AZ

I Set Filter to Name Z to A
    Select Filter    ZA

I Set Filter to Price Low to High
    Select Filter    LoHi

I Set Filter to Price High to Low
    Select Filter    HiLo

Item sorted by Name A to Z
    Validate Item Sort Name    1

Item sorted by Name Z to A
    Validate Item Sort Name    0
    
Item sorted by Price Low to High
    Validate Item Sort Price    1

Item sorted by Price High to Low
    Validate Item Sort Price    0
