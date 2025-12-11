*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource   ../Variables/Variable_ReviewCourse.robot
Resource   ../Keywords/Keyword_ReviewCourse.robot

*** Test Cases ***
Review Course Test
    Open Excel File Review
    FOR    ${i}    IN RANGE    2    ${Row}+1
    ${Execute}=  Read Excel Cell    ${i}  1
        IF  '${Execute}' == 'Y'
            Open Browser To Login Page
            Login As User  ${i}
            Go To My Course Page
            Input Form Review    ${i}
            Check Review Alert Error And Success    ${i}
            ${expected}    Read Expected Result Review    ${i}
            ${actual}    Read Actual Result Review    ${i}
            verify Review Course    ${i}    ${expected}    ${actual}
            Close Browser Page Review
        END
    END
    Save And Close Excel