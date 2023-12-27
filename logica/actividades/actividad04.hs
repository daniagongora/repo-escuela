--Dania Paula Góngora Ramírez
--Zuriel Hernandez Martinez
import Data.List
----- Regresa una lista con las sublistas de la entrada---

subconj:: [a] -> [[a]]
subconj [] = [[]]
subconj (x:xs) = auxsubconj x (subconj xs) ++ (subconj xs)

auxsubconj x [] = []
auxsubconj x (y:ys) = (x:y) : auxsubconj x ys


-- Prop. Tipo de datos para las proposiciones lógicas

data Prop = VarProp Int
     | T
     | F
     | Neg Prop
     | And Prop Prop
     | Or Prop Prop
     | Imp Prop Prop
     | DouImp Prop Prop 

     deriving(Eq)


--- Devueleve una lista con las variables en una fórmula (sin repetición)---

vars :: Prop -> [Prop]
vars (T) = [T]
vars (F) = [F]
vars (VarProp x) = [VarProp x]
vars (Neg x) = elimina (vars x)
vars (And x y) = elimina (vars x ++ vars y)
vars (Or x y) = elimina (vars x++vars y)
vars (Imp x y) = elimina (vars x++ vars y)
vars (DouImp x y) = elimina (vars x++ vars y)


--- Función auxiliar que elimina elementos repetidos---

elimina :: [Prop] -> [Prop]
elimina [] = []
elimina [x] = [x]
elimina (x:xs) = x : [ y  | y <- elimina(xs), y /=x ]


type Estado = [Prop]

---- extra: Representacion para Prop ---

instance Show Prop where 
     show (T) = "⊤"
     show (F) = "⊥"
     show (VarProp i) = "v"++(show i)
     show (Neg p) = "¬"++(show p)
     show (And p q) = "("++(show p) ++ " ^ "++(show q)++")"
     show (Or p q) = "("++(show p) ++ " v "++(show q)++")"
     show (Imp p q) = "("++(show p) ++ " -> "++(show q)++")"
     show (DouImp p q) = "("++(show p) ++ " <--> "++(show q)++")"
     

-- Función de interpretación, interpreta cierta o falsa una formula con ciertos estados dados----

interpretacion :: Prop -> Estado -> Bool
interpretacion (T) y = True
interpretacion (F) y = False
interpretacion (VarProp x) y = encontrar y (VarProp x)
interpretacion (Neg x) y = if(interpretacion x y) == True then False else True
interpretacion (And x y) z = if(interpretacion x z) == True && (interpretacion y z) == True then True else False
interpretacion (Or x y) z = if(interpretacion x z) == False && (interpretacion y z) == False then False else True
interpretacion (Imp x y) z = if(interpretacion x z) == True && (interpretacion y z) == False then False else True
interpretacion (DouImp x y) z = if(interpretacion x z) == (interpretacion y z) then True else False


-- Función auxiliar de interpretación, encuentra la variable proposicional en el estado--

encontrar :: Estado -> Prop -> Bool
encontrar [] (VarProp x) = False 
encontrar (x:xs) (VarProp y) = if (VarProp y)==x then True else encontrar (xs) (VarProp y)


-- Devuelve una lista con todos los posibles estados de una fórmula.--

estados :: Prop -> [[Prop]]
estados (T) = subconj (vars (T))
estados (F) = subconj (vars (F))
estados (VarProp x) = subconj (vars (VarProp x))
estados (Neg x) = subconj (vars x)
estados (And x y) = subconj (vars x ++ vars y) 
estados (Or x y) = subconj (vars x ++ vars y) 
estados (Imp x y) = subconj (vars x ++ vars y)
estados (DouImp x y) = subconj (vars x ++ vars y)


-- Elimina equivalencias -----

elimEquiv :: Prop -> Prop
elimEquiv (T) = (T)
elimEquiv (F) = (F)
elimEquiv (VarProp x) = (VarProp x)
elimEquiv (Neg p) = (Neg (elimEquiv p))
elimEquiv (And p q) = (And (elimEquiv p) (elimEquiv q))
elimEquiv (Or p q) = (Or (elimEquiv p) (elimEquiv q))
elimEquiv (Imp p q) = (Imp (elimEquiv p) (elimEquiv q))
elimEquiv (DouImp p q) = (And (Imp (elimEquiv p)(elimEquiv q)) (Imp (elimEquiv q)(elimEquiv p)))


