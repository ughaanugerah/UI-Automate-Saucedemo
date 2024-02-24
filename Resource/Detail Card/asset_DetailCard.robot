*** Settings ***
Library                SeleniumLibrary
Library                String
Library                Collections

Resource               Resource/asset_master.robot


*** Variables ***
${Button_AddToCard}           //button[@class = 'btn btn_primary btn_small btn_inventory']
${Button_Remove}              //button[@class = 'btn btn_secondary btn_small btn_inventory']
${Button_BackToProduct}       id:back-to-products


*** Keywords ***
Add To Cart on Detail Card
    ${Item_Count}    Get Cart Item Total
    Click Button        ${Button_AddToCard}
    ${Item_Count_After}    Get Cart Item Total
    Should Be Equal As Numbers    ${Item_Count+1}    ${Item_Count_After}


Remove From Cart on Detail Card
    ${Item_Count}    Get Cart Item Total
    Click Button        ${Button_Remove}
    ${Item_Count_After}    Get Cart Item Total
    Should Be Equal As Numbers    ${Item_Count-1}    ${Item_Count_After}

Back To Product
    Click Button    ${Button_BackToProduct}
    Validate Page Title        Home
