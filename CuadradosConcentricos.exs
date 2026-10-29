defmodule Cuadrados do
  @moduledoc """
  Módulo que genera un archivo svg con cuadrados concéntricos.

  ## Información
  - **Versión:** 1.0
  - **Autor:** Simon L. Estrada.- Luna S. Oviedo R. - David A. Henao J.
  - **Fecha:** octubre de 2026
  - **Licencia:** GNU GPL v3
  """
  # Este valor lo tomamos del ejemplo cuadrados.svg el cual
  # El profesor Adjunto en las Aulas Virtuales
  @margen 15
  # Grosor de los cuadrados, en svg se tiene un Stroke-width="3"
  @grosor 3
  # Estos son lo colores que se usaran para los cuadrados, tambien se reutilizaron del ejemplo propuesto.
  @colores ["#2865a6", "#4198b5", "#50a9a0", "#6b9c71", "#b2a451", "#d78c49", "#bd6660"]

  @doc """
  Genera un archivo svg con cuadrados concéntricos.

  ## Parámetros
  - `archivo`: Nombre del archivo svg a generar.
  - `lado`: Longitud del lado del cuadrado más grande.
  - `cantidad`: Cantidad de cuadrados concéntricos a generar.
  - `reduccion`: Factor de reducción para cada cuadrado concéntrico.
  ## Ejemplo
      iex> Cuadrados.generar("cuadrados.svg", 200, 5, 0.8)
      :ok
  """
  def generar(archivo, lado, cantidad, reduccion) do
    total = lado + 2 * @margen
    figura = cuadrados(@margen, @margen, lado, cantidad, reduccion, @colores, "")

    svg = """
    <svg xmlns="http://www.w3.org/2000/svg" width="#{total}" height="#{total}">
    <rect width="100%" height="100%" fill="white"/>
    #{figura}
    </svg>
    """

    File.write!(archivo, svg)
    IO.puts("Imagen creada: #{archivo} (#{cantidad} cuadrados, lado #{lado}, reduccion #{reduccion})")
  end

  # Caso 1: Cuando ya se dibujaron todos los cuadros solicitados.
  defp cuadrados(_x, _y, _lado, faltantes, _reduccion, _colores, acc ) when faltantes <= 0, do: acc

  # Caso 2: Cuando el lado ya no es positivo (lado <= 0)
  # Previene que se dibujen cuadrados con dimensiones negativas o nulas si la reducción es muy grande.
  defp cuadrados(_x, _y, lado, _faltantes, _reduccion, _colores, acc) when lado <= 0, do: acc

  # Caso 3: El caso recursivo (Se dibuja cuadro por cuadro)
  defp cuadrados(x, y, lado, faltantes, reduccion, [color_actual | colores_restantes], acc) do
    # 1. Generamos la etiqueta SVG del cuadrado actual, utilizando el color extraído de la lista de colores.
    rect_actual = """
    <rect x="#{x}" y="#{y}" width="#{lado}" height="#{lado}" fill="none" stroke="#{color_actual}" stroke-width="#{@grosor}"/>
    """

    # 2. Calculamos los valores para el siguiente cuadrado concéntrico.
    nuevo_lado = lado - reduccion
    nueva_x = x + (reduccion / 2)
    nueva_y = y + (reduccion / 2)

    # 3. Reorganizamos la lista de collores para que sea un ciclo infinito (el primero se mueve al final).
    siguientes_colores = colores_restantes ++ [color_actual]

    # 4. Acumulamos el texto generado y llamamos nuevamente a la función.
    nuevo_acc = acc <> rect_actual
    cuadrados(nueva_x, nueva_y, nuevo_lado, faltantes - 1, reduccion, siguientes_colores, nuevo_acc)
  end

end
