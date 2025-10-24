*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary
Library  String

Resource  ../Variables/Variable_DepositMoney.robot
Resource  ../Keywords/Keyword_DepositMoney.robot

*** Test Cases ***
Test Deposit Money
    Open Excel file Deposit
    FOR    ${i}    IN RANGE    2    ${Row}+1
        ${Execute}=    Read Excel Cell    ${i}    1
        IF    '${Execute}' == 'Y'
            Open Browser to Deposit Money Page
            Login for DepositMoney
            Deposit Money Link
            Deposit Money Page
            Check Alert Present    ${i}
            Verify Deposit Money Equal    ${i}
            Close Browser Deposit Money
        END
    END
    Save and Close Excel Deposit Money
