*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary
Library    ../Keywords/screenshot_helper.py


Resource  ../Variables/Variable_DepositMoney.robot

*** Keywords ***
Open Excel file Deposit
    Open Excel Document    ${DataTableDeposit}    ${Sheet}

Open Browser to Deposit Money Page
    Open Browser    ${URL}    ${BROWSER}
    Set Selenium Speed    0.5s
    Maximize Browser Window

Login for DepositMoney
    Click Element  ${link_tologin} 
    Input Text  ${Loc_Email}  mju6504106383 
    Input Text  ${Loc_Password}  Ptt123445678##
    Click Element  ${Btn_submit}

Deposit Money Link
    Click Element    ${link_deposit}
    
Deposit Money Page
    ${DepositAmount}    Read Excel Cell    ${row}    3
    
    wait until element is visible    ${Loc_Input_DepositAmount}    timeout=10s
    Run Keyword If  '${DepositAmount}' != '' and '${DepositAmount}' != '${None}' and '${DepositAmount}' != None  Input Text  ${Loc_Input_DepositAmount}  ${DepositAmount}
    Click Element    ${Loc_gen_QR}
    
Check Alert Present
    [Arguments]    ${Row}
    ${alert_text}=    Run Keyword And Ignore Error    Handle Alert    LEAVE
    Run Keyword And Ignore Error    Write Excel Cell    ${Row}    5    ${alert_text}


Verify Deposit Money Equal
    [Arguments]    ${Row}

    ${Expected}=    Read Excel Cell    ${Row}    4
    ${Actual}=      Read Excel Cell    ${Row}    5

    ${flag}=    Run Keyword And Return Status    Should Be Equal    ${Expected}    ${Actual}

    IF    ${flag}
        Write Excel Cell    ${Row}    6    Pass
    ELSE
        Write Excel Cell    ${Row}    6    Fail
        ${path}=    Capture Alert Screenshot    ${Row}
        Log To Console    Screenshot saved at: ${path}
        Run Keyword And Ignore Error    Handle Alert    ACCEPT
    END

    

Save and Close Excel Deposit Money
    Save Excel Document    ${DataTableDeposit}
    Close Current Excel Document

Close Browser Deposit Money
    Close Browser