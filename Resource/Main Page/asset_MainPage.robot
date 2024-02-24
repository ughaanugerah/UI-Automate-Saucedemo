*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections

*** Variables ***
${Locator_AddToCart}              //div[text() = '@Param']//ancestor::div[@class='inventory_item_label']/following-sibling::div/button
${Locator_Description}            //div[text() = '@Param']/parent::a/following-sibling::div
${Locator_Price}                  //div[text() = '@Param']/ancestor::div[@class = 'inventory_item_label']/following-sibling::div/div[@class = 'inventory_item_price']
${Locator_Title}                  //div[@class='inventory_item_name ' and text()='@Param']
${Locator_Picture}                //img[@class='inventory_item_img' and @alt='@Param']


${Locator_ItemName}        //div[@class = 'inventory_item_name ']
${Locator_Price}           //div[@class = 'inventory_item_price']


*** Keywords ***
Select Item
    [Arguments]    ${Item}
    ${temp_var}        Create Dictionary
    ${Button_AddToCart}     Replace String        ${Locator_AddToCart}    @Param        ${Item}
    ${Description}          Replace String        ${Locator_Description}      @Param        ${Item}
    ${Price}                Replace String        ${Locator_Price}            @Param        ${Item}

    ${Value_Description}    Get Text    ${Description}
    ${Value_Price}          Get Text    ${Price}
    Scroll Element Into View    ${Button_AddToCart}
    Click Element               ${Button_AddToCart}

    ${temp_var}    Create Dictionary    Item=${Item}    Description=${Value_Description}    Price=${Value_Price}
    Append To List    ${List_Cart}    ${temp_var}

Select Card by Picture
    [Arguments]    ${Item}
    ${Button_Picture}     Replace String        ${Locator_Picture}    @Param        ${Item}
    Scroll Element Into View    ${Button_Picture}
    Click Element               ${Button_Picture}


Select Card by Name
    [Arguments]    ${Item}
    ${Button_Title}     Replace String        ${Locator_Title}    @Param        ${Item}
    Scroll Element Into View    ${Button_Title}
    Click Element               ${Button_Title}