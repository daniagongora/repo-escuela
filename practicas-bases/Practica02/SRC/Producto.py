import pandas as pd
class Producto:
   
    def IDProducto():
        """
        Método que regresa el ID unico creado para cada producto.
        """
        productos = pd.read_csv("Producto.csv")
        id = productos.iloc[-1,0]
        unicoID = id[0] + str(int(id[1:])+1)
        return unicoID
   
    def existeProducto(id):
        """
        Método que verifica si existe ya un Producto 
        """
        productos = pd.read_csv("Producto.csv")
        for i in range(0, len(productos)):
            if(productos.iloc[i,0] == id):
                return True

        return False
    
    def renglonProducto(id):
        """
        Método que devuelve el numero de reglon donde se encuentra el Producto
        """
        productos = pd.read_csv("Producto.csv")
        for i in range(0, len(productos)):
            if(productos.iloc[i,0] == id):
                return i
        return -1
    
def buscarProducto():
    """
    Método que nos permite buscar un empleado por su ID 
    """
    productos = pd.read_csv("Producto.csv") 
    id = input("Pon el ID del empleado que quieres buscar ")
    if(Producto.existeProducto(id) == True):
        print("Resultado: ")
        print(productos.loc[[Producto.renglonProducto(id)]])
    else:
        print("Ese Producto no existe")

def eliminarProducto():
    
    """
    Método para eliminar un Producto
    """
    productos = pd.read_csv("Producto.csv") 
    id = input("ID del empleado a eliminar")
    if(Producto.existeProducto(id) == True):
        resultado = productos.drop(productos.index[Producto.renglonProducto(id)])
        print("Se borro al Producto")
        resultado.to_csv("Producto.csv", index=False)
    else:
        print("No existe ese Producto")

def agregarProducto():
    """
    Método para agregar un Producto
    """
    productos = pd.read_csv("Producto.csv") 
    id = Producto.IDProducto()
    nombre = input("\n- Escribe nombre del producto: ")
    marca = input(" Escribe el nombre de la marca del producto ")
    presentacion = input(" Escribe la presentación del producto ((bolsa, lata, botella, etc.): ")
    precio = input(" Escribe el precio del producto")
    cantidad = input(" Escribe la cantidad del producto ")
    stock = input(" Escribe la cantidad de stock del producto: ")
    refrigeracion = input(" Escribe si el producto requiere refrigeración (Si o No) ")
    fechaElaboracion = input("Escribe la fecha de elaboración del producto (Formato DD-MM-AAAA)")
    fechaCaducidad = input("Escribe la fecha de caducidad del producto (Formato DD-MM-AAAA)")
    nuevoProducto = pd.Series([id, nombre, marca, presentacion, precio, cantidad, stock, refrigeracion, fechaElaboracion, fechaCaducidad], index=["IdProducto","Nombre","Marca","Presentacion","Precio","Cantidad","Stock","Refrigeracion","FechaElaboracion","FechaCaducidad"])
    
    resultado = pd.concat([productos, nuevoProducto.to_frame().T], ignore_index=False)
    print(resultado)
    resultado.to_csv("Producto.csv", index=False)
    print("Producto agregado al archivo.")

def editarProducto():
    """
    Método para modificar los datos de un empleado
    """
    productos = pd.read_csv("Producto.csv") 
    id = input("\n-> Escribe el ID del empleado que quieres editar: ")
    if(Producto.existeProducto(id)):
        seguir = True
        while seguir:
            try:
                
                print("\n- Escribe el número del dato que quieras editar ")
                print("1.- Nombre")
                print("2.- Marca")
                print("3.- Presentación")
                print("4.- Precio")
                print("5.- Cantidad")
                print("6.- Cantidad de Stock")
                print("7.- Refrigeración")
                print("8.- Fecha de elaboración")
                print("9.- Fecha de Caducidad")
                print("Escogiste la opcion: ")
                opcion = (int(input()))
                
                if opcion == 1:
                    nuevo = input(" Escribe el nuevo nombre del producto: ")
                    productos.iloc[Producto.renglonProducto(id),1] = nuevo
                    seguir = False
                elif opcion == 2:
                    nuevo = input(" Escribe la nueva marca del producto: ")
                    productos.iloc[Producto.renglonProducto(id),2] = nuevo
                    seguir = False
                elif opcion == 3:
                    nuevo = input(" Escribe la nueva presentación del producto: ")
                    productos.iloc[Producto.renglonProducto(id),3] = nuevo
                    seguir = False
                elif opcion == 4:
                    nuevo = input(" Escribe el nuevo precio del producto: ")
                    productos.iloc[Producto.renglonProducto(id),4] = nuevo
                    seguir = False
                elif opcion == 5:
                    nuevo = input(" Escribe la nueva cantidad del producto: ")
                    productos.iloc[Producto.renglonProducto(id),5] = nuevo
                    seguir = False
                elif opcion == 6:
                    nuevo = input(" Escribe la nueva cantidad de stock del producto: ")
                    productos.iloc[Producto.renglonProducto(id),6] = nuevo
                    seguir = False
                elif opcion == 7:
                    nuevo = input(" Escribe si el producto requiere refrigeración o no (Si o No): ")
                    productos.iloc[Producto.renglonProducto(id),7] = nuevo
                    seguir = False
                elif opcion == 8:
                    nuevo = input(" Escribe la nueva fecha de elaboración del producto: ")
                    productos.iloc[Producto.renglonProducto(id),8] = nuevo
                    seguir = False
                elif opcion == 9:
                    nuevo = input(" Escribe la nueva fecha de caducidad del producto: ")
                    productos.iloc[Producto.renglonProducto(id),9] = nuevo
                    seguir = False
                else:
                    print("Escribe una opcion valida")
            except:
                print("Escribe un numero")
        productos.to_csv("Producto.csv", index=False)
    else:
        print("No existe ese Producto, intenta de nuevo")


def manejaProductos():
    """
    Muestra todo el manejo de datos que se tiene para los empleados
    """
    seguir = True
    print("           Base de Datos para Productos         ")
    while seguir:
        try:
            productos = pd.read_csv("Producto.csv")
            print("\n-> Escribe que opcion quieres realizar")
            print("1. Ver Productos")
            print("2. Agregar un producto")
            print("3. Editar datos de un productos")
            print("4. Eliminar a un producto")
            print("5. Buscar a un producto mediante su ID")
            print("6. Atras")
            opcion = (int(input()))
            if opcion == 1:
                print(productos)
            elif opcion == 2:
                productos = pd.read_csv("Producto.csv")
                agregarProducto()
            elif opcion == 3:
                productos = pd.read_csv("Producto.csv")
                editarProducto()
            elif opcion == 4:
                productos = pd.read_csv("Producto.csv")
                eliminarProducto()
            elif opcion == 5:
                productos = pd.read_csv("Producto.csv")
                buscarProducto()
            elif opcion == 6:
                seguir = False
            else:
                print("Introduce una opcion valida")
        except:
            print("Introduce un numero.")
