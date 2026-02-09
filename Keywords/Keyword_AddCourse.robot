*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary
Library    String
Library    ../Keywords/screenshot_AddCourse.py

Resource  ../Variables/Variable_AddCourse.robot

*** Keywords ***
Open Excel Document File
    Open Excel Document    ${DataTableAddCourse}    ${Sheet}

Open Browser Page
    Open Browser  ${URL}  ${BROWSER}    options=add_experimental_option('detach',True)
    Maximize Browser Window
    # Set Selenium Speed    0.1s
Go Login
    Click Element    ${Loc_LoginMenu}
    Click Element    ${Loc_goLogin}
    BuiltIn.Sleep  1s

Login Form
    [Arguments]   ${Row}
    Input Text    ${Loc_Input_Email}    mju6504106383
    Input Text    ${Loc_Input_Password}    Ptt123445678##
    Click Element    ${Loc_Btn_Login}

Go Add Course
    Click Element   ${Loc_Go_AddCourseMenu}
    Click Element   ${Loc_Go_AddCourse}

Fill Form Input Add Course
    [Arguments]  ${row}
    ${course_name}=    Read Excel Cell    ${row}   3
    ${course_type}=    Read Excel Cell    ${row}   4
    ${course_description}=    Read Excel Cell    ${row}   5
    ${course_quantity}=    Read Excel Cell    ${row}   6
    ${course_price}=    Read Excel Cell    ${row}   7
    ${course_date}=    Read Excel Cell    ${row}    8
    ${course_starttime}=  Read Excel Cell    ${row}    9
    ${course_Hours}=    Read Excel Cell    ${row}    10
    ${course_topic}=     Read Excel Cell    ${row}    11


    Run Keyword If  '${course_name}' != '' and '${course_name}' != '${None}'  
    ...  Input Text    ${Loc_Course_Name}    ${course_name}

    ${should_select_type}=    Evaluate    '${course_type}' != '' and '${course_type}' != '-- เลือกประเภทของวิชา --' and '${course_type}' != '${None}'

    Run Keyword If    ${should_select_type}    Select From List By Label    ${Loc_Course_Type}    ${course_type}

    Run Keyword If  '${course_description}' != '' and '${course_description}' != '${None}'  
    ...  Input Text    ${Loc_Course_Description}    ${course_description}

    ${should_select_Quantity}=    Evaluate    '${course_quantity}' != '' and '${course_quantity}' != 'เลือกจำนวนนักศึกษา' and '${course_quantity}' != '${None}'
    Run Keyword If    ${should_select_Quantity}    Select From List By Label    ${Loc_Course_Qultity}    ${course_quantity}

    Run Keyword If  '${course_price}' != '' and '${course_price}' != '${None}'  
    ...  Input Text    ${Loc_Course_Price}    ${course_price}

    Run Keyword If    '${course_date}' != '' and '${course_date}' != '${None}'  
    ...    Input Text    ${Loc_Course_date}    ${course_date}


    Run Keyword If    '${course_starttime}' != '' and '${course_starttime}' != '${None}'
    ...    Input Text    ${Loc_Course_StartTime}    ${course_starttime}


    Run Keyword If  '${course_Hours}' != '' and '${course_Hours}' != '${None}'  
    ...    Input Text    ${Loc_Houres_Input}    ${course_Hours}
    
    Run Keyword If  '${course_topic}' != '' and '${course_topic}' != '${None}'  
    ...  Input Text   ${Loc_Course_Topic}    ${course_topic}


Click Submit Form Add Course
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${Loc_Btn_AddCourse}    10s
    Click Element    ${Click}
    Click Element    ${Loc_Btn_AddCourse}

Check AddCourse Alert Error And Success
    [Arguments]    ${row}
    BuiltIn.Sleep    1s
    Click Submit Form Add Course
    BuiltIn.Sleep    1s

    # ALERT
    ${status}    ${alert_text}=    Run Keyword And Ignore Error    Handle Alert    LEAVE

    IF    '${status}' == 'PASS' and '${alert_text}' != ''
        Write Excel Cell    ${row}    13    ${alert_text}
        ${result}=    Set Variable    ALERT:${alert_text}

    ELSE
        # SUCCESS
        ${success_status}    ${success_text}=    Run Keyword And Ignore Error
        ...    Execute JavaScript    return document.querySelector("${Success_Msg}").innerHTML

        IF    '${success_status}' == 'PASS' 
            IF    '${success_text}' != ''
                Write Excel Cell    ${row}    13    ${success_text}
                ${result}=    Set Variable    SUCCESS:${success_text}
                
            END
            
        ELSE
            # ERROR
            ${error_status}    ${error_text}=    Run Keyword And Ignore Error    Get Text    ${Error_NoAddedCourse}
            ${error_text}=    Set Variable If    '${error_status}' == 'PASS'    ${error_text}    ${EMPTY}

            IF    '${error_text}' != '' and '${error_text}' != 'None'
                Write Excel Cell    ${row}    13    ${error_text}
                ${result}=    Set Variable    ERROR:${error_text}
            ELSE
                ${result}=    Set Variable    ERROR:No Message Found
            END
        END
    END

    RETURN    ${result}

Read Expected Result
    [Arguments]  ${row}
    ${expected}    Read Excel Cell    ${row}    12
    RETURN  ${expected}

Read actual Result
    [Arguments]  ${row}
    ${actual}    Read Excel Cell    ${row}    13
    RETURN  ${actual}

Verify Add Course
    [Arguments]    ${row}  ${expected}  ${actual}
    ${flag}  Run Keyword And Return Status  Should Be Equal    ${expected}   ${actual}
    Log To Console    ${actual}  
    Log To Console    ${expected}

    IF  ${flag}
        Write Excel Cell    ${row}    14    Pass
    ELSE
        Write Excel Cell    ${row}    14    Fail
        ${path}=    Capture Alert Screenshot    ${row}
        Log To Console    Screenshot saved at: ${path}
    END

Save Excel And Close
    Save Excel Document    ${DataTableAddCourse}
    Close Browser

Close Browser Page
    Close Browser
