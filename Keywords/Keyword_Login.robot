*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    ../Keywords/screenshot_Login.py
Library    pyautogui

Resource    ../Variables/Variable_Login.robot
*** Keywords ***
Open Excel file
    Open Excel Document  ${DataTableLogin}    ${sheet}

Open Page Browser
    Open Browser  ${URL}  ${BROWSER}  options=add_experimental_option('detach',True)
    Set Selenium Speed    0.1s
    Maximize Browser Window
    Wait Until Page Contains Element  ${link_tologin}  timeout=10s

GO to page Login
    Click Element  ${link_tologin}
    Click Element  ${Loc_Login}
    Wait Until Page Contains Element  ${Loc_Email}  timeout=10s

Fill Form Login
    [Arguments]  ${row}
    ${email}=  Read Excel Cell    ${row}    3
    ${Password}=  Read Excel Cell    ${row}    4
    Run Keyword If  '${email}' != '' and '${email}' != '${None}'  Input Text  ${Loc_Email}  ${email}
    Run Keyword If  '${Password}' != '' and '${Password}' != '${None}'  Input Text  ${Loc_Password}  ${Password}

Submit Login
    Click Element  ${Btn_submit}

Check Alert
    [Arguments]  ${row}
    ${status}  Run Keyword And Ignore Error  Handle Alert   LEAVE
    ${alert_text}    Set Variable If    '${status[0]}' == 'PASS'    ${status[1]}    ${EMPTY}
    Run Keyword If    '${alert_text}' != ''    Write Excel Cell    ${row}    6    ${alert_text}
    # Run Keyword And Ignore Error  Write Excel Cell    ${row}    6    ${alert_text}
    Log To Console    ALERT: ${alert_text}
    RETURN    ${alert_text}


Check Error
    [Arguments]  ${row}
    ${status1}  Run Keyword And Ignore Error  Get Text  ${Errorform}
    ${error_message}    Set Variable If    '${status1[0]}' == 'PASS'    ${status1[1]}    ${EMPTY}
    Run Keyword If    '${error_message}' != ''    Write Excel Cell    ${row}    6    ${Error_message}
    # Run Keyword And Ignore Error    Write Excel Cell    ${row}    6    ${error_message}
    Log To Console    ERROR: ${error_message}
    RETURN    ${error_message}


Check Success
    [Arguments]    ${row}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${success_form}    timeout=10s
    ${status2}=    Run Keyword And Ignore Error    Execute JavaScript    return document.querySelector("${success_form}").innerHTML
    ${text}    Set Variable If    '${status2[0]}' == 'PASS'    ${status2[1]}    ${EMPTY}
    Run Keyword If    '${text}' != ''    Write Excel Cell    ${row}    6    ${text}
    Log To Console    SUCCESS: ${text}
    RETURN    ${text}


Verify Equal Result Login
    [Arguments]  ${row}
    ${Expected}=  Read Excel Cell  ${row}  5
    ${Actualresult}=  Read Excel Cell  ${row}  6
    Log To Console    Expected: ${Expected}    Actual: ${Actualresult}

    ${flag}=  Run Keyword And Return Status  Should Be Equal  ${Expected}  ${Actualresult}

    IF  ${flag}
        Write Excel Cell    ${row}    7    Pass
        BuiltIn.Sleep    2s
        # Run Keyword And Ignore Error    Handle Alert    Accept
    ELSE
        Write Excel Cell    ${row}    7    Fail
        ${path}=    Capture Alert Screenshot    ${Row}
        BuiltIn.Sleep    2s
        Run Keyword And Ignore Error    Handle Alert    Accept
    END




Save Excel Login And Close
    Save Excel Document  ${DataTableLogin}
    Close Current Excel Document


Close Browser Login
    Close Browser



