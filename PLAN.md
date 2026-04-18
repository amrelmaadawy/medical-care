# Medical Care Flutter — Project Spec

## Project Context

This is a Flutter mobile app for medical care with full Arabic language support.
Architecture: MVVM + BLoC/Cubit.
Features: splash → onboarding → auth (signin/signup) → layout → home → history → chat → profile → reminder → diagnosis.
Every feature follows this folder structure: `feature/data` (model), `feature/repo`, `feature/model_view` (cubit + state), `feature/view`.
Use the existing code style throughout. Do not introduce new patterns unless instructed.

---

## Phase 1 — Fix Empty Files & Enable Assets

### Task 1.1 — Auth Model

Open `lib/features/auth/data/auth_model.dart`. It is currently empty (0 bytes).
Fill it with a Dart class named `AuthModel` containing these fields:
- `String id`
- `String token`
- `String name`
- `String email`

Add a `fromJson` factory constructor and a `toJson` method.

### Task 1.2 — Signin ViewModel

Open `lib/features/auth/signin/signin_viewmodel.dart`. It is currently empty (0 bytes).
Create a Cubit class named `SigninCubit` with a corresponding `SigninState`.
States: `SigninInitial`, `SigninLoading`, `SigninSuccess(AuthModel user)`, `SigninError(String message)`.
The Cubit must have a `signin(String email, String password)` method that calls `AuthRepo.signin()`.

### Task 1.3 — Signup ViewModel

Open `lib/features/auth/signup/signup_viewmodel.dart`. It is currently empty (0 bytes).
Create a Cubit class named `SignupCubit` with a corresponding `SignupState`.
States: `SignupInitial`, `SignupLoading`, `SignupSuccess`, `SignupError(String message)`.
The Cubit must have a `signup(String name, String email, String password)` method that calls `AuthRepo.signup()`.

### Task 1.4 — History Cubit

The folder `lib/features/history/model_view/` is completely empty.
Create two files:

**history_state.dart** — define these states:
- `HistoryInitial`
- `HistoryLoading`
- `HistoryLoaded(List<HistoryModel> items)`
- `HistoryError(String message)`

**history_cubit.dart** — create `HistoryCubit` that extends `Cubit<HistoryState>`.
Add a `getHistory()` method that calls `HistoryRepo.getHistory()` and emits the appropriate state.

### Task 1.5 — Home Repository

Open `lib/features/home/repo/home_repo.dart`. It currently has stub methods with no real implementation.
Implement all methods so each one calls `DioClient` with the correct endpoint and returns a parsed model.

### Task 1.6 — Enable Assets in pubspec.yaml

Open `pubspec.yaml`.
Find the `assets:` section — it is currently commented out with `#`.
Uncomment it and add entries for every subdirectory found inside the `assets/` folder (images, icons, animations, etc.).
After editing, run `flutter pub get`.

---

## Phase 2 — Profile Layer + Reminder with Local Notifications

### Task 2.1 — Profile Model

Create `lib/features/profile/data/profile_model.dart`.
Define a `ProfileModel` class with fields: `id`, `name`, `email`, `phone`, `avatarUrl`, `dateOfBirth`.
Add `fromJson` and `toJson`.

### Task 2.2 — Profile Repository

Create `lib/features/profile/repo/profile_repo.dart`.
Implement three methods:
- `Future<ProfileModel> getProfile()`
- `Future<void> updateProfile(ProfileModel profile)`
- `Future<String> uploadAvatar(File imageFile)` — uploads the file and returns the new URL

Each method must use `DioClient` and handle errors by throwing a typed exception.

### Task 2.3 — Profile Cubit

Create `lib/features/profile/model_view/profile_state.dart` with states:
`ProfileInitial`, `ProfileLoading`, `ProfileLoaded(ProfileModel profile)`, `ProfileError(String message)`, `ProfileUpdating`, `ProfileUpdated`.

Create `lib/features/profile/model_view/profile_cubit.dart`.
The Cubit depends on `ProfileRepo` via its constructor.
Add methods: `loadProfile()`, `updateProfile(ProfileModel profile)`, `uploadAvatar(File image)`.

Connect the Cubit to `edit_profile_view.dart` and `personal_info_view.dart` using `BlocProvider` and `BlocBuilder`.

### Task 2.4 — Notification Service

Create `lib/core/services/notification_service.dart`.
Add `flutter_local_notifications` to `pubspec.yaml`.

The service must have:
- `Future<void> init()` — initializes the plugin for Android and iOS, requests permissions
- `Future<void> scheduleNotification(int id, String title, String body, DateTime scheduledDate)` — schedules a local notification at the given time
- `Future<void> cancelNotification(int id)` — cancels a scheduled notification

For Android: add `<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>` and `<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>` in `AndroidManifest.xml`.
For iOS: add `NSUserNotificationsUsageDescription` in `Info.plist`.

Call `NotificationService.init()` in `main.dart` before `runApp()`.

### Task 2.5 — Reminder Repository

Create `lib/features/reminder/repo/reminder_repo.dart`.
It must:
- Save and load reminders from `SharedPreferences` as a JSON list
- When a reminder is saved, call `NotificationService.scheduleNotification()` with the reminder's id, title, body, and scheduled time
- When a reminder is deleted, call `NotificationService.cancelNotification()` with its id

Update `ReminderCubit` to depend on `ReminderRepo` and call its methods instead of writing directly to storage.

---

## Phase 3 — Unify Network Layer

> Run this phase in a separate session after Phase 1 and Phase 2 are complete and tested.

### Task 3.1 — Audit Network Files

