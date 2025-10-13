*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource   ../Variables/Variable_ReviewCourse.robot

*** Keywords ***
Open Excel File Review
    Open Excel Document    ${DataTableReviewCourse}    ${Sheet}

Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Set Selenium Implicit Wait    10s

Login As User
    [Arguments]    ${Row}
    ${email}=  Read Excel Cell  ${Row}  3
    ${password}=  Read Excel Cell  ${Row}  4
    Click Element    ${link_tologin}
    Input Text    ${Loc_Email}    ${email}
    Input Text    ${Loc_Password}    ${password}
    Click Button    ${Btn_submit}

Go To My Course Page
    Click Element    ${my_courseLink}
    Sleep    2s
    Click Element    ${Descriptioncourse}
    Sleep    2s
    Click Element    ${Btn_Review}
    Sleep    2s

Input Form Review
    [Arguments]    ${Row}
    ${star}=    Read Excel Cell    ${Row}    5
    ${comment}=    Read Excel Cell    ${Row}    6
    Run Keyword If    '${star}'=='1'    Click Element    ${Stars5}
    ...    ELSE IF    '${star}'=='2'    Click Element    ${Stars4}
    ...    ELSE IF    '${star}'=='3'    Click Element    ${Stars3}
    ...    ELSE IF    '${star}'=='4'    Click Element    ${Stars2}
    ...    ELSE IF    '${star}'=='5'    Click Element    ${Stars1}
    ...    ELSE    Fail    Invalid star rating: ${star}
    Run keyword And Ignore Error    Input Text    ${CommentText}    ${comment}
    Click Button    ${SendReview}
    Sleep    2s

check Alert message
    [Arguments]    ${row}
    ${alert}  Run Keyword And Ignore Error  Handle Alert   ACCEPT
    ${alert_text}    Set Variable If    '${alert[0]}' == 'PASS'    ${alert[1]}    ${EMPTY}
    Run Keyword If    '${alert_text}' != ''    Write Excel Cell    ${row}    8    ${alert_text}
    Run Keyword And Ignore Error  Write Excel Cell    ${row}    8    ${alert_text}
    Log To Console    ALERT: ${alert_text}
    RETURN    ${alert_text}

success Alert message
    [Arguments]    ${Row}
    ${status}  ${success_text}=  Run Keyword And Ignore Error  Get Text  ${SuccessMessage}
    Run Keyword If  '${status}' == 'PASS'  Write Excel Cell    ${Row}    8    ${success_text}
    Run Keyword And Ignore Error    Write Excel Cell    ${Row}    8    ${success_text}
    Log To Console    ALERT: ${success_text}
    RETURN    ${success_text}

verify Review after Submission 
    [Arguments]    ${row}
    ${Expected}=    Read Excel Cell    ${row}    7
    ${Actual}=    Read Excel Cell    ${row}    8
    ${flag}=    Run Keyword And Return Status    Should Be Equal    ${Expected}    ${Actual}
    Run Keyword If    '${flag}'=='True'    Write Excel Cell    ${row}    9    Pass
    ...    ELSE    Write Excel Cell    ${row}    9    Fail
    # เพิ่ม Capture Page Screenshot

Save And Close Excel
    Save Excel Document    ${DataTableReviewCourse}
    Close Current Excel Document

Close Browser Page
    Close Browser