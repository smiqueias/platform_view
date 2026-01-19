# Platform View

Demo iOS | Demo Android
:-:|:-:
<img src="https://github.com/user-attachments/assets/d06bc6ae-3f5f-4029-b78b-d2a6643fec8f" width="240" alt="Demonstração 1"> | <img src="https://github.com/user-attachments/assets/249d48e7-6418-4c64-93f3-f04801b889b2" width="240" alt="Demonstração 2">


# Diagrama de comunicação
<img width="750"  alt="platform_view" src="https://github.com/user-attachments/assets/69d18414-1d30-4851-8498-5284d7f35d76" />

# Restrições de Navegação
Como o módulo nativo é renderizado dentro de uma área limitada (PlatformView) que está contida em uma BottomSheet do Flutter. Quando você usa startActivity() (Android) ou pushViewController() (iOS), você está tentando navegar para fora desse contexto limitado, ao invés disso toda a navegação deve ocorrer dentro do `View`.
