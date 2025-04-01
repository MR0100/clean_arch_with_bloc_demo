# kgk

project showcasing the hands on experience working with bloc, get_it clean architecture and many more.

## Dependencies Used

1. flutter_bloc
1. get_it
1. json_serializable

## Project Structure

```dart
kgk/  📂 (Project Root)
│
├── 📂 android/  📱 (Android Native Code)
├── 📂 ios/  🍏 (iOS Native Code)
├── 📂 linux/  🐧 (Linux Support)
├── 📂 macos/  🍎 (MacOS Support)
├── 📂 windows/  🖥️ (Windows Support)
├── 📂 web/  🌐 (Web Support)
├── 📂 test/  🧪 (Unit & Widget Tests)
│
├── 📂 lib/  🏗️ (Main Source Code)
│       ├── 📂 core/  🔧 (App-wide utilities & core functionalities)
│       │       ├── 📂 helper/  🛠️ (Utility functions)
│       │       │       ├── 📜 converter_helper.dart  (Static helper methods)
│       │       │       ├── 📜 other_helpers.dart  (General helper functions)
│       │       │
│       │       ├── 📂 network/  🌐 (API & Networking)
│       │       │       ├── 📜 api_config.dart
│       │       │
│       │       ├── 📂 router/  🚏 (Navigation handling)
│       │       │       ├── 📜 app_router.dart  (All navigation paths & route generation)
│       │       │
│       │       ├── 📂 styles/  🎨 (Theme & UI styles)
│       │       │       ├── 📜 app_colors.dart  (Global color settings)
│       │       │       ├── 📜 app_fonts.dart  (Reusable text styles)
│       │       │
│       │       ├── 📂 translation/  🌍 (Localization)
│       │       │       ├── 📜 en.json
│       │       │       ├── 📜 fr.json
│       │       │
│       │       ├── 📂 utils/  🧩 (General utilities)
│       │       │       ├── 📂 constants/  🔢 (Global constants)
│       │       │       │       ├── 📜 app_consts.dart  (Global constants)
│       │       │       │       ├── 📜 app_data.dart  (Shared app data)
│       │       │       │       ├── 📜 app_types.dart  (Type definitions)
│       │       │       │       ├── 📜 app_enums.dart  (Global enums)
│       │       │       │
│       │       │       ├── 📂 log/  📝 (Logging utilities)
│       │       │       ├── 📂 usecases/  ⚙️ (Business logic use cases)
│       │       │       ├── 📂 validators/  ✅ (Input validation)
│       │       │       │       ├── 📜 input_validator.dart  (Validation for email, phone, password, etc.)
│       │       │
│       │       ├── 📜 injections.dart  🏭 (Dependency Injection setup)
│       │
│       ├── 📂 feature/  🚀 (App Features)
│       │       ├── 📂 cart/  🛒 (Shopping Cart Feature)
│       │       │
│       │       ├── 📂 onboarding/  🎭 (User onboarding & authentication)
│       │       │       ├── 📂 data/  🗄️ (Data layer)
│       │       │       │       ├── 📂 repositories/  🏛️ (Implementation of repositories)
│       │       │       │       ├── 📂 source/  🔗 (Data sources)
│       │       │       │
│       │       │       ├── 📂 domain/  🧠 (Business logic)
│       │       │       │       ├── 📂 models/  📝 (Data models)
│       │       │       │       ├── 📂 repositories/  🏛️ (Abstract repository interfaces)
│       │       │       │       ├── 📂 usecases/  ⚙️ (Business logic use cases)
│       │       │       │
│       │       │       ├── 📂 presentation/  🎭 (UI & State Management)
│       │       │               ├── 📂 bloc/  🔄 (BLoC State Management)
│       │       │               │       ├── 📂 dashboard/
│       │       │               │       │       ├── 📜 dashboard_bloc.dart
│       │       │               │       │       ├── 📜 dashboard_event.dart
│       │       │               │       │       ├── 📜 dashboard_state.dart
│       │       │               │       │
│       │       │               │       ├── 📂 splash/
│       │       │               │       │       ├── 📜 splash_bloc.dart
│       │       │               │       │       ├── 📜 splash_event.dart
│       │       │               │       │       ├── 📜 splash_state.dart
│       │       │               │
│       │       │               ├── 📂 pages/  📄 (UI Screens)
│       │       │               │       ├── 📜 dashboard_page.dart
│       │       │               │       ├── 📜 splash_page.dart
│       │       │
│       │       ├── 📂 products/  📦 (Product Management)
│       │       │       ├── 📂 data/  🗄️ (Data layer)
│       │       │       │       ├── 📂 repositories/  🏛️ (Repository Implementation)
│       │       │       │       │       ├── 📜 product_repo_impl.dart
│       │       │       │       ├── 📂 sources/  🔗 (Data Sources)
│       │       │       │               ├── 📂 local/  💾 (Local Storage)
│       │       │       │                       ├── 📂 product/
│       │       │       │                               ├── 📜 product_api_impl.dart
│       │       │       │                               ├── 📜 product_api.dart
│       │       │       |
│       │       │       ├── 📂 domain/  🧠 (Business logic)
│       │       │       │       ├── 📂 models/  📝 (Product Models)
│       │       │       │       │       ├── 📂 product/
│       │       │       │       │       │       ├── 📂 diamond/
│       │       │       │       │       │       │       ├── 📜 product_diamond_schema.dart
│       │       │       │       │       │       │
│       │       │       │       │       │       ├── 📂 filter/
│       │       │       │       │       │               ├── 📜 filter_apply_schema.dart
│       │       │       │       │       │               ├── 📜 filter_data_schema.dart
│       │       │       │       │
│       │       │       │       ├── 📂 repositories/  🏛️ (Abstract Repositories)
│       │       │       │       │       ├── 📜 product_repo.dart
│       │       │       │       |
│       │       │       │       ├── 📂 usecases/  ⚙️ (Business logic)
│       │       │       │               ├── 📜 load_product_usecase.dart
│       │       │       |
│       │       │       ├── 📂 presentation/  🎭 (UI & State Management)
│       │       │               ├── 📂 bloc/  🔄 (State Management)
│       │       │               │       ├── 📂 filter/
│       │       │               │       │       ├── 📜 filter_bloc.dart
│       │       │               │       │       ├── 📜 filter_event.dart
│       │       │               │       │       ├── 📜 filter_state.dart
│       │       │               │       ├── 📂 product/
│       │       │               │               ├── 📜 product_bloc.dart
│       │       │               │               ├── 📜 product_event.dart
│       │       │               │               ├── 📜 product_state.dart
│       │       │               │
│       │       │               ├── 📂 pages/  📄 (UI Screens)
│       │       │                       ├── 📜 filter_result_page.dart
│       │       │                       ├── 📜 product_filter_page.dart
│       │       │                       ├── 📜 product_listing_page.dart
|       |       |
|       |
│       ├── 📂 shared/  🔗 (Common shared data for the entire app)
│       │       ├── 📂 data/  🗄️ (Shared data layer)
│       │       │       ├── 📂 repository/  🏛️ (Shared repository implementations)
│       │       │       │       ├── 📜 converter_repo_impl.dart
│       │       │       │
│       │       │       ├── 📂 source/  🔗 (Shared data sources)
│       │       │       │       ├── 📂 local/  💾 (Local Storage)
│       │       │       │           ├── 📜 converter_api.dart  (Abstract)
│       │       │       │           ├── 📜 converter_api_impl.dart  (Implementation)
│       │       │
│       │       ├── 📂 domain/  🧠 (Shared business logic)
│       │       │       ├── 📂 model/  📝 (Shared data models)
│       │       │       │       ├── 📂 converter/
│       │       │       │               ├── 📜 converter_request_model.dart
│       │       │       │
│       │       │       ├── 📂 repository/  🏛️ (Abstract repositories)
│       │       │       │       ├── 📜 converter_repo.dart
│       │       │       │
│       │       │       ├── 📂 usecases/  ⚙️ (Business logic use cases)
│       │       │               ├── 📜 convert_data_from_csv_usecase.dart
│       │       │
│       │       ├── 📂 presentation/  🎭 (Shared UI components)
│       │               ├── 📂 widgets/  🧩 (Reusable UI components)
│       │                       ├── 📂 buttons/  🔘 (Custom buttons)
│       │                       ├── 📂 input/  ⌨️ (Custom input fields)
│       │
│       ├── 📜 main.dart  🎯 (App Entry Point)
│
├── 📜 .gitignore  🚫 (Ignored files)
├── 📜 analysis_options.yaml  🔍 (Lint rules)
├── 📜 pubspec.yaml  📦 (Dependencies)
├── 📜 README.md  📖 (Project Documentation)
```
