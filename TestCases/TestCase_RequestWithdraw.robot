*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

Resource    ../Variables/Variable_RequestWithdraw.robot
Resource    ../Keywords/Keyword_RequestWithdraw.robot
*** Test Cases ***
Request Withdraw Test
    Open Excel Request Withdraw
    FOR    ${i}    IN RANGE    2    ${Row}+1
        ${Execute}=    Read Excel Cell    ${i}    1
        IF   '${Execute}'=='Y'
            Open Browser Website
            Go to Login Page for Request Withdraw    ${i}
            Go to Request Withdraw Page    ${i}
            Check Alert   ${i}
            Verify RequestWithdraw    ${i}
            Close Browser Page
        END
    END
    Close Excel Request Withdraw
    