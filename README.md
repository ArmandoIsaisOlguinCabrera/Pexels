# Pexels

Esta aplicación esta desarrollada en SwiftUI para mostrar videos obtenidos desde la API de Pexels. La aplicación consta de dos pantallas principales: una lista de videos y una vista detallada de cada video con la posibilidad de reproducirlo. Se utiliza Realm para la persistencia de datos y XCTest para pruebas unitarias y de interfaz de usuario.

## Estructura de la APP

### Network:

- **APIService.swift:** Contiene la lógica para realizar solicitudes a la API de Pexels y manejar la respuesta.
- **NetworkMonitor.swift:** Monitorea la conectividad de red utilizando Network.framework y publica cambios a través de Combine.
- **RealmManager.swift:** Gestiona la persistencia de datos utilizando Realm para almacenar y recuperar objetos de tipo Video.

### Model:

- **Video:** Representa el modelo de datos de un video obtenido de la API de Pexels.

### Views:

- **ContentView.swift:** La vista principal que muestra la lista de videos y gestiona la visualización del estado de red.
-- **VideoRow.swift:** Dentro de ContentView.swift Define el diseño de cada fila en la lista de videos mostrada en ContentView.
-- **NetworkStatusView.swift:** Dentro de ContentView.swift Es una vista para mostrarse al centro del dispositivo cuendo no se tiene conexion a internet.
- **DetailView.swift:** La vista detallada que muestra información específica de cada video como el nombre de usuario, un thumbnail, la duracion y un boton que  permite reproducirlo en una instancia de AVPlayer.


### ViewModel:

- **VideoViewModel.swift:** Gestiona los datos de los videos y la conectividad de red, utilizando Combine para la reactividad de datos.

### Tests:
- **MockAPIService.swift:** Proporciona una implementación simulada de APIService para pruebas unitarias.
- **PexelsTests.swift:** Contiene pruebas unitarias para validar la obtención y persistencia de videos utilizando Realm.
- **PexelsUITests.swift:** Pruebas de interfaz de usuario que validan la visualización y navegación de videos en la aplicación.

## Documentación de Vistas

### ContentView.swift
La vista principal que muestra la lista de videos y gestiona la visualización del estado de red.
![ContentView](https://drive.google.com/uc?id=1zbdZqjGWH0WceBisebNUoNQfxHDV0GHE)
**Componentes:**
- NavigationView: Proporciona soporte de navegación para mostrar una lista de videos.
- List: Muestra una lista de vistas VideoRow, representando cada elemento de video obtenido de la API.
- NavigationLink: Permite la navegación a DetailView para cada video seleccionado.
- NetworkStatusView: Muestra condicionalmente una vista con un mensaje cuando el dispositivo está fuera de línea.
- VideoViewModel: Gestiona los datos y la lógica de negocio para obtener y mostrar videos.
- AsyncImage: Muestra miniaturas de videos cargadas de forma asíncrona desde URLs.
- Inicialización del ViewModel: Inicializa VideoViewModel para obtener videos y monitorear la conectividad de red.

### VideoRow.swift
Define el diseño de cada fila en la lista de videos mostrada en ContentView. Muestra información básica sobre cada video, como el nombre del usuario y la duración del video.

**Componentes:**
- HStack: Arregla vistas horizontalmente para mostrar la miniatura del video y detalles del video.
- AsyncImage: Carga y muestra la miniatura del video de forma asíncrona desde una URL.
- Text: Muestra el nombre del usuario que subió el video y la duración del video.
- AccessibilityIdentifier: Agrega identificadores de accesibilidad a elementos para pruebas de interfaz de usuario.

### NetworkStatusView.swift
Define una vista para mostrarse cuando no hay red.
![ContentView](https://drive.google.com/uc?id=1hKgqIa09dQ9fghvjdWoi6dOwX0ihVBCj)
![ContentView](https://drive.google.com/uc?id=1bR34AYOhCgnWoLJAEaLFMf9bNT4B6AnN)


### DetailView.swift
Define la vista detallada para cada video seleccionado. Muestra más información sobre el video y permite al usuario reproducirlo utilizando AVPlayer.
![ContentView](https://drive.google.com/uc?id=1kwi6kJG3oaW_oIa65932A_ncmL2wgA6C)
![ContentView](https://drive.google.com/uc?id=14j2lpSOFf5jI0LkaRYWR7CE0utsFmie4)


**Componentes:**
- VStack: Arregla vistas verticalmente para mostrar detalles del video y el reproductor de video.
- AsyncImage: Carga y muestra la miniatura del video de forma asíncrona desde una URL.
- Text: Muestra información detallada sobre el video, como su duración.
- Button: Permite al usuario reproducir el video utilizando AVPlayer.
- VideoPlayer: Reproduce el archivo de video seleccionado por el usuario.
