*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections

*** Variables ***
${Locator_AddToCart}              //div[text() = '@Param']//ancestor::div[@class='inventory_item_label']/following-sibling::div/button
${Locator_Description}            //div[text() = '@Param']/parent::a/following-sibling::div
${Locator_Price}                  //div[text() = '@Param']/ancestor::div[@class = 'inventory_item_label']/following-sibling::div/div[@class = 'inventory_item_price']

${Locator_Cart_Name}              (//div[@class='cart_item'])[@Num]//div[@class='inventory_item_name']
${Locator_Cart_Description}       (//div[@class='cart_item'])[@Num]//div[@class='inventory_item_desc']
${Locator_Cart_Price}             (//div[@class='cart_item'])[@Num]//div[@class='inventory_item_price']

${Button_Cart}                    id:shopping_cart_container
${Button_Checkout}                id:checkout
${Button_Continue}                id:continue

${Item_Cart_Locator}              //div[@class = 'cart_item']

${Input_FirstName}                id:first-name
${Input_LastName}                 id:last-name
${Input_PostalCode}               id:postal-code


@{List_Cart}

*** Keywords ***
Select Item
    [Arguments]    ${Item}
    ${temp_var}        Create Dictionary
    Set Global Variable    ${List_Cart}
    
    ${Button_AddToCart}     Replace String        ${Locator_AddToCart}    @Param        ${Item}
    ${Description}          Replace String        ${Locator_Description}      @Param        ${Item}
    ${Price}                Replace String        ${Locator_Price}            @Param        ${Item}

    ${Value_Description}    Get Text    ${Description}
    ${Value_Price}          Get Text    ${Price}
    Click Element           ${Button_AddToCart}

    ${temp_var}    Create Dictionary    Item=${Item}    Description=${Value_Description}    Price=${Value_Price}
    Append To List    ${List_Cart}    ${temp_var}

Click Cart
    Wait Until Element Is Visible    ${Button_Cart}
    Click Element   ${Button_Cart}


Validate Item Cart
    ${Item_Cart}    Get Element Count        ${Item_Cart_Locator}
    @{Expected_Item_Cart}    Create List    
    ${temp_var}        Create Dictionary

    FOR     ${Row}   IN RANGE    1    ${Item_Cart + 1}
        ${RowStr}    Convert To String    ${Row}
        ${Name}           Replace String        ${Locator_Cart_Name}          @Num        ${RowStr}
        ${Description}    Replace String        ${Locator_Cart_Description}   @Num        ${RowStr}
        ${Price}          Replace String        ${Locator_Cart_Price}         @Num        ${RowStr}

        ${Value_Name}            Get Text    ${Name}
        ${Value_Description}     Get Text    ${Description}
        ${Value_Price}           Get Text    ${Price}

        ${temp_var}    Create Dictionary    Item=${Value_Name}    Description=${Value_Description}    Price=${Value_Price}
        Append To List    ${Expected_Item_Cart}    ${temp_var}
    END

    Lists Should Be Equal    ${Expected_Item_Cart}    ${List_Cart}
    
Click Checkout
    Wait Until Element Is Visible    ${Button_Checkout}
    Click Button                     ${Button_Checkout}

Input Information
    [Arguments]    ${FirstName}    ${LastName}    ${PostalCode}
    Wait Until Element Is Visible    ${Input_FirstName}
    Input Text    ${Input_FirstName}    ${FirstName}
    Input Text    ${Input_LastName}    ${LastName}
    Input Text    ${Input_PostalCode}    ${PostalCode}
    Capture Page Screenshot
    Click Button    ${Button_Continue}

Calculate Price
    ${Expected_SubTotal}    Get Expected Sub Total
    
    ${SubTotal}    Get Text
    

    
    
Get Expected Sub Total
    ${Sub_Total}    Set Variable    ${0.0}
    FOR     ${Data}    IN    @{List_Cart}
        ${Price}    Get From Dictionary        ${Data}    Price
        ${CleanedPrice}        Clean Data Price    ${Price}
        ${Sub_Total}    Evaluate    $Sub_Total + float($CleanedPrice)
    END
    [Return]    ${Sub_Total}

Clean Data Price
    [Arguments]    ${OriginalPrice}
    ${cleaned_value}    Remove String        ${OriginalPrice}    $
    ${float_value}      Convert To Number    ${cleaned_value}
    [Return]    ${float_value}