*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections

Resource               Resource/asset_master.robot

*** Variables ***
${Item_Name}            (//div[@class ='inventory_item_name '])
${Item_Price}           (//div[@class ='inventory_item_price'])


${Locator_Filter}       //select[@data-test='product-sort-container']

${Option_AZ}            //option[@value = 'az']
${Option_ZA}            //option[@value = 'za']
${Option_LoHi}          //option[@value = 'lohi']
${Option_HiLo}          //option[@value = 'hilo']

*** Keywords ***
Collect Data
    [Arguments]    ${Item_Locator}
    ${Item_Count}    Get Element Count    ${Item_Locator}
    Convert To Integer    ${Item_Count}
    @{Item_List}    Create List
    
    FOR    ${index}    IN RANGE    1    ${Item_Count}+1
        ${Locator}    Evaluate    "${Item_Locator}"+"[${index}]"
        ${GetItemText}    Get Text    ${Locator}
        Append To List    ${Item_List}    ${GetItemText}
    END
    [Return]    ${Item_List}

Validate Main Page
    Validate Page Title    Home
    Element Should Be Visible    ${Locator_Filter}
    
Select Filter
    [Arguments]    ${Filter}
    Click Element    ${Locator_Filter}
    IF        $Filter == "AZ"
        ${Locator}    Set Variable    ${Option_AZ}
    ELSE IF   $Filter == "ZA"
        ${Locator}    Set Variable    ${Option_ZA}
    ELSE IF   $Filter == "LoHi"
        ${Locator}    Set Variable    ${option_LoHi}
    ELSE IF   $Filter == "HiLo"
        ${Locator}    Set Variable    ${option_HiLo}
    END
    Wait Until Element Is Visible    ${Locator}
    Click Element    ${Locator}

Validate Item Sort Name
    [Arguments]    ${IsAscending}=1

    ${Data_List}    Collect Data    ${Item_Name}
    
    ${Expected_Data_List}    Get Expected Data List    ${Data_List}    ${IsAscending}

    Lists Should Be Equal    ${Data_List}    ${Expected_Data_List}

Validate Item Sort Price
    [Arguments]    ${IsAscending}=1
    ${Data_List}    Collect Data    ${Item_Price}
    ${Clean_Data_List}    Clean Data Price    ${Data_List}
    ${Expected_Data_List}    Get Expected Data List    ${Clean_Data_List}    ${IsAscending}
    ${Formatted_Data_List}    Reformat Data List    ${Expected_Data_List}

    Lists Should Be Equal    ${Data_List}    ${Formatted_Data_List}


Get Expected Data List
    [Arguments]    ${Data_List}    ${IsAscending}=1    
    IF    ${IsAscending} == 1
        ${Expected_Data_List}     Evaluate    sorted(${Data_List})
    ELSE IF    ${IsAscending} == 0
        ${Expected_Data_List}     Evaluate    sorted(${Data_List}, reverse=True)
    ELSE
        Fail    "Argument Tidak Valid"
    END

    [Return]    ${Expected_Data_List}

Clean Data Price
    [Arguments]    ${List_Price}
    ${Clean_List_Price}    Create List
    FOR    ${price}    IN    @{List_Price}
        ${Price_Split}    Split String    ${price}    $
        ${Price_Number}    Convert To Number    ${Price_Split[1]}
        Append To List    ${Clean_List_Price}    ${Price_Number}
    END
    [Return]    ${Clean_List_Price}
    
Reformat Data List
    [Arguments]    ${List_Price}
    ${Format_List_Price}    Create List
    FOR    ${price}    IN    @{List_Price}
        ${Price_Formatted}    Set Variable    \$${price}
        Append To List    ${Format_List_Price}    ${Price_Formatted}
    END
    [Return]    ${Format_List_Price}
    