*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Keywords/Keyword_EditProfile.robot
Resource    ../Variables/Variable_EditProfile.robot
*** Test Cases ***
Test Edit Profile
    Open Excel EditProfile
    FOR  ${i}  IN RANGE  2  ${Row}+1
        ${Execute}=  Read Excel Cell  ${i}  1
         IF  '${Execute}' == 'Y'
            Open Browser WebSite
            Click Login For EditProfile
            Input Fill From EditProfile Excel  ${i}
            Upload EditProfile Image  ${i}
            Submit EditProfile Button
            Get Visible Error Alert  ${i}
            Read Expected Result EditProfile  ${i}
            Read ActualResult Result EditProfile    ${i}
            Check Error And Verify Result  ${i}
            Close Browser EditProfile
        END
    END
    Save And Close Excel EditProfile



    