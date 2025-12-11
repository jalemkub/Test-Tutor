*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

*** Variables ***
${URL}  http://localhost:8080/wep-tutor/
${BROWSER}  chrome
${DataTableReviewCourse}  ExcelProject/ReviewCourse.xlsx
${Sheet}  Review Course
${Row}  17
${Loc_LoginMenu}  //a[contains(text(),'เข้าสู่ระบบ ▼')]
${Loc_Gologin}  //a[@href='goLogin']


${Loc_Email}  //input[@id='email_prefix']
${Loc_Password}  //input[@id='password']

${Btn_submit}  //input[@value='เข้าสู่ระบบ']

${LocStudentMenu}  //a[contains(text(),'นักศึกษา ▼')]
${Loc_DetailCourse}  //a[contains(text(),'คอร์สที่ลงทะเบียน')]
${Loc_DescriptionCourse}  //a[contains(text(),'ดูรายละเอียด')]
${Loc_Btn_Review}  //a[contains(text(),'รีวิวคอร์ส')]


${Stars5}    //label[@for='score1']
${Stars4}    //label[@for='score2']
${Stars3}    //label[@for='score3']
${Stars2}    //label[@for='score4']
${Stars1}    //label[@for='score5']



${CommentText}  //textarea[@id='comment']

${SendReview}  //button[contains(text(),'ส่งรีวิว')]
${ErrorMessage}    //p[@class='message']

${SuccessMessage}    //p[@class='result_message']


${SCREENSHOT_PATH}    C:\\Users\\jalem\\OneDrive\\Desktop\\Test_Tutor\\screenshotReviewCourse\\IMG_Fail_${Row}.png
${img}=    pyautogui.screenshot(${SCREENSHOT_PATH})