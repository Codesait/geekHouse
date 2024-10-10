# GeekHouse

Open Source Flutter App
This is an open-source Flutter app that integrates with Supabase for authentication and Cloudinary for image uploads.

Features
User authentication with Supabase.
Cloudinary integration for profile image uploads.
Environment variable-based configuration.

Prerequisites
Before running the app, ensure you have the following installed:

Flutter SDK
A Supabase account for authentication.
A Cloudinary account for image uploads.

Getting Started
Step 1: Clone the Repository
bash
Copy code
git clone https://github.com/your-username/your-repository.git
cd your-repository
Step 2: Set Up Environment Variables
This app uses environment variables for secure credentials. To run the app, create an .env file and add your Supabase and Cloudinary credentials.

Create a .env file at the root of your project:
Copy code
auth_secrets.env
Add your credentials to the .env file as follows:
bash
Copy code

# Supabase credentials
AUTH_URL=your_supabase_url
ANON_KEY=your_supabase_anon_key

# Cloudinary credentials
CLOUD_NAME=your_cloudinary_cloud_name
CLOUDINARY_API_KEY=your_cloudinary_api_key
CLOUDINARY_API_SECRET=your_cloudinary_api_secret
CLOUDINARY_PRESET=your_cloudinary_upload_preset
Step 3: Install Dependencies
Run the following command to install the required dependencies:

bash
Copy code
flutter pub get
Step 4: Run the App
You can now run the app on an emulator or a physical device:

bash
Copy code
flutter run
Usage
After launching the app, you can:

Authenticate with Supabase.
Upload profile images to Cloudinary.

License
This project is licensed under the MIT License - see the LICENSE file for details.
