import mysql.connector

def conectar():
    conexion = mysql.connector.connect(
        host='localhost',
        user='root',
        password='',
        database='biblioteca'
    )
    return conexion

def consultar_libros_mas_populares():
    SQL = "SELECT titulo, calificacion FROM libros WHERE calificacion >= 4 ORDER BY calificacion DESC"
    conexion = conectar()
    cursor = conexion.cursor()
    cursor.execute(SQL)
    resultado = cursor.fetchall()
    for libro in resultado:
        print(f"Título: {libro[0]}, Calificación: {libro[1]}")
    cursor.close()
    conexion.close()

def quitar_libro_menu():
    SQL = "SELECT id_libro, titulo FROM libros ORDER BY titulo"
    conexion = conectar()
    cursor = conexion.cursor()
    cursor.execute(SQL)
    libros = cursor.fetchall()
    if not libros:
        print("No hay libros para eliminar.")
        cursor.close()
        conexion.close()
        return

    print("Libros disponibles para eliminar:")
    for idx, libro in enumerate(libros, 1):
        print(f"{idx}: {libro[1]}")

    while True:
        try:
            opcion = int(input("Elige el número del libro a eliminar: "))
            if 1 <= opcion <= len(libros):
                id_libro = libros[opcion-1][0]
                break
            else:
                print("Opción inválida, intenta de nuevo.")
        except ValueError:
            print("Ingresa un número válido.")

    SQL_delete = "DELETE FROM libros WHERE id_libro = %s"
    cursor.execute(SQL_delete, (id_libro,))
    conexion.commit()
    print(f'Libro "{libros[opcion-1][1]}" se elimino del sistema.')
    cursor.close()
    conexion.close()

def agregar_libro(titulo, autor, genero, publicacion, cantidad_disponible, calificacion):
    SQL = "INSERT INTO libros (titulo, autor, genero, publicacion, cantidad_disponible, calificacion) VALUES (%s, %s, %s, %s, %s, %s)"
    valores = (titulo, autor, genero, publicacion, cantidad_disponible, calificacion)
    conexion = conectar()
    cursor = conexion.cursor()
    cursor.execute(SQL, valores)
    print(cursor.statement)
    conexion.commit()
    cursor.close()
    conexion.close()

def seleccionar_todos_los_libros():
    SQL = "SELECT * FROM libros ORDER BY titulo"
    conexion = conectar()
    cursor = conexion.cursor()
    cursor.execute(SQL)
    resultado = cursor.fetchall()
    cursor.close()
    conexion.close()
    return resultado

def busqueda_binaria_libros(libros, titulo):
    inicio = 0
    fin = len(libros) - 1
    while inicio <= fin:
        medio = (inicio + fin) // 2
        titulo_medio = libros[medio][1]  
        if titulo_medio == titulo:
            return libros[medio]
        elif titulo_medio < titulo:
            inicio = medio + 1
        else:
            fin = medio - 1
    return None

def buscar_libro_por_titulo(titulo):
    libros = seleccionar_todos_los_libros()
    resultado = busqueda_binaria_libros(libros, titulo)
    if resultado:
        print("Libro encontrado:", resultado)
    else:
        print("Libro no encontrado")

if __name__ == "__main__":
    def opcion1():
        consultar_libros_mas_populares()

    def opcion2():
        quitar_libro_menu()

    def opcion3():
        agregar_libro("El gran Gatsby", "F. Scott Fitzgerald", "Novela", "1948-05-21", 5, 4)

    def opcion4():
        buscar_libro_por_titulo("El gran Gatsby")

    switch = {
        1: opcion1,
        2: opcion2,
        3: opcion3,
        4: opcion4,
    }

    eleccion = int(input("Elige una opción (1-4): "))
    resultado = switch.get(eleccion, lambda: print("Opción no válida"))()