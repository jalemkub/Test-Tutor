*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

Resource    ../Variables/Variable_Login.robot
Resource    ../Keywords/Keyword_Login.robot

*** Test Cases ***
Test Login
    Open Excel file
    FOR  ${i}  IN RANGE  2  ${Row}+1
        ${Execute}=  Read Excel Cell  ${i}  1
        IF  '${Execute}' == 'Y'
            Open Page Browser
            GO to page Login
            Fill Form Login    ${i}
            Check Login Alert Error And Success    ${i}
            Verify Equal Result Login    ${i}
            Close Browser Login
        END
    END
   Save Excel Login And Close
   Close Browser Login
