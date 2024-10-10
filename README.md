# GeekHouse

# Open Source Flutter App

This is an open-source Flutter app that integrates with Supabase for authentication and Cloudinary for image uploads.

## Features

- User authentication with Supabase.
- Cloudinary integration for profile image uploads.
- Environment variable-based configuration.

## Prerequisites

Before running the app, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- A [Supabase](https://supabase.com) account for authentication.
- A [Cloudinary](https://cloudinary.com) account for image uploads.

## Getting Started

## Step 1: Clone the Repository

git clone https://github.com/Codesait/geekHouse
cd your-repository


## Step 2: Set Up Environment Variables

Create a .env file at the root of your project:
- auth_secrets.env

Add your credentials to the .env file as follows:
### Supabase credentials
AUTH_URL=your_supabase_url
ANON_KEY=your_supabase_anon_key

### Cloudinary credentials
- CLOUD_NAME=your_cloudinary_cloud_name
- CLOUDINARY_API_KEY=your_cloudinary_api_key
- CLOUDINARY_API_SECRET=your_cloudinary_api_secret
- CLOUDINARY_PRESET=your_cloudinary_upload_preset


## Step 3: Install Dependencies
flutter pub get

## Step 4: Run the App
flutter run


### Usage
After launching the app, you can:

- Authenticate with Supabase.
- Upload profile images to Cloudinary.

### License
This project is licensed under the MIT License - see the LICENSE file for details.



