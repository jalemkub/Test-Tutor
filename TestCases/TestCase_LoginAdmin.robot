*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

Resource    ../Variables/Variable_LoginAdmin.robot
Resource    ../Keywords/Keyword_LoginAdmin.robot

*** Test Cases ***
Test Login Admin
    Open Excel file
    FOR  ${i}  IN RANGE  2  ${Row}+1
        ${Execute}=  Read Excel Cell  ${i}  1
        IF  '${Execute}' == 'Y'
            Open Page Browser
            GO to page Login Admin
            Fill Form Login Admin    ${i}
            Check LoginAdmin Alert Error And Success  ${i}
            ${Expected}=  Read Expected Result Login Admin  ${i}
            ${actualresult}=  Read Actual Result Login Admin  ${i}
            Verify Equal Result Login Admin  ${i}  ${Expected}  ${actualresult}
            Close Browser Login Admin
        END
    END
    Save Excel Login Admin And Close
   Close Browser Login Admin
