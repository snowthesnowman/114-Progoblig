use context essentials2021
Kommandoer = "Flaggene en kan tegne er: Norge, Island, Sverige, Danmark, Finland og Faroe! Skriv en av dem for å se de dukke opp!"
Kommandoer

fun draw-nordiske-flagg(bakgrunn-horisontalt, bakgrunn-vertikalt, stor-stripe, liten-stripe, farge-bakgrunn, stor-farge, liten-farge) -> Image:
  
  bakgrunn = rectangle(bakgrunn-horisontalt, bakgrunn-vertikalt, "solid", farge-bakgrunn)
  
  stor-horisontalt = rectangle(bakgrunn-horisontalt, stor-stripe, "solid", stor-farge)
  
  stor-vertikalt = rectangle(stor-stripe, bakgrunn-vertikalt, "solid", stor-farge)
  
  liten-horisontalt = rectangle(bakgrunn-horisontalt, liten-stripe, "solid", liten-farge)
  
  liten-vertikalt = rectangle(liten-stripe, bakgrunn-vertikalt, "solid", liten-farge)
  
  
frame(overlay-xy(liten-vertikalt, (((bakgrunn-vertikalt - stor-stripe) / 2) + (stor-stripe / 4)) * -1,0, overlay-align("middle", "middle", liten-horisontalt, overlay-xy(stor-vertikalt,((bakgrunn-vertikalt - stor-stripe) / 2) * -1,0, overlay(stor-horisontalt, bakgrunn)))))
  
end

#Hovedfunksjonen over lager tre striper som går oppå hverandre.
#Dette er derfor danmark har fargene "red, white, white"

Norge = draw-nordiske-flagg(220, 160, 40, 20, "crimson", "white", "dark-blue")
Island = draw-nordiske-flagg(250, 180, 40, 20, "blue", "white", "red")
Sverige = draw-nordiske-flagg(160, 100, 20, 0, "blue", "yellow", "yellow")
Danmark = draw-nordiske-flagg(370, 280, 40, 0, "red", "white", "white")
Finland = draw-nordiske-flagg(180, 110, 30, 0, "white", "blue", "blue")
Faroe = draw-nordiske-flagg(220, 160, 40, 20, "white", "blue", "red")


