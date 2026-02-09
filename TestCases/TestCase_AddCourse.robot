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
            Go Login
            Login Form    ${i}
            Go Add Course     
            Fill Form Input Add Course    ${i}
            Check AddCourse Alert Error And Success    ${i}
            ${Expected}=    Read Expected Result    ${i}
            ${Actual}=    Read Actual Result    ${i}
            Verify Add Course    ${i}    ${Expected}    ${Actual}
            Close Browser Page 
        END
    END
    Save Excel And Close