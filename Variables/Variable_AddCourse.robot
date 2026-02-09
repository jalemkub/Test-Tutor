*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary

*** Variables ***
${URL}  http://localhost:8080/wep-tutor/
${BROWSER}  chrome

${Sheet}  AddCourse
${DataTableAddCourse}  ExcelProject/AddCourse.xlsx
${Row}  64

${Screenshot}  Screenshot_AddCourse/




${Loc_LoginMenu}  //a[contains(text(),'เข้าสู่ระบบ ▼')]
${Loc_goLogin}    //a[@href='goLogin']
${Loc_Btn_Login}  //input[@value='เข้าสู่ระบบ']

${Loc_Input_Email}  //input[@id='email_prefix']
${Loc_Input_Password}  //input[@id='password']


${Loc_Go_AddCourseMenu}  //a[contains(text(),'ติวเตอร์ ▼')]
${Loc_Go_AddCourse}  //a[contains(text(),'เพิ่มคอร์ส')]


${Loc_Course_Name}  //input[@id='courseName']
${Loc_Course_Type}  //select[@id='cateName']  #dropdown
${Loc_Course_Description}  //textarea[@name='courseDescrip']
${Loc_Course_Qultity}    //select[@name='maxStu']  #dropdown
${Loc_Course_Price}  //input[@id='price']
${Loc_Course_date}  //input[@id='classDate0']
${Loc_Course_StartTime}  //input[@id='startTime0']
${Loc_Houres_Input}  css:#duration0
${Loc_Course_Topic}  //input[@id='topicName0']
${Click}    //th[contains(text(),'วันสอน และหัวข้อ')]
${Loc_Btn_AddCourse}  //input[@value='Submit']


# NoaddedCourse
${Error_NoAddedCourse}    //p[@class='error_result']
# //p[@class='error_result'].error_result

#Success
${Success_Msg}    .success-msg
# //div[@class='success-msg'].success-msg


${SCREENSHOT_PATH}    C:\\Users\\jalem\\OneDrive\\Desktop\\Test_Tutor\\screenshotAddCourse\\IMG_Fail_${Row}.png
${img}=    pyautogui.screenshot(${SCREENSHOT_PATH})