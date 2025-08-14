# Gestion-de-Parqueos-Urbanos
# 📱 App User Parking

Aplicación móvil desarrollada en **Flutter** para la gestión de parqueos urbanos, pensada para ofrecer a los usuarios una forma rápida, segura y organizada de **reservar, pagar y administrar estacionamientos** desde su teléfono.

---

## 🎯 Objetivo de la App
Brindar a los usuarios una plataforma intuitiva para:
- **Localizar parqueos disponibles** en tiempo real.
- **Reservar espacios** de forma anticipada.
- **Realizar pagos electrónicos** de manera segura.
- **Recibir notificaciones** de confirmaciones, pagos pendientes y actualizaciones importantes.
- **Gestionar su perfil y sus reservas pasadas**.

Con esta app se busca **optimizar la experiencia del usuario**, reducir tiempos de búsqueda de estacionamiento y mejorar la eficiencia de los operadores de parqueos.

---

## ✨ Funcionalidades Principales

### 1. 🗺 Mapa de Parqueos
- Visualiza parqueos disponibles cerca de tu ubicación.
- Filtra por distancia, precio o disponibilidad.
- Obtén información detallada de cada parqueo.

### 2. 📅 Reservas
- Reserva un espacio para una fecha y hora específicas.
- Visualiza el estado de tus reservas.
- Cancela o modifica reservas (según políticas del parqueo).

### 3. 🔔 Notificaciones
- Recibe alertas en tiempo real sobre:
  - Confirmaciones de reserva.
  - Pagos pendientes.
  - Actualizaciones de la aplicación.
- Notificaciones locales (estáticas) y soporte para push notifications.

### 4. 💳 Pagos
- Paga desde la app con tarjeta de crédito/débito o métodos digitales compatibles.
- Consulta historial de pagos.
- Recibe comprobantes digitales.

### 5. 👤 Perfil
- Gestiona tus datos personales.
- Consulta tu historial de actividad.
- Configura preferencias de notificaciones.

---

## 🏗 Arquitectura del Proyecto

La aplicación sigue una **arquitectura modular** con separación clara de responsabilidades:
lib/
├── main.dart # Punto de entrada de la app
├── models/ # Modelos de datos (Reservation, NotificationItem, etc.)
├── screens/ # Pantallas principales (Mapa, Reservas, Notificaciones, Pagos, Perfil)
├── widgets/ # Widgets reutilizables
└── services/ # Servicios (API, autenticación, base de datos)



