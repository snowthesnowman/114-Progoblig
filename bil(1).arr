include tables
include gdrive-sheets
include data-source
include shared-gdrive("dcic-2021",
"1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")


ssid = "1RYN0i4Zx_UETVuYacgaGfnFcv4l9zd9toQTTdkQkj7g"
kWh-wealthy-consumer-data =
load-table: komponent, energi
source: load-spreadsheet(ssid).sheet-by-name("kWh", true)
end

#sanitize
event =
  load-table: komponent, energi
  source: load-spreadsheet(ssid).sheet-by-name("kWh", true)
  sanitize energi using string-sanitizer
  sanitize komponent using string-sanitizer
end

#String til Number
fun energi-to-number(s :: String) -> Number:
  cases(Option) string-to-number(s):
    | some(a) => a
    | none => 0
  end
where:
  energi-to-number("") is 0
  energi-to-number("30") is 30
  energi-to-number("37") is 37
  energi-to-number("5") is 5
  energi-to-number("4") is 4
  energi-to-number("15") is 15
  energi-to-number("48") is 48
  energi-to-number("12") is 12
  energi-to-number("4") is 4
end

numbers = transform-column(event, "energi", energi-to-number)



sum-uten-bil = sum(numbers, "energi")
sum-uten-bil-tekst = "Under er kWh consumer data uten bil."
sum-uten-bil-tekst
sum-uten-bil


#Formel for dagling forbrukt
fun forbruk(distance-dag, distance-per-enhet, energi-per-enhet):
  num-round((distance-dag / distance-per-enhet) * energi-per-enhet)
end

forbruk-bil-tekst = "Her er bilforbruk basert på Janis sin formel"
forbruk-bil = forbruk(45,15,10)
forbruk-bil-tekst
forbruk-bil


#Total sum
total-sum-tekst = "Total Energiforbruk"
total-sum = forbruk-bil + sum-uten-bil
total-sum-tekst
total-sum

# Sett inn bilforbruk i tabell
energi-kolonne = numbers.get-column("energi").set(0,forbruk-bil)

ny-tabell = [table-from-columns:
  {"komponent"; numbers.get-column("komponent")},
  {"energi"; energi-kolonne}
]
ny-tabell


#Visuel Representasjon
cs111-syllabus-table = table: typer :: String, energiforbruk :: Number
  row: "bil", forbruk-bil
  row: "fly", 30
  row: "ovn", 37
  row: "lys", 5
  row: "dingser", 4
  row: "mlk", 15
  row: "varer", 48
  row: "varetransport", 12
  row: "offtjen", 4
end

# Lag ny bar-chart
bar-chart(ny-tabell, "komponent", "energi")
