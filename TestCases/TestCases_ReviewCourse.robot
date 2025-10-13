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
            check Alert message    ${i}
            success Alert message    ${i}
            verify Review after Submission    ${i}
            Close Browser Page
        END
    END
    Save And Close Excel