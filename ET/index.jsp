Expence_Tracker\
|---WEB-INF\
            web.xml(welcome file login.jsp)
|-login.jsp( (make session of userid to do all user related operastion)email,pass redirect to -viewExpence   add small line if do not have accout then signup )
|-signup.jsp((make session of userid to do all user related operastion)email,pass,uname redirect to login if succesfuly insert in table small line if have accout thne login)
|-viewExpence.jsp((show Expence of that logedin user)[date,time,discription,money] (Filter Expenses logic with in this file ),edit,remove  button for logout that redirect to login )
|-addExpence.jsp(date,time,discription,money after add redirect to -viewExpence)
|-removeExpence.jsp(remove logic redirect to -viewExpence)
|-editExpence.jsp(edit page edit[date,time,discription,money] redirect to )
|-dbcon.jsp(databse connection)

make session of userid to do all user related operastion

color- (Black and White with Gold Accents
Primary Color (Black): #2d3436 (Dark Charcoal)
Accent Color (Gold): #f39c12 (Gold)
Background Color: #f5f6fa (Soft White)
Text Color: #2d3436 (Dark Charcoal))
use-jsp only jsp,menstion welcome file in web.xml
do not use- servalet,external jsp code file,mention servalet in web.xml
give- databse & tables

