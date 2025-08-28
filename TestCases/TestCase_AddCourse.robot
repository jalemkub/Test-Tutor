*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary
Resource  ../Keywords/Keyword_AddCourse.robot
Resource  ../Variables/Variable_AddCourse.robot

***Test Cases ***
Test AddCourse
    Open Excel Document File
    FOR    ${i}    IN RANGE    2    ${Row}+1
        ${Execute}=  Read Excel Cell    ${i}    1
        IF   '${Execute}' == 'Y'
            Open Browser Page
            ${email}=  Read Excel Cell    ${i}    3
            ${password}=  Read Excel Cell    ${i}    4
            Go Login
            Login Form    ${email}    ${password}
            Go Add Course

            ${course_name}=  Read Excel Cell    ${i}    5
            ${course_type}=  Read Excel Cell    ${i}    6
            ${course_description}=  Read Excel Cell    ${i}    7
            ${course_quantity}=  Read Excel Cell    ${i}    8
            ${course_price}=  Read Excel Cell    ${i}    9
            ${thai_date}=    Read Excel Cell    ${i}    10
            ${course_date}=   Convert Thai Full Year Date    ${thai_date}
            ${course_starttime}=  Read Excel Cell    ${i}    11
            ${course_endtime}=    Read Excel Cell    ${i}    12
            ${course_topic}=  Read Excel Cell    ${i}    13
            Fill Form Input Add Course    ${course_name}    ${course_type}    ${course_description}    ${course_quantity}    
            ...    ${course_price}    ${course_date}    ${course_starttime}    ${course_endtime}    ${course_topic}
            Set Time Input From Excel   ${Loc_Course_StartTime}  ${course_starttime}
            Set Time Input From Excel   ${Loc_Course_EndTime}  ${course_endtime}
            Click Submit Form
            ${Alert}=  Handle Alert Error    ${i}
            # Success Alert    ${i}
            ${Expected}=  Read Expected Result    ${i}
            ${Actual}=  Read Actual Result    ${i}
            Verify Add Course    ${i}    ${Expected}    ${Actual}
            Close Browser Page
            Save Excel And Close
        END
    END
    # Save Excel And Close