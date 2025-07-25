*** Variables ***
${URL}  http://localhost:8081/SpringMVCProject/
${BROWSER}  chrome
${Row}  11
${DataSearchCourse}  ExcelProject/Search Course.xlsx
${sheet}  SearchCourse
${screenshot}  ScreenshotsSearchCourse/
${locSearch}  (//input[@placeholder='ค้นหาคอร์ส'])[1]
${clickSearchCourse}  //input[@value='ค้นหา']
${locGetText}  css:body h2