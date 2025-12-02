*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    ../Keywords/screenshot_RegisterTutor.py

Resource    ../Variables/Variable_RegisterTutor.robot
Resource    ../Keywords/Keyword_RegisterTutor.robot

*** Keywords ***
Open Excel file
    Open Excel Document  ${DataTableRegisterTutor}  ${Sheet}


Open Browser WebSite
    Open Browser  ${URL}  ${BROWSER}  options=add_experimental_option('detach',True)
    Set Selenium Speed    0.1s
    Maximize Browser Window


Go to page Login for Register Tutor
    [Arguments]    ${row}
    ${email}=  Read Excel Cell  ${row}  3
    ${password}=  Read Excel Cell  ${row}  4
    Wait Until Element Is Visible    ${Loc_LoginMenu}
    Click Element    ${Loc_LoginMenu}
    Wait Until Element Is Visible    ${Loc_gologin}
    Click Element    ${Loc_gologin}
    Wait Until Page Contains Element  ${Loc_Email}  timeout=10s
    Input Text  ${Loc_Email}  ${email}
    Input Text  ${Loc_Password}  ${password}
    Click Button  ${Btn_submit}


Go to Page Register Tutor
    Click Element  ${link_toregister}
    Wait Until Page Contains Element  ${Loc_TypeSubject}  timeout=10s


Fill Form Register Tutor
    [Arguments]  ${row}
    ${skill}=  Read Excel Cell  ${row}  5
    ${experience}=  Read Excel Cell  ${row}  6
    Run Keyword If  '${skill}' != '' and '${skill}' != '${None}'  Input Text  ${Loc_TypeSubject}  ${skill}
    Run Keyword If  '${experience}' != '' and '${experience}' != '${None}'  Input Text  ${Loc_Experience}  ${experience}


Submit Form Register Tutor
    Click Element  ${Btn_Register}


Read Expected Result
    [Arguments]  ${row}
    ${expected}=  Read Excel Cell  ${row}  7
    RETURN  ${expected}


Check Success Form Register Tutor
    [Arguments]  ${row}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${Loc_Success}    10s
    ${status}  Run Keyword And Ignore Error  Get Text    ${Loc_Success}
    ${Success_text}    Set Variable If    '${status[0]}' == 'PASS'    ${status[1]}    ${EMPTY}
    Run Keyword If    '${Success_text}' != ''    Write Excel Cell    ${row}    8    ${Success_text}
    Run Keyword And Ignore Error    Write Excel Cell    ${row}    8    ${Success_text}
    Log To Console    SUCCESS: ${Success_text}
    RETURN    ${Success_text}


Text Error Skill Form Register Tutor
    [Arguments]    ${row}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${Errorform1}    10s
    ${statusError1}    Run Keyword And Ignore Error    Get Text    ${Errorform1}
    ${error_message1}    Set Variable If    '${statusError1[0]}' == 'PASS'    ${statusError1[1]}    ${EMPTY}
    Run Keyword If    '${error_message1}' != ''    Write Excel Cell    ${row}    8    ${error_message1}
    Run Keyword If    '${error_message1}' != ''    Log To Console    ERROR Skill: ${error_message1}
    RETURN    ${error_message1}


Text Error Experience Form Register Tutor
    [Arguments]    ${row}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${Errorform2}    10s
    ${statusErr2}    Run Keyword And Ignore Error    Get Text    ${Errorform2}
    ${error_message2}    Set Variable If    '${statusErr2[0]}' == 'PASS'    ${statusErr2[1]}    ${EMPTY}
    Run Keyword If    '${error_message2}' != ''    Write Excel Cell    ${row}    8    ${error_message2}
    Run Keyword If    '${error_message2}' != ''    Log To Console    ERROR Experience: ${error_message2}
    RETURN    ${error_message2}


Text Error Not Save Form Register Tutor
    [Arguments]    ${row}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${Errorform3}    10s
    ${statusErr3}    Run Keyword And Ignore Error    Get Text    ${Errorform3}
    ${error_message3}    Set Variable If    '${statusErr3[0]}' == 'PASS'    ${statusErr3[1]}    ${EMPTY}
    Run Keyword If    '${error_message3}' != ''    Write Excel Cell    ${row}    8    ${error_message3}
    Run Keyword If    '${error_message3}' != ''    Log To Console    ERROR Not Save: ${error_message3}
    RETURN    ${error_message3}


Read Actual Result
    [Arguments]  ${row}
    ${actual}    Read Excel Cell  ${row}  8
    RETURN  ${actual}


Register Tutor Verify
    [Arguments]  ${row}  ${expected}  ${actual}
    ${flag}  Run Keyword And Return Status  Should Be Equal  ${expected}  ${actual}
    IF  ${flag}
        Write Excel Cell  ${row}  9  Pass
        Run Keyword And Ignore Error    Handle Alert    ACCEPT
    ELSE
        Write Excel Cell  ${row}  9  Fail
        ${screenshotFailed}=    Set Variable    ${screenshot}failed_row_${row}.png
        Capture Page Screenshot    ${screenshotFailed}
    END


Save Excel And Close Excel
    Save Excel Document  ${DataTableRegisterTutor}
    
Close Excel Register Tutor
    Close Current Excel Document


Close Website Page
    Close Browser