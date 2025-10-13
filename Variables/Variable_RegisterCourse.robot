*** Settings ***
Library    SeleniumLibrary
*** Variables ***
#website URL and Browser
${URL}    http://localhost:8080/SpringMVCProject/
${BROWSER}    chrome
${DataTableRegisterCourse}  ExcelProject/RegisterCourse.xlsx
${Sheet}    RegisterCourse
${Loc_Register}  //img[@alt='Register']
${LocImageFile}  ExcelProject/Images/
# screenshot
${screenshot}  ScreenshotsRegisterCourse/

# Login
${LoginUser}    //img[@alt='Login']
${InputUsername}    id:email_prefix
${InputPassword}    id:password
${BtnLogin}    //input[@value='เข้าสู่ระบบ']

# RegisterCourse
${LocLinkCourse}    css:a[href='getViewCourse?id=123']
${BtnRegisterdescription}    //a[contains(text(),'ลงทะเบียนเรียน')]
${Checkbox_F_Register}   id:agree
${Btn_Confirm}    id:submitBtn


#Check Success RegisterCourse
${Success_Msg}    //p[contains(text(),'ลงทะเบียนคอร์สเรียบร้อยแล้ว')]

${Row}  17
