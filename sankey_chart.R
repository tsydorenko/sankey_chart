rm(list=ls())
###################
# loading libraries
library(googleVis)
library(utils)
library(dplyr)
library(googleVis)
library(sqldf)
library(RColorBrewer)

####
setwd("/Users/tetyanasydorenko/Rprojects/")

# create data set
channels<- c("direct", "sea", "seo", "newsletter","other")
pages <- c("welcome", "product detail", "product overview", "marketing landing")
actions<- c("bounce","conversion", "no conversion")

ch_page<- expand.grid( x = channels, y=pages)
page_action<- expand.grid( x = pages, y=actions)
data<- rbind(ch_page, page_action)

weights<- c(  1050, 900, 600, 300,
               150, 400, 2200, 800,
               400, 200, 100, 600,
               1000, 200, 100, 350,
               300, 200, 100, 50,
               300, 1300, 850, 450,
               450, 340, 320, 250, 
               2250, 2360, 830, 300)



data<- as.data.frame(cbind(data,as.numeric(weights)))

#define colors for sankey charts
colors_link<- brewer.pal(9,"Set3")
colors_link_array <- paste0("[", paste0("'", colors_link,"'", collapse = ','), "]")

colors_node<- brewer.pal(12,"Set3")
colors_node[12]<- c("#999999")
colors_node[11]<- c("#099900")
colors_node[10]<- c("#E41A1C")
colors_node_array <- paste0("[", paste0("'", colors_node,"'", collapse = ','), "]")

#manipulation nodes and links for sankey charts
opts <- paste0("{
        link: { colorMode: 'source',
                colors: ", colors_link_array ," },
        node: { colors: ", colors_node_array ,",
              nodePadding:0,
              width: 7 } 
      }" )

#create a sankey chart in your browser
sankey <- gvisSankey(data, from="from",
                            to="to", weight="weights",
                            options=list(
                              height=600,
                              width=1200,
                              sankey= opts
                            )
                            )
plot(sankey)

#save sankey chart
print(sankey, file = "outputFile.html")
