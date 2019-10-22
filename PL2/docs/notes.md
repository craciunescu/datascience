# Some stuff.

so = s[order(s $ Radio), ]
so = s[rev( ), ]
mediana <- median(s$Radio)
cuart1 <- quantile(s $ Radio, 0.25)

# Load the spss file into "dataset"
# mpg = dataset$mpg

mean(mpg) doens't work because of null values
you gotta use a filter.

///////////////////////////////////////////////////////////////////////////////

// Loading packages.
dp <- c("datasets", "utils", "grDevices", "graphics", "stats", "methods",
"foreign")

///////////////////////////////////////////////////////////////////////////////

{pan, agua, leche, naranjas}
{pan, agua, cafe, leche}
{pan, agua, leche}
{pan, cafe, leche}
{pan, agua}
{leche}

(extremadamente ineficiente) -> Transformar en matriz binaria
pan     agua    cafe    leche   naranjas
s1  1       1       0       1       1
s2  1       1       0       0       0
s3  1       1       0       1       0
s4  1       0       1       1       0
s5  1       1       0       0       0   
s6  1       0       0       0       1

introducir en R ->

muestra <- Matrix(c(1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0j 1, 1, 0, 0, 0, 0, 0, 0, 1, 0), 6, 5, byrow = T, dimnames = list(c("s1", "s2", "s3", "s4", "s5", "s6")), c("Pan", "Agua", "Cafe", "Leche", "Naranjas"), sparse = T)

muestrangCMatrix <- as(muestra, "nsparseMatrix")
transpmuestrdRGCMatrix <- t(muestrangCMatrix)

transacciones <- as(transpuestrangCMatrix, "transactions")
transacciones
Summary(transacciones)
asociaciones <- apriori(transacciones, parameter = list(support = 0.5,
confidence = 0.8))
inspect(asociaciones)
