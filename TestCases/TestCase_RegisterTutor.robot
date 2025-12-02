*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

Resource    ../Variables/Variable_RegisterTutor.robot
Resource    ../Keywords/Keyword_RegisterTutor.robot

*** Test Cases ***
Test Register Tutor
    Open Excel file
    FOR    ${i}    IN RANGE    2    ${Row}+1
        ${Execute}=  Read Excel Cell  ${i}  1
        IF  '${Execute}' == 'Y'
            Open Browser WebSite
            Go to page Login for Register Tutor    ${i}
            Go to Page Register Tutor
            Fill Form Register Tutor  ${i}
            Submit Form Register Tutor
            Check Success Form Register Tutor  ${i}
            Text Error Skill Form Register Tutor  ${i}
            Text Error Experience Form Register Tutor  ${i}
            Text Error Not Save Form Register Tutor  ${i}
            ${expected}=  Read Expected Result  ${i}
            ${actual}=  Read Actual Result  ${i}
            Register Tutor Verify    ${i}    ${expected}    ${actual}       
            Close Website Page
        END
    END
    Save Excel And Close Excel
    Close Excel Register Tutor