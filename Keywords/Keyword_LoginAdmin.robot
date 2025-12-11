*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    ../Keywords/screenshot_LoginAdmin.py
Library    pyautogui


Resource    ../Variables/Variable_LoginAdmin.robot
*** Keywords ***
Open Excel file
    Open Excel Document  ${DataTableLoginAdmin}    ${Sheet}

Open Page Browser
    Open Browser  ${URL}  ${BROWSER}  options=add_experimental_option('detach',True)
    Set Selenium Speed    0.1s
    Maximize Browser Window

GO to page Login Admin
    Click Element  ${link_tologin}
    BuiltIn.Sleep  1s
    Click Element  ${Loc_Login}
    Wait Until Page Contains Element  ${Loc_EmailAM}  timeout=10s

Fill Form Login Admin
    [Arguments]  ${row}
    ${email}=  Read Excel Cell  ${row}  3
    ${Password}=  Read Excel Cell  ${row}  4
    Run Keyword If  '${email}' != '' and '${email}' != '${None}'  Input Text  ${Loc_EmailAM}  ${email}
    Run Keyword If  '${Password}' != '' and '${Password}' != '${None}'  Input Text  ${Loc_PasswordAM}  ${Password}

Submit Login Admin
    Click Element  ${Btn_submit}


Check LoginAdmin Alert Error And Success
    [Arguments]    ${row}
    BuiltIn.Sleep    1s
    Submit Login Admin
    BuiltIn.Sleep    1s

    # ALERT
    ${status}    ${alert_text}=    Run Keyword And Ignore Error    Handle Alert    LEAVE

    IF    '${status}' == 'PASS' and '${alert_text}' != ''
        Write Excel Cell    ${row}    6    ${alert_text}
        ${result}=    Set Variable    ALERT:${alert_text}
    ELSE
        # SUCCESS
        ${success_status}    ${success_text}=    Run Keyword And Ignore Error    Get Text    ${success_form}
        ${success_text}=    Set Variable If    '${success_status}' == 'PASS'    ${success_text}    ${EMPTY}

        IF    '${success_text}' != '' and '${success_text}' != 'None'
            Write Excel Cell    ${row}    6    ${success_text}
            ${result}=    Set Variable    SUCCESS:${success_text}

        ELSE
            # ERROR
            ${error_status}    ${error_text}=    Run Keyword And Ignore Error    Get Text    ${Errorform}
            ${error_text}=    Set Variable If    '${error_status}' == 'PASS'    ${error_text}    ${EMPTY}

            IF    '${error_text}' != '' and '${error_text}' != 'None'
                Write Excel Cell    ${row}    6    ${error_text}
                ${result}=    Set Variable    ERROR:${error_text}
            ELSE
                ${result}=    Set Variable    ERROR:No Message Found
            END
        END
    END

    RETURN    ${result}


Read Expected Result Login Admin
    [Arguments]  ${row}
    ${Expected}  Read Excel Cell  ${row}  5
    RETURN  ${Expected}


Read Actual Result Login Admin
    [Arguments]  ${row}
    ${actualresult}  Read Excel Cell  ${row}  6
    RETURN  ${actualresult}


Verify Equal Result Login Admin
    [Arguments]  ${row}  ${expected}  ${actualresult}
    
    Log To Console    Expected: ${Expected}    
    Log To Console    Actual: ${Actualresult}
    Log To Console    ROW:${{${row}-1}}

    ${flag}=  Run Keyword And Return Status  Should Be Equal  ${expected}  ${actualresult}

    IF  ${flag}
        Write Excel Cell    ${row}    7    Pass
    ELSE
        Write Excel Cell    ${row}    7    Fail
        ${path}=    Capture Alert Screenshot    ${Row}
        Log To Console    Screenshot saved at: ${path}
    END




Save Excel Login Admin And Close
    Save Excel Document  ${DataTableLoginAdmin}
    Close Current Excel Document


Close Browser Login Admin
    Close Browser