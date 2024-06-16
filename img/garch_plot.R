#-----------------
# rotina para o gráfico

library("rugarch")
library("quantmod")
getSymbols("VALE", src = "yahoo", from = "2005-01-01")

vale = (VALE$VALE.Open)
plot(vale, type = "l")


# corrigindo a media
y <- stochvol::logret(vale)

# especificando o modelo
espec_VALE = ugarchspec(mean.model = list(armaOrder = c(0,0)),
                        variance.model = list(model = "fGARCH", submodel = "TGARCH",
                                              garchOrder = c(1, 1)),
                        distribution.model = "std")



# estimando os parametros
m_VALE = ugarchfit(data = y, spec = espec_VALE, solver = "hybrid",
                   solver.control = list(tol=1e-20,delta=1e-20) )
plot(m_VALE, which = 2)

