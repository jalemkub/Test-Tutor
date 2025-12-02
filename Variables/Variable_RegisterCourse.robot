*** Settings ***
Library    SeleniumLibrary
*** Variables ***
#website URL and Browser
${URL}    http://localhost:8080/wep-tutor/
${BROWSER}    chrome
${DataTableRegisterCourse}  ExcelProject/RegisterCourse.xlsx
${Sheet}    RegisterCourse
${Loc_Register}  //img[@alt='Register']
${LocImageFile}  ExcelProject/Images/
# screenshot
${screenshot}  screenshots_RegisterCourse/

# Login
${Loc_LoginMenu}    //a[contains(text(),'เข้าสู่ระบบ ▼')]
${Loc_goLogin}    //a[@href='goLogin']
${InputUsername}    id:email_prefix
${InputPassword}    id:password
${BtnLogin}    //input[@value='เข้าสู่ระบบ']

# RegisterCourse
${Loc_RegisterCourse}    //body/div[@class='content-container']/div[@class='content']/div[@class='course-grid']/div[1]/a[1]
${BtnRegisterdescription}    //a[contains(text(),'ลงทะเบียนเรียน')]
${Checkbox_F_Register}   id:agree
${Btn_Confirm}    id:submitBtn


#Check Success RegisterCourse
${Success_Msg}    //div[@class='footer']

${Row}  17


# ${SCREENSHOT_PATH}    C:\\Users\\jalem\\OneDrive\\Desktop\\Test_Tutor\\screenshotRegisterCourse\\IMG_Fail_${Row}.png
# ${img}=    pyautogui.screenshot(${SCREENSHOT_PATH})