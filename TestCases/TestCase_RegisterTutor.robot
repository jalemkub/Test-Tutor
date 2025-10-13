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
            ${email}=  Read Excel Cell  ${i}  3
            ${password}=  Read Excel Cell  ${i}  4
            Go to page Login for Register Tutor  ${email}  ${password}
            Go to Page Register Tutor
            ${skill}=  Read Excel Cell  ${i}  5
            ${experience}=  Read Excel Cell  ${i}  6
            Fill Form Register Tutor  ${skill}  ${experience}
            Submit Form Register Tutor
            ${expected}=  Read Expected Result  ${i}
            ${actual}=  Read Actual Result  ${i}
            Alert Error Form Register Tutor  ${i}
            Text Error Form Register Tutor  ${i}
            Check Success Form Register Tutor  ${i}
            Read Expected Result    ${i}
            Read Actual Result    ${i}
            Register Tutor Verify    ${i}    ${expected}    ${actual}       
            Sleep    2s
            Close Website Page
        END
    END
    Save Excel And Close Excel