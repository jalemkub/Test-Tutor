*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    ../Keywords/screenshot_RequestWithdraw.py
Resource    ../Variables/Variable_RequestWithdraw.robot

*** Keywords ***
Open Browser Website
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option('detach',True)
    set selenium speed    0.5s
    Maximize Browser Window

Open Excel Request Withdraw
    Open Excel Document    ${DataTableRequestWithdraw}    ${Sheet}

Go to Login Page for Request Withdraw
    [Arguments]    ${row}
    Click Element    ${Loc_tologinmenu}
    BuiltIn.Sleep    1s
    Click Element    ${Loc_tologin}
    Input Text    ${Loc_Email}    mju6504106383
    Input Text    ${Loc_Password}    Ptt123445678##
    Click Element    ${Btn_submit}

Go to Request Withdraw Page
    [Arguments]    ${row}
    ${BankName}=    Read Excel Cell    ${row}    3
    ${Number}    Read Excel Cell    ${row}    4
    ${Amount}    Read Excel Cell    ${row}    5

    Click Element    ${Loc_PathMenu}
    Click Element    ${Loc_PathRequestWithdraw}

    ${should_select_ฺBank}=    Evaluate    '${BankName}' != '' and '${BankName}' != 'กรุณาเลือกธนาคาร' and '${BankName}' != '${None}' and '${BankName}' != '${None}'
    Run Keyword If    ${should_select_ฺBank}    
    ...    Select From List By Label    ${SubjectCategory}    ${BankName}

    Run Keyword If    '${AccountNumber}' != '' and '${AccountNumber}' != '${None}' and '${AccountNumber}' != 'None'    
    ...    Input Text    ${AccountNumber}    ${Number}
    Run Keyword If    '${AmountWithdraw}' != '' and '${AmountWithdraw}' != '${None}' and '${AmountWithdraw}' != 'None'   
    ...    Input Text    ${AmountWithdraw}     ${Amount}
    Click Element    ${BTN_RequestWithdraw}


Check Alert
    [Arguments]  ${row}
    # พยายามกด Alert และดึงข้อความ
    ${status}  Run Keyword And Ignore Error  Handle Alert   LEAVE
    ${alert_text}    Set Variable If    '${status[0]}' == 'PASS'    ${status[1]}    ${EMPTY}
    Run Keyword If    '${alert_text}' != ''    Write Excel Cell    ${row}    7    ${alert_text}
    Run Keyword And Ignore Error  Write Excel Cell    ${row}    7    ${alert_text}
    Log To Console    ALERT: ${alert_text}
    RETURN    ${alert_text}

Verify RequestWithdraw
    [Arguments]    ${row}
    ${Expected}    Read Excel Cell    ${row}    6
    ${Actual}    Read Excel Cell    ${row}    7
    ${flag}    Run keyword And Return Status     Should Be Equal    ${Expected}    ${Actual}
    IF    ${flag}
        Run Keyword And Ignore Error    Handle Alert    accept
        Write Excel Cell    ${row}    8    Pass
        ${Status}    Run Keyword And Ignore Error    Get Text    ${Loc_success}
        ${success_text}    Set Variable If    '${Status[0]}' == 'PASS'    ${Status[1]}    ${EMPTY}
        Run Keyword If    '${success_text}' != ''    Write Excel Cell    ${row}    7    ${success_text}
        Run Keyword And Ignore Error  Write Excel Cell    ${row}    7    ${success_text}


        ${Expected2}=    Read Excel Cell    ${row}    6
        ${Actual2}=    Read Excel Cell    ${row}    7      
    ELSE    
        Write Excel Cell    ${Row}    8    Fail
        ${path}=    Capture Alert Screenshot    ${Row}
        Log To Console    Screenshot saved at: ${path}
        Run Keyword And Ignore Error    Handle Alert    accept
    END


    ${flag2}    Run keyword And Return Status     Should Be Equal    ${Expected2}    ${Actual2}   
    Log To Console    Expected: ${Expected}    
    Log To Console    Actual: ${Actual}
    Log To Console    ROW:${{${row}-1}}
    IF    ${flag2}
        Write Excel Cell    ${row}    8    Pass 
    ELSE
        Write Excel Cell    ${Row}    8    Fail
        ${path}=    Capture Alert Screenshot    ${Row}
        Log To Console    Screenshot saved at: ${path}
        # Run Keyword And Ignore Error    Handle Alert    Accept
    END

Close Excel Request Withdraw
    Save Excel Document    ${DataTableRequestWithdraw}    
    Close Current Excel Document

Close Browser Page
    Close Browser