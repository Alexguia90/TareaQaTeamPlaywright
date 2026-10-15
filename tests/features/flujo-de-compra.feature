Feature: Flujo de compra en SauceDemo
  Como usuario registrado
  Quiero completar una compra exitosamente
  Para recibir mis productos

  # Background se ejecuta antes de cada Scenario — evita repetir el Given inicial
  Background:
    Given el usuario navega a la pagina de SauceDemo

  @smoke @HappyPath
  Scenario: Checkout exitoso con producto en el carrito
    When inicia sesion con usuario "standard_user" y contrasena "secret_sauce"
    And agrega el backpack al carrito y va al carrito
    Then el usuario procede al checkout

  # Scenario Outline: ejecuta el mismo escenario con distintos conjuntos de datos
  @regression
  Scenario Outline: Checkout con diferentes usuarios validos
    When inicia sesion con usuario "<usuario>" y contrasena "<contrasena>"
    And agrega el backpack al carrito y va al carrito
    Then el usuario procede al checkout

    Examples:
      | usuario                 | contrasena   |
      | standard_user           | secret_sauce |
      | performance_glitch_user | secret_sauce |

  @smoke @regression
  Scenario: Checkout completo hasta la confirmacion del pedido
    When inicia sesion con las credenciales del entorno
    And agrega el backpack al carrito y va al carrito
    Then el contador del carrito debe mostrar "1"
    And el carrito debe tener 1 productos
    And el carrito debe contener el producto "Sauce Labs Backpack"
    And el usuario procede al checkout
    And completa sus datos con nombre "Juan", apellido "Perez" y codigo postal "12345"
    Then el resumen del pedido debe mostrar el producto "Sauce Labs Backpack" y el total "$32.39"
    And finaliza la compra
    Then deberia ver el mensaje de confirmacion del pedido

  @regression
  Scenario: Checkout falla si faltan datos obligatorios
    When inicia sesion con usuario "standard_user" y contrasena "secret_sauce"
    And agrega el backpack al carrito y va al carrito
    And el usuario procede al checkout
    And intenta continuar sin completar sus datos
    Then deberia ver el mensaje de error "Error: First Name is required"

