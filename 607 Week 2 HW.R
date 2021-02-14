library("RODBC")
connect<-odbcConnect("mysql")
my.data<-sqlQuery(connect,"SELECT*FROM db1.movies")
my.data<-as.data.frame(my.data)
my.data
