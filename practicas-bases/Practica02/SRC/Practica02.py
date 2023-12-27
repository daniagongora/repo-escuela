#from Empleado import *
from Sucursal import *
#from Producto import *
import Empleado
import Producto

#empleado = Empleado()
sucursal = Sucursal()
#producto = Producto()


def menuPrincipal():
    '''
    Menu principal
    '''
    seguir = True
    print("********** Bienvenido a la Base de Datos **********")
    while seguir:
        try:
            print("-> Selecciona la entidad que quieres administrar:")
            print("1. Empleados")
            print("2. Productos")
            print("3. Sucursales")
            print("4. Salir")
            print("Opcion: ")
            opcion = (int(input()))
            if opcion == 1:
               Empleado.manejaEmpleados()
            elif opcion == 2:
                Producto.manejaProductos()
            elif opcion == 3:
               print("Esto aun no esta implementado :(")
            elif opcion == 4:
                print("Gracias por ingresar a la base de datos")
                seguir = False
            else:
                print("Por favor introduce una opcion valida")
        except:
            print("\nPor favor introduce un numero.")

def main():
	"""
	Ejecuta el menu principal que corre la base de datos
	"""
	menuPrincipal()
	
if __name__=="__main__":

	main()
