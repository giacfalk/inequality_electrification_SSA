pop_gr <- wb(indicator = "SP.POP.GROW", startdate = 2014, enddate = 2018)
urb_pop <- wb(indicator = "SP.URB.TOTL.IN.ZS", startdate = 2013, enddate = 2018)

a = subset(pop_gr, iso3c %in% merged_diff$GID_0)
b = subset(urb_pop, iso3c %in% merged_diff$GID_0)

a = data.frame(paste0("var pop_gr_", substr(a$date, 3, 4), "_", a$iso3c, " = ", a$value))

b = data.frame(paste0("var pop_urb", substr(b$date, 3, 4), "_", b$iso3c, " = ", b$value))


b = subset(urb_pop, iso3c %in% merged_diff$GID_0)
b$value = 100- b$value
b2 = data.frame(paste0("var pop_rur", substr(b$date, 3, 4), "_", b$iso3c, " = ", b$value))


write.csv(a, "a.csv")
write.csv(b, "b.csv")
write.csv(b2, "b2.csv")

c = data.frame(paste0("var pop", substr(b$date, 3, 4), substr(b$date[-1], 3, 4), "_", b$iso3c, " = ", b$value))

AGO = unique(as.character(merged_diff$GID_0))

uno = c(18, 16, 15, 14)
due =  c(17, 15, 14, 13)

c = paste0("var pop", uno, "_urban_", AGO, "= pop17_urban.clip(Countries.filter(ee.Filter.eq('GID_0', '", AGO, "'))).multiply(1+(pop_gr_", uno, "_", AGO, "/100*(1+((pop_urb", uno, "_", AGO, "-pop_urb", due, "_", AGO, ")/100))))")

write.csv(c, "c.csv")

uno=c(14, 15, 16, 18)
due=c("_urban", "_rural")
tre=AGO
bbb = expand.grid(uno, due, tre)

ccc = paste0("pop", bbb$Var1, bbb$Var2, "_", bbb$Var3)

ccc14 = grep("14", ccc,value=TRUE)
write.csv(ccc14, "ccc14.csv")

ccc15 = grep("15", ccc,value=TRUE)
write.csv(ccc15, "ccc15.csv")

ccc16 = grep("16", ccc,value=TRUE)
write.csv(ccc16, "ccc16.csv")

ccc18 = grep("18", ccc,value=TRUE)
write.csv(ccc18, "ccc18.csv")

