# RideMitra V1 — Android starter

RideMitra is an original ride-booking app prototype built with Flutter.

## What works in this V1
- Passenger-style pickup and destination fields
- Demo fare display
- Demo ride-request button and in-session history
- Passenger, Driver, and Admin preview modes

## What is not connected yet
- Real login or account recovery
- Live GPS/map routing
- Real driver matching or notifications
- Secure admin authorization
- Payments, refunds, emergency response
- Production database

The fare is a fixed illustrative amount, not a real price quote. This prototype must not be used to arrange real rides.

## Build from an Android phone
The simplest phone-only workflow is GitHub + a cloud build service that supports Flutter. A browser-only editor may not support all Flutter/Android build steps.

1. Extract `RideMitra_V1.zip` on your phone.
2. Create a GitHub repository named `ridemitra`.
3. Upload `pubspec.yaml`, `README.md`, and the `lib` folder. Keep the folder structure exactly as shown.
4. Use a trusted cloud Flutter build environment to run:
   ```bash
   flutter pub get
   flutter analyze
   flutter build apk --release
   ```
5. Download the generated APK from the build output and install it only on your own test device.

## Next versions
- V2: Supabase authentication and database tables
- V3: driver onboarding and server-side ride matching
- V4: map/location integration and distance-based estimates
- V5: secure admin panel, safety workflow, and compliant payment integration

## Before a public launch in India
Check the applicable state transport rules, licensing/permit requirements, vehicle and driver eligibility, insurance, privacy, consumer protection, and passenger safety requirements. Never store admin credentials or service-role keys in the Android app.
