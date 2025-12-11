*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary
Library    ../Keywords/screenshot_DepositMoney.py

Resource  ../Variables/Variable_DepositMoney.robot

*** Keywords ***
Open Excel file Deposit
    Open Excel Document    ${DataTableDeposit}    ${Sheet}

Open Browser to Deposit Money Page
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option('detach',True)
    Set Selenium Speed    0.5s
    Maximize Browser Window

Login for DepositMoney
    Run Keyword And Ignore Error    ${Loc_MenuLogin} 
    Click Element  ${Loc_MenuLogin}
    Click Element    ${Loc_goLogin} 
    Input Text  ${Loc_Email}  mju6504106383 
    Input Text  ${Loc_Password}  Ptt123445678##
    Click Element  ${Btn_submit}

Deposit Money Link
    Click Element    ${Loc_Deposit_Menu}
    BuiltIn.Sleep    1s
    Click Element    ${Loc_Deposit}
    
Deposit Money Page
    [Arguments]    ${row}
    ${DepositAmount}    Read Excel Cell    ${row}    3
    Click Element    ${Loc_Input_DepositAmount}
    IF    ${DepositAmount} in ['',${None},${EMPTY}] or '${DepositAmount}'.strip() == ''    
        input Text    ${Loc_Input_DepositAmount}    ''    
    ELSE
        Input Text    ${Loc_Input_DepositAmount}    ${DepositAmount}
    END
    
Check Alert Deposit Money
    [Arguments]    ${row}
    Click Element    ${Loc_gen_QR}
    BuiltIn.Sleep    2s
    BuiltIn.Sleep    5s
    ${alert_status}    ${alert_text}=    Run Keyword And Ignore Error    Handle Alert    LEAVE
    Run Keyword And Ignore Error    Write Excel Cell    ${row}    5    ${alert_text}
    BuiltIn.Sleep    2s

Open Browser Omi Brown
    ${OmiBrown}    Run Keyword And Ignore Error    Open Browser    ${Loc_Brownser_omi}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${Loc_UserOmi}    10s
    Input Text    ${Loc_UserOmi}    ${OmiUser}
    Input Text    ${Loc_PassOmi}    ${OmiPass}
    Click Element    ${Btn_LocOmi}

    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${Loc_Pending}
    Run Keyword And Ignore Error    Click Element    ${Loc_Pending}
    Run Keyword And Ignore Error    Click Element    ${Loc_ClickTest}
    Run Keyword And Ignore Error    Click Element    ${Pay_sucess}
    Close Browser


Verify Deposit Money Equal
    [Arguments]    ${Row}

    ${Expected}=    Read Excel Cell    ${Row}    4
    ${Actual}=      Read Excel Cell    ${Row}    5

    ${flag}=    Run Keyword And Return Status    Should Be Equal    ${Expected}    ${Actual}
    Log To Console    Expected: ${Expected}    
    Log To Console    Actual: ${Actual}
    Log To Console    ROW:${{${row}-1}}
    IF    ${flag}
        Write Excel Cell    ${Row}    6    Pass
        Run Keyword And Ignore Error    Handle Alert    ACCEPT
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
    Close All Browsers