*** Settings ***
Library                SeleniumLibrary
Library                String

*** Variables ***
${Locator_AddToCart}              //div[text() = '@Param']//ancestor::div[@class='inventory_item_label']/following-sibling::div/button
${Locator_Description}            //div[text() = '@Param']/parent::a/following-sibling::div
${Locator_Price}                  //div[text() = '@Param']/ancestor::div[@class = 'inventory_item_label']/following-sibling::div/div[@class = 'inventory_item_price']

${Locator_Cart_Name}              (//div[@class='cart_item'])[@Num]//div[@class='inventory_item_name']
${Locator_Cart_Description}       (//div[@class='cart_item'])[@Num]//div[@class='inventory_item_desc']
${Locator_Cart_Price}             (//div[@class='cart_item'])[@Num]//div[@class='inventory_item_price']

${Button_Cart}                    //div[@id = 'shopping_cart_container']

${Item_Cart_Locator}              //div[@class = 'cart_item']


*** Keywords ***
Select Item
    [Arguments]    ${Item}
    ${Button_AddToCart}    Replace String        ${Locator_AddToCart}    @Param        ${Item}
    Click Button    ${Button_AddToCart}

Click Cart
    Wait Until Element Is Visible    ${Button_Cart}
    Click Element   ${Button_Cart}
    
Get Data Item
    [Arguments]    ${Item}
    ${Description}      Replace String        ${Locator_Description}      @Param        ${Item}
    ${Price}            Replace String        ${Locator_Price}            @Param        ${Item}

    ${Value_Description}    Get Text    ${Description}
    ${Value_Harga}          Get Text    ${Price}

Validate Item Cart
    ${Item_Cart}    Get Element Count        ${Item_Cart_Locator}

    FOR     ${Row}   IN RANGE    1    ${Item_Cart + 1}
        ${Name}           Replace String        ${Locator_Cart_Name}          @Num        '${Row}'
        ${Description}    Replace String        ${Locator_Cart_Description}   @Num        '${Row}'
        ${Price}          Replace String        ${Locator_Cart_Price}         @Num        '${Row}'

        ${Value_Name}            Get Text    ${Name}
        ${Value_Description}     Get Text    ${Description}
        ${Value_Price}           Get Text    ${Price}

        Log    ${Value_Name}
        Log    ${Value_Description}
        Log    ${Value_Price}

    END
    