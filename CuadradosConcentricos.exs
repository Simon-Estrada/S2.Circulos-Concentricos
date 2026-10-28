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
    figura = cuadrados(@margen, @margen, lado, cantidad, reduccion, "")

    svg = """
    <svg xmlns="http://www.w3.org/2000/svg" width="#{total}" height="#{total}">
    <rect width="100%" height="100%" fill="white"/>
    #{figura}
    </svg>
    """

    File.write!(archivo, svg)
    IO.puts("Imagen creada: #{archivo} (#{cantidad} cuadrados, lado #{lado}, reduccion #{reduccion})")
  end
end
