Feature: Inventario y carrito en SauceDemo
  Como usuario registrado
  Quiero administrar los productos del carrito
  Para preparar mi compra

  Background:
    Given el usuario navega a la pagina de SauceDemo

  @regression
  Scenario: Agregar multiples productos y verificar el contador del carrito
    When inicia sesion con usuario "standard_user" y contrasena "secret_sauce"
    And agrega 3 productos al carrito
    Then el contador del carrito debe mostrar "3"

  @regression
  Scenario: Quitar un producto del carrito antes de pagar
    When inicia sesion con usuario "standard_user" y contrasena "secret_sauce"
    And agrega el backpack al carrito y va al carrito
    And quita el primer producto del carrito
    Then el carrito debe tener 0 productos

  @regression
  Scenario: Ordenar productos de menor a mayor precio
    When inicia sesion con usuario "standard_user" y contrasena "secret_sauce"
    And ordena los productos por "Price (low to high)"
    Then el primer producto listado debe ser el mas barato