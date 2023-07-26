# mobilicis

A new Flutter project.

## Getting Started

Use `flutter clean && flutter pub get` for a clean install of all the dependencies.

Then run the application using `flutter run` .

Make sure to create a .env file at the root of the project and add a FCM_SERVER_KEY variable in it with an empty string and comment callOnFcmApiSendPushNotifications in fcm_api.dart.

# Image Optimization

1. I used `debugInvertOversizedImages = true;` to get all the unoptimized images.
2. Afterwards I used cachedWidth and cacheHeight to optimize the banner images and the product images.
3. I used cached_network_image and flutter_cache_manager to cache and optimize the brand logos in the brand slider.
4. I didn't use the cache for storing the product images because some of them are as big as 5k and thus, will take too much space, leading to memory leaks. In my opinion, the best way to load would be first resizing each image to 256px and then cache a limited number of them (say 100) for about 24 hours.

# Memory Optimization

1. Created custom cache manager for storing only a certain number images for a certain period of time.
2. Used const, static and final suitably to optimize widget loading.
3. Disposed controller using void dispose() when no in use.
