Feature: Inicio de sesion en SauceDemo
  Como usuario
  Quiero iniciar sesion con mis credenciales
  Para acceder a SauceDemo

  Background:
    Given el usuario navega a la pagina de SauceDemo

  @smoke
  Scenario: Login fallido con credenciales incorrectas
    When inicia sesion con usuario "standard_user" y contrasena "clave_invalida"
    Then deberia ver el mensaje de error "Username and password do not match any user in this service"

  @smoke @regression
  Scenario: Login fallido con usuario bloqueado
    When inicia sesion con usuario "locked_out_user" y contrasena "secret_sauce"
    Then deberia ver el mensaje de error "Sorry, this user has been locked out"

  @regression
  Scenario: Login fallido con usuario inexistente
    When inicia sesion con usuario "usuario_inventado" y contrasena "secret_sauce"
    Then deberia ver el mensaje de error "Username and password do not match any user in this service"