The project currently has three network files: `api_service.dart`, `dio_helper.dart`, and `dio_client.dart`.
Do the following:
1. Read all three files and list which repos and features depend on each one.
2. Keep only `dio_client.dart` as the single source of truth.
3. Migrate any logic from `api_service.dart` and `dio_helper.dart` into `dio_client.dart` if it is not already there.
4. Delete `api_service.dart` and `dio_helper.dart`.
5. Update all imports across the project to point to `dio_client.dart`.

### Task 3.2 — Base URL and Config

In `dio_client.dart`, ensure there is a single `baseUrl` constant at the top of the file.
Move it to `lib/core/constants/api_constants.dart` as `static const String baseUrl = 'YOUR_BASE_URL';` and import it from there.

### Task 3.3 — Auth Interceptor

In `dio_client.dart`, add a Dio `InterceptorsWrapper` with the following logic:

**onRequest:** Read the JWT token from `SharedPreferences`. If it exists, add it to the request headers as `Authorization: Bearer <token>`.

**onError:** If the response status code is 401, clear the stored token from `SharedPreferences` and use the app's navigation key to push the user to the signin screen.

### Task 3.4 — Unified Error Handling

Create `lib/core/errors/app_exception.dart` with a class `AppException` that has a `message` field and a `statusCode` field.
In `dio_client.dart`, wrap all `DioError` catches to throw `AppException` instead of raw Dio errors.
Update all repos to catch `AppException`.

---

## Phase 4 — Chat Architecture + Image Picker for Diagnosis

### Task 4.1 — Chat Model

Create `lib/features/chat/data/chat_model.dart`.
Define two classes:

`ChatModel` with fields: `doctorId`, `doctorName`, `doctorImage`, `lastMessage`, `lastMessageTime`, `unreadCount`.

`MessageModel` with fields: `id`, `senderId`, `content`, `timestamp`, `isRead`.

Add `fromJson` and `toJson` for both.

### Task 4.2 — Chat Repository

Create `lib/features/chat/repo/chat_repo.dart` with:
- `Future<List<ChatModel>> getChatList()` — returns all doctor conversations for the current user
- `Future<List<MessageModel>> getMessages(String doctorId)` — returns message history
- `Future<void> sendMessage(String doctorId, String content)` — sends a new message

### Task 4.3 — Chat Cubit

Create `lib/features/chat/model_view/chat_state.dart` with states:
`ChatInitial`, `ChatLoading`, `ChatListLoaded(List<ChatModel> chats)`, `ChatMessagesLoaded(List<MessageModel> messages)`, `ChatError(String message)`, `MessageSending`, `MessageSent`.

Create `lib/features/chat/model_view/chat_cubit.dart` with methods:
`loadChatList()`, `loadMessages(String doctorId)`, `sendMessage(String doctorId, String content)`.

### Task 4.4 — Refactor Chat Views

Currently there are three separate views: `doctor_ahmed_view.dart`, `doctor_khaled_view.dart`, `doctor_sara_view.dart` — all hardcoded.

Do the following:
1. Create a single generic view `lib/features/chat/view/chat_detail_view.dart` that accepts a `ChatModel` as a parameter and renders the conversation dynamically.
2. Delete the three hardcoded views.
3. Update any navigation calls that pushed those views to push `ChatDetailView` with the appropriate `ChatModel`.

### Task 4.5 — Image Picker for Diagnosis View

Add `image_picker: ^1.0.4` to `pubspec.yaml`.

In the diagnosis view file, add an image selection button that:
1. Calls `ImagePicker().pickImage(source: ImageSource.gallery)` when tapped
2. Stores the returned `XFile?` in the view's local state (use `setState` or the existing Cubit)
3. Shows a preview of the selected image below the button
4. If no image is selected, shows a placeholder with an upload icon

Add the required platform permissions:
- Android (`AndroidManifest.xml`): `<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>`
- iOS (`Info.plist`): `NSPhotoLibraryUsageDescription` with value `"This app needs access to your photo library to attach images to your diagnosis."`

---

## Phase 5 — Navigation + Dependency Injection

### Task 5.1 — go_router Setup

Add `go_router: ^13.0.0` to `pubspec.yaml`.

Create `lib/core/router/app_router.dart`.
Define a `GoRouter` instance with named routes for every screen:
`/splash`, `/onboarding`, `/signin`, `/signup`, `/layout`, `/home`, `/history`, `/chat`, `/chat/:doctorId`, `/profile`, `/edit-profile`, `/reminder`, `/diagnosis`.

Add a `redirect` callback that:
- Reads the token from `SharedPreferences`
- If the token is empty or null and the route is not `/signin` or `/signup` or `/onboarding`, redirect to `/signin`

Pass the router to `MaterialApp.router` in `main.dart`.

Replace all `Navigator.push` and `Navigator.pushNamed` calls throughout the project with `context.go()` or `context.push()`.

### Task 5.2 — Dependency Injection with get_it

Add `get_it: ^7.6.0` to `pubspec.yaml`.

Create `lib/core/di/service_locator.dart`.
Define a top-level `GetIt sl = GetIt.instance;` and a `Future<void> setupLocator()` function.

Inside `setupLocator()`, register:
- `DioClient` as a singleton
- `NotificationService` as a singleton
- `AuthRepo`, `HomeRepo`, `HistoryRepo`, `ChatRepo`, `ProfileRepo`, `ReminderRepo` each as a lazy singleton depending on `sl<DioClient>()`
- All Cubits as factories depending on their respective repos

Call `await setupLocator()` in `main.dart` before `runApp()`.

Replace every manual `Cubit(repo: Repo())` instantiation in the project with `sl<CubitName>()`.