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
            ${email}=  Read Excel Cell  ${i}  3
            ${Password}=  Read Excel Cell  ${i}  4
            Fill Form Login Admin  ${email}  ${Password}
            Submit Login Admin
            ${Expected}=  Read Expected Result Login Admin  ${i}
            Check Alert  ${i}
            Check Error  ${i}
            Check Success  ${i}
            ${actualresult}=  Read Actual Result Login Admin  ${i}
            ${flag}=  Verify Equal Result Login Admin  ${i}  ${Expected}  ${actualresult}
            Close Browser Login Admin
        END
    END
    Save Excel Login Admin And Close
   Close Browser Login Admin
