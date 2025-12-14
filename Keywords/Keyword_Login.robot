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


Check Login Alert Error And Success
    [Arguments]    ${row}
    BuiltIn.Sleep    1s
    Submit Login
    BuiltIn.Sleep    1s

    # ALERT
    ${status}    ${alert_text}=    Run Keyword And Ignore Error    Handle Alert    LEAVE

    IF    '${status}' == 'PASS' and '${alert_text}' != ''
        Write Excel Cell    ${row}    6    ${alert_text}
        ${result}=    Set Variable    ALERT:${alert_text}

    ELSE
        # SUCCESS
        ${success_status}    ${success_text}=    Run Keyword And Ignore Error
        ...    Execute JavaScript    return document.querySelector("${success_form}").innerHTML

        IF    '${success_status}' == 'PASS' 
            IF    '${success_text}' != ''
                Write Excel Cell    ${row}    6    ${success_text}
                ${result}=    Set Variable    SUCCESS:${success_text}
                
            END
            
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



Verify Equal Result Login
    [Arguments]  ${row}
    ${Expected}=  Read Excel Cell  ${row}  5
    ${Actualresult}=  Read Excel Cell  ${row}  6
    Log To Console    Expected: ${Expected}    
    Log To Console    Actual: ${Actualresult}
    Log To Console    ROW:${{${row}-1}}

    ${flag}=  Run Keyword And Return Status  Should Be Equal  ${Expected}  ${Actualresult}
    
    IF  ${flag}
        Write Excel Cell    ${row}    7    Pass
    ELSE
        Write Excel Cell    ${row}    7    Fail
        ${path}=  Capture Alert Screenshot   ${Row}
        Log To Console    Screenshot saved at: ${path}
    END


Save Excel Login And Close
    Save Excel Document  ${DataTableLogin}
    Close Current Excel Document


Close Browser Login
    Close Browser



