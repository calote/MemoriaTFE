# Elige "Source" > "Source as Local Job" (se acepta todo). 
# Luego tan solo habrá que pulsar el botón de la flecha verde en la Pestaña: "Jobs" (superior derecha)
# LA VENTAJA ES QUE LO CREA EN UN PROCESO R INDEPENDIENTE, LO CUAL NOS PERMITE SEGUIR TRABAJANDO

# O con este fichero abierto pulsar sobre el botón "Source" o "Ctrl+May+S" (Cmd+May+S)

nbfichero = "tfe_principal"
#nbfichero = "capitulo01n"
#nbfichero = "capitulo05"

ficheroRmd = paste0(nbfichero,".Rmd")
ficheropdf = paste0(nbfichero,".pdf")


rmarkdown::render(ficheroRmd,  encoding = 'UTF-8')

#Sys.sleep(10)

#install.packages("beepr")
#library(beepr)
beepr::beep(sound = 5)  


browseURL(ficheropdf)
#browseURL('http://destio.us.es/calvo')