-- Función que elimina las implicaciones lógicas. --

elimImp :: Prop -> Prop
elimImp (T) = (T)
elimImp (F) = (F)
elimImp (VarProp x) = (VarProp x)
elimImp (Neg p) = (Neg (elimImp p))
elimImp (And p q) = (And (elimImp p) (elimImp q))
elimImp (Or p q) = (Or (elimImp p) (elimImp q))
elimImp (Imp p q) = (Or (Neg (elimImp p)) (elimImp q))
elimImp (DouImp p q) = (DouImp (elimImp p) (elimImp q))


-- Funcion que recibe una formula y devuelve la misma formula sin doble negacion y donde las unicas formulas negadas son atomicas --

iNeg :: Prop -> Prop
iNeg (T) = (T)
iNeg (F) = (F)
iNeg (VarProp p) = (VarProp p)
iNeg (Neg(Neg p)) = p
iNeg (Neg(And p q)) = (Or (iNeg (Neg(p))) (iNeg (Neg(q))))
iNeg (Neg(Or p q)) = (And (iNeg (Neg(p))) (iNeg (Neg(q)))) 
iNeg (Neg p) = (Neg (iNeg p))
iNeg (And p q) = (And (iNeg p) (iNeg q))
iNeg (Or p q) = (Or (iNeg p) (iNeg q))
iNeg (Imp p q) = (Imp (iNeg p) (iNeg q))
iNeg (DouImp p q) = (DouImp (iNeg p) (iNeg q))


-- Funcion que recibe una formula y la devuelve en Forma Normal Negativa--

fnn :: Prop -> Prop
fnn (T) = (T)
fnn (F) = (F)
fnn (VarProp p) = (VarProp p)
fnn (Neg (VarProp x)) = (Neg (VarProp x))
fnn (Neg p) = iNeg (elimImp (elimEquiv (Neg p)))
fnn (And p q) = iNeg (elimImp (elimEquiv (And p q)))
fnn (Or p q) = iNeg (elimImp (elimEquiv (Or p q)))
fnn (Imp p q) = iNeg (elimImp (elimEquiv (Imp p q)))
fnn (DouImp p q) = iNeg (elimImp (elimEquiv (DouImp p q)))


--Función auxiliar para reconocer si una formula es literal--

literal :: Prop -> Bool
literal (T) = False
literal (F) = False
literal (VarProp x) = True
literal (Neg (VarProp x)) = True
literal (Neg p) = False
literal (And p q) = False
literal (Or p q) = False
literal (Imp p q) = False
literal (DouImp p q) = False


-- Función para distribuir correctamente --

distribuir :: Prop -> Prop -> Prop
distribuir (Or p q) (r) = (Or (Or (p) (q)) (r))
distribuir (r) (Or p q) = (Or (Or (r) (p)) (q))
distribuir (And p q) (r) = (And (distribuir (p) (r)) (distribuir (q)(r)))
distribuir (r) (And p q) = (And (distribuir (r) (p)) (distribuir (r)(q)))
distribuir (p) (q) = if literal (p) && literal (q) == True then (Or (p) (q)) else distribuir (p) (q)


-- Funcion que recibe una formula y la devuelve en Forma Normal Conjuntiva --

fnc :: Prop -> Prop
fnc (T) = (T)
fnc (F) = (F)
fnc (And p q) = (And (fnc (p)) (fnc (q)))
fnc (Or p q) = distribuir (fnc (p)) (fnc (q))
fnc (Imp p q) = fnc(fnn((Imp p q)))
fnc (DouImp p q) = fnc(fnn((DouImp p q)))
fnc (p) = if literal (p) == True then p else fnc (p)


type Clausula = [literal]

clausulaFNC :: Prop -> [Clausula]
clausulaFNC (T) = []
clausulaFNC (F) = []
clausulaFNC (VarProp x) = [(VarProp x)]
clausulaFNC (p) = if literal (p) == True then [p] else []
clausulaFNC (Neg p) = clausulaFNC (p)