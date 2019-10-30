# Load the following libraries.
- rpart
- tree

# Load the following data.

            Teoria      Lab     Pract   Calif Global
suceso1     A           A       B       Ap
suceso2     A           B       D       Ss
suceso3     D           D       C       Ss
suceso4     D           D       A       Ss
suceso5     B           C       B       Ss
suceso6     C           B       B       Ap
suceso7     B           B       A       Ap
suceso8     C           D       C       Ss
suceso9     B           A       C       Ss

calificaciones <- read.table("calificaciones.txt")
muestra <- data.frame(calificaciones)

- clasificacion <- rpart(C.G~., data = muestra, method = "class", minsplit = 1)
- (clasificacion <- tree(C.G~., data = muestra, mincut = 1, minsize = 2))

# Load the following data.
            R       D
Mercurio    2.4     5.4
Venus       6.1     5.2
Tierra      6.4     5.5
Marte       3.4     3.9

regresion = lm(D~R, data = muestra)

- Ejercicio -> Dibujar 4 ajustes y marcos.

op <- par(mfrow = c(2, 2))
