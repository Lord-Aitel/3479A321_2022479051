# Buscaminas Pro

## Descripción
Buscaminas Pro es una aplicación móvil desarrollada en Flutter como parte del laboratorio de programación de dispositivos móviles.  
El proyecto recrea el clásico juego de Buscaminas, integrando funcionalidades modernas como audio, acelerómetro y compartir resultados.

## Características
- Pantalla inicial con navegación jerárquica.
- Tablero dinámico con celdas revelables.
- Sonidos de interacción:
  - Click al descubrir celda segura.
  - Explosión al tocar una mina.
  - Sonido de victoria al completar el tablero.
- Reinicio del juego al agitar el dispositivo (acelerómetro).
- Botón de SharePlus para compartir resultados.
- Pantalla About con información del proyecto.

## Estructura del Proyecto
- `lib/models/` → Modelos de datos (CellModel).
- `lib/viewmodels/` → Lógica del juego (GameViewModel).
- `lib/ui/screens/` → Pantallas principales (Splash, Lista, Detalle, About).
- `lib/ui/widgets/` → Widgets reutilizables (MineCell).

## Instalación y Ejecución
1. Clonar el repositorio:
   ```bash
   git clone <https://github.com/Lord-Aitel/3479A321_2022479051/tree/feature/hardware_identity>
