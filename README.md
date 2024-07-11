# coordinus-backend

## Resumen de la app

Aplicación de backend para el sistema **CoordinUs** desarrollada como desafío para postular al cargo de desarrollador fullstack semi senior en Recorrido.cl.

El sistema CoordiUs permite coordinar turnos entre trabajadores con el fin de monitorear servicios de clientes.

Se utilizó el stack Rais 7.1.3.4 + Ruby 3.3.3 + PostgreSQL 14.12

## Componentes

### Models
- **ClientService**: modelo utilizado para almacenar la información de los servicios monitoreados.
- **ScheduleDay**: modelo utilizado para almacenar los diferentes horarios de la semana de un servicio considerando el día de la semana y multiples rangos horarios definidos por el modelo ScheduleTimeRange.
- **ScheduleTimeRange**: modelo utilizado para almacenar un rango de horarios.
- **User**: modelo utilizado para almacenar la información de los usuarios del sistema.
- **Shift**: modelo utilizado para almacenar la información de un turno. Este es el modelo más importante ya que considera al usuario a quien se asignó el turno, a los usuarios disponibles para el turno, una hora de inicio, una hora de fin, entre otro detalles necesarios como métodos de instancia y de clase para facilitar la manipulación de su información.
### Commands
- GetOptimalShiftsAssignations: este command encapsula la lógica dedicada a la asignación de turnos.
### Services
- ShiftService: este service encapsula la lógica de turnos.

## pasos para ejecutar la app

### instalar las siguientes dependencias
- ruby 3.3.3
- rails 7.1.3.4
- postgreSQL 14.12
- ejecutar bundle install para instalar gemas del proyecto.

### Configuración
- se debe contar con un archivo **.env.local** que contenga las siguientes variables para la conexión con la base de datos

```
DATABASE_USERNAME=user
DATABASE_PASSWORD=password
```

- corrobora tener levantado postgresql en tu ambiente local, este comando te puede servir en sistema operativo linux.

```
sudo systemctl status postgresql
```

- luego se puede utilizar el siguiente comando para crear la base de datos, hacer las migraciones y poblar la base de datos a partir de semillas.

```
rails db:setup
```

### levantar servidor local

finalmente puedes utilizar el siguiente comando para levantar el servidor local

```
rails s
```
