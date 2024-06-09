*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections

Resource               Resource/asset_master.robot
Resource               Resource/Main Page/asset_MainPage.robot


*** Variables ***

${Locator_Cart_Name}              (//div[@class='cart_item'])[@Num]//div[@class='inventory_item_name']
${Locator_Cart_Description}       (//div[@class='cart_item'])[@Num]//div[@class='inventory_item_desc']
${Locator_Cart_Price}             (//div[@class='cart_item'])[@Num]//div[@class='inventory_item_price']

${Button_Cart}                    id:shopping_cart_container
${Button_Checkout}                id:checkout
${Button_Continue}                id:continue
${Button_Finish}                  id:finish
${Button_BackHome}                id:back-to-products

${Item_Cart_Locator}              //div[@class = 'cart_item']

${Input_FirstName}                id:first-name
${Input_LastName}                 id:last-name
${Input_PostalCode}               id:postal-code

${Form_CheckoutComplete}          id:checkout_complete_container

${Text_PaymentInformationLabel}   //div[@data-test='payment-info-label']
${Text_PaymentInformationValue}   //div[@data-test='payment-info-value']
${Text_ShippingInformationLabel}  //div[@data-test='shipping-info-value']
${Text_ShippingInformationValue}  //div[@data-test='shipping-info-value']
${Text_PriceTotalLabel}           //div[@data-test='total-info-label']
${Text_ItemTotal}                 //div[@data-test='subtotal-label']
${Text_Tax}                       //div[@data-test='tax-label']
${Text_Total}                     //div[@data-test='total-label']
${Text_CheckoutCompleteHeader}    //h2[@class ='complete-header']
${Text_CheckoutComplete}          //div[@class='complete-text']
${Text_ErrorMessage}              //h3[@data-test='error']



*** Keywords ***
Select Item Then Open Cart
    [Arguments]    ${Item_Name}
    Select Item                ${Item_Name}
    Click Cart

Click Cart
    Wait Until Element Is Visible    ${Button_Cart}
    Click Element   ${Button_Cart}
    Validate Page Title        Cart

Validate Checkout Information Page
    Validate Page Title        Checkout Information
    Element Should Be Visible    ${Input_FirstName}
    Element Should Be Visible    ${Input_LastName}
    Element Should Be Visible    ${Input_PostalCode}

Validate Checkout Overview Page
    Validate Page Title          Checkout Overview
    Element Should Be Visible    ${Text_PaymentInformationLabel}
    Element Should Be Visible    ${Text_PaymentInformationValue}
    Element Should Be Visible    ${Text_ShippingInformationLabel}
    Element Should Be Visible    ${Text_ShippingInformationValue}
    Element Should Be Visible    ${Text_PriceTotalLabel}
    Element Should Be Visible    ${Text_ItemTotal}
    Element Should Be Visible    ${Text_Tax}
    Element Should Be Visible    ${Text_Total}

Validate Error Message Text
    [Arguments]     ${Expected_Message}
    ${Message}  Get Text    ${Text_ErrorMessage}
    Should Be Equal As Strings    ${Message}    ${Expected_Message}


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
    Validate Page Title        Checkout Information

Input Information
    [Arguments]    ${FirstName}    ${LastName}    ${PostalCode}
    Wait Until Element Is Visible    ${Input_FirstName}
    Input Text    ${Input_FirstName}    ${FirstName}
    Input Text    ${Input_LastName}    ${LastName}
    Input Text    ${Input_PostalCode}    ${PostalCode}
    Capture Page Screenshot
    Click Button    ${Button_Continue}

Click Continue to Checkout Overview
    Validate Page Title        Checkout Overview
    Calculate Price
    Calculate Tax
    Calculate Grand Total

Validate Item Total Price
    ${Expected_SubTotal}    Get Expected Sub Total
    Should Be Equal As Numbers    ${Expected_SubTotal}    ${SubTotal}

Calculate Price
    ${SubTotalText}    Get Text    ${Text_ItemTotal}
    ${SubTotal}    Clean Data Price    ${SubTotalText}

    Set Global Variable    ${SubTotal}

Calculate Tax
    ${Expected_Tax}    Get Expected Tax    ${SubTotal}
    
    ${TaxText}        Get Text    ${Text_SummaryTax}
    ${Tax}        Clean Data Price    ${TaxText}
    Should Be Equal As Numbers    ${Tax}    ${Expected_Tax}

    Set Global Variable    ${Tax}

Calculate Grand Total
    ${GrandTotalText}        Get Text    ${Text_SummaryGrandTotal}
    ${GrandTotal}            Clean Data Price    ${GrandTotalText}
    
    ${Expected_GrandTotal}   Evaluate    $SubTotal + $Tax
    Should Be Equal As Numbers    ${GrandTotal}    ${Expected_GrandTotal}
    

    
Get Expected Sub Total
    ${Sub_Total}    Set Variable    ${0.0}
    FOR     ${Data}    IN    @{List_Cart}
        ${Price}    Get From Dictionary        ${Data}    Price
        ${CleanedPrice}        Clean Data Price    ${Price}
        ${Sub_Total}    Evaluate    $Sub_Total + float($CleanedPrice)
    END
    [Return]    ${Sub_Total}

Get Expected Tax
    [Arguments]    ${SubTotal}
    ${ExpectedTax}    Evaluate    $Subtotal*8/100 
    ${Tax}    Convert To Number    ${ExpectedTax}    2
    [Return]    ${Tax}

Finish Transaction
    Click Button                    ${Button_Finish}
    Validate Page Title             Checkout Complete
    Element Should Be Visible       ${Form_CheckoutComplete}
    ${Wording_Header}            Get Text        ${Text_CheckoutCompleteHeader}
    ${Wording_Complete}          Get Text        ${Text_CheckoutComplete}
    Evaluate    $Wording_Header == 'Thank you for your order!'
    Evaluate    $Wording_Complete == 'Your order has been dispatched, and will arrive just as fast as the pony can get there!'
    Click Button                 ${Button_BackHome}

