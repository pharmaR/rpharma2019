# user interface definition, module based
# v0.1, 2019-07-16


shinyUI(
  dashboardPage(dashboardHeader(title = "Risk Assessment"), #theme = shinytheme("cerulean"), 
                skin = "blue",
                dashboardSidebar(
                  sidebarMenu(
                    menuItem("Packages",  tabName = "packages"),
                    menuItem("Assessment Criteria",  
                             tabName = "ass_crit",
                             menuSubItem("Maintenance",
                                         tabName = "maintenance"
                                         ),
                             menuSubItem("Community",
                                         tabName = "community"
                             ),
                             menuSubItem("Testing",
                                         tabName = "testing"
                             )
                    )
                  )),
                dashboardBody(
                  tabItems(
                    tabItem(tabName = "packages", choosePackageUI("choosePackage1")),
                    tabItem(tabName = "maintenance", showMetricsUI("maintenance")),
                    tabItem(tabName = "community", showMetricsUI("community")),
                    tabItem(tabName = "testing", showMetricsUI("testing"))
                  )
                )
  )
)

# tabPanel("Maintenance", showMetricsUI("maintenance")),
# tabPanel("Community", showMetricsUI("community")),
# tabPanel("Testing", showMetricsUI("testing"))

