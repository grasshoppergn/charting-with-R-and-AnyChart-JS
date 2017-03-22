library(shiny)
library(RMySQL)
library(jsonlite)

db = dbConnect(MySQL(),
  dbname = "anychart_db",
  host = "localhost", 
  port = 3306, 
  user = "anychart_user", 
  password = "anychart_pass")

loadData = dbGetQuery(db, "SELECT name, value FROM fruits")

data1 <- character()

#data preparation
for(var in 1:nrow(loadData)){
c = c(as.character(loadData[var, 1]), loadData[var, 2])
data1 <- c(data1, c)
}

data = matrix(data1,  nrow=nrow(loadData), ncol=2, byrow=TRUE)

server = function(input, output){}

ui = function(){
  htmlTemplate("index.html",
    title = "Anychart R Shiny template",
    chartTitle = shQuote("Fruits"),
    chartData = toJSON(data)
)}

shinyApp(ui = ui, server = server)
