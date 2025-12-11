*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    ../Keywords/screenshot_ReviewCourse.py
Library    OperatingSystem

Resource   ../Variables/Variable_ReviewCourse.robot


*** Keywords ***
Open Excel File Review
    Open Excel Document    ${DataTableReviewCourse}    ${Sheet}

Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option('detach',True)
    Set Selenium Speed    0.1s
    Maximize Browser Window

Login As User
    [Arguments]    ${Row}
    ${email}=  Read Excel Cell  ${Row}  3
    ${password}=  Read Excel Cell  ${Row}  4
    Run Keyword And Ignore Error    
    ...    Wait Until Element Is Visible    ${Loc_LoginMenu}
    Click Element    ${Loc_LoginMenu}
    Run Keyword And Ignore Error    
    ...    Wait Until Element Is Visible    ${Loc_Gologin}
    Click Element    ${Loc_Gologin}
    Run Keyword And Ignore Error    
    ...    Wait Until Element Is Visible    ${Loc_Email}
    Input Text    ${Loc_Email}    ${email}
    Input Text    ${Loc_Password}    ${password}
    Run Keyword And Ignore Error    
    ...    Wait Until Element Is Visible    ${Btn_submit}
    Click Button    ${Btn_submit}

Go To My Course Page
    Run Keyword And Ignore Error    
    ...    Wait Until Element Is Visible    ${LocStudentMenu}
    Click Element    ${LocStudentMenu}
    Click Element    ${Loc_DetailCourse}
    Click Element    ${Loc_DescriptionCourse}
    Run Keyword And Ignore Error    
    ...    Wait Until Element Is Visible     ${Loc_Btn_Review}
    Click Element    ${Loc_Btn_Review}


Input Form Review
    [Arguments]    ${Row}
    ${star}=    Read Excel Cell    ${Row}    5
    ${comment}=    Read Excel Cell    ${Row}    6
    IF    '${star}' != '' and '${star}' != '${None}'
        IF    '${star}' == '1'
            Click Element    ${Stars5}
        ELSE IF    '${star}' == '2'
            Click Element    ${Stars4}
        ELSE IF    '${star}' == '3'
            Click Element    ${Stars3}
        ELSE IF    '${star}' == '4'
            Click Element    ${Stars2}
        ELSE IF    '${star}' == '5'
            Click Element    ${Stars1}
        ELSE
            Fail    Invalid star rating: ${star}
        END
    END
    Run keyword And Ignore Error    Input Text    ${CommentText}    ${comment}

Submit Review Form
    Click Button    ${SendReview}
    BuiltIn.Sleep    2s

Check Review Alert Error And Success
    [Arguments]    ${row}
    BuiltIn.Sleep    1s
    Submit Review Form
    BuiltIn.Sleep    1s

    # ALERT
    ${status}    ${alert_text}=    Run Keyword And Ignore Error    Handle Alert    LEAVE

    IF    '${status}' == 'PASS' and '${alert_text}' != ''
        Write Excel Cell    ${row}    8    ${alert_text}
        ${result}=    Set Variable    ALERT:${alert_text}
    ELSE
        # SUCCESS
        ${success_status}    ${success_text}=    Run Keyword And Ignore Error    Get Text    ${SuccessMessage}
        ${success_text}=    Set Variable If    '${success_status}' == 'PASS'    ${success_text}    ${EMPTY}

        IF    '${success_text}' != '' and '${success_text}' != 'None'
            Write Excel Cell    ${row}    8    ${success_text}
            ${result}=    Set Variable    SUCCESS:${success_text}

        ELSE
            # ERROR
            ${error_status}    ${error_text}=    Run Keyword And Ignore Error    Get Text    ${ErrorMessage}
            ${error_text}=    Set Variable If    '${error_status}' == 'PASS'    ${error_text}    ${EMPTY}

            IF    '${error_text}' != '' and '${error_text}' != 'None'
                Write Excel Cell    ${row}    8    ${error_text}
                ${result}=    Set Variable    ERROR:${error_text}
            ELSE
                ${result}=    Set Variable    ERROR:No Message Found
            END
        END
    END

    RETURN    ${result}


Read Expected Result Review
    [Arguments]    ${row}
    ${expected}=  Read Excel Cell  ${row}  7
    Log To Console    Expected Result: "${expected}"
    RETURN    ${expected}

Read Actual Result Review
    [Arguments]    ${row}
    ${actual}=  Read Excel Cell  ${row}  8
    Log To Console    Actual Result: "${actual}"
    RETURN    ${actual}

verify Review Course
    [Arguments]    ${row}    ${expected}    ${actual}
    ${flag}=    Run Keyword And Return Status    Should Be Equal    ${expected}    ${actual}
    IF    ${flag}   
        Write Excel Cell    ${row}    9    Pass
    ELSE
        Write Excel Cell    ${row}    9    Fail
        ${path}=    Capture Alert Screenshot    ${Row}
        Log To Console    Screenshot saved at: ${path}
        
    END
    Run Keyword And Ignore Error    Handle Alert    Accept

Save And Close Excel
    Save Excel Document    ${DataTableReviewCourse}
    Close Current Excel Document

Close Browser Page Review
    Close Browser