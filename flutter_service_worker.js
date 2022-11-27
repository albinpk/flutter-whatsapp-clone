'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "e58405192d2885f6855a7a11c3ef35ff",
"/": "e58405192d2885f6855a7a11c3ef35ff",
"assets/assets/images/whatsapp-splash-image-dark.svg": "e8c201cce865315829622b07e285f698",
"assets/assets/images/whatsapp-splash-image-dark.png": "e6fc2ef2b1121dfa084c98522b61cbfc",
"assets/assets/images/default-user-avatar-light.png": "7ca753ea2cd338e1e4826f8e878474e5",
"assets/assets/images/whatsapp-splash-image-light.png": "9e8159812acd5b8eea8ab64f9dc3fb1c",
"assets/assets/images/default-user-avatar-dark.png": "5326cd42e239a6547ae95d9889e10f96",
"assets/assets/images/chat_room_background_image_light.jpg": "f9755b990b184a021c61dbcc34844ee8",
"assets/assets/images/chat_room_background_image_dark.png": "97c00759d90d786d9b6096d274ad3e07",
"assets/assets/images/whatsapp-splash-image-light.svg": "75b17ebcd4c9c55b640d66e9ee35ae69",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/NOTICES": "e979082bf286abf1d32d1ccec548ccbb",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/AssetManifest.json": "07d33eda52037811b8521bfb0a06f857",
"assets/shaders/ink_sparkle.frag": "6ddca61f03944b33ce9eb6974f399db8",
"version.json": "7929220c96d0da04c6cbcbae0bdba9cb",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"splash/splash.js": "123c400b58bea74c1305ca3ac966748d",
"splash/img/light-3x.png": "d97ef4bf3d6bfdcfb4958984551e7409",
"splash/img/dark-4x.png": "d748980188dba3bce8499d8115ed3638",
"splash/img/light-4x.png": "e48ff38d8cb68ab129e6736c7b7d9a3e",
"splash/img/dark-2x.png": "80e3283a127554dc1ac53e6fb0f40143",
"splash/img/light-1x.png": "90b78bd49869514dd76f87fabbcf7b0d",
"splash/img/light-2x.png": "f9aeeb3608f6f7886060bf2798acb425",
"splash/img/dark-3x.png": "409d257ebad5ee63d7489b093eb6d0be",
"splash/img/dark-1x.png": "9b4852857e34291c50663a35c14507bc",
"splash/style.css": "565104fffde8459b78b975a2d93cf52d",
"icons/Icon-512.png": "5a7e51b80663bfeba3f53f8022a7d155",
"icons/Icon-maskable-192.png": "c2d94b775cbe316c5e9275238b2b3a0b",
"icons/Icon-maskable-512.png": "5a7e51b80663bfeba3f53f8022a7d155",
"icons/Icon-192.png": "c2d94b775cbe316c5e9275238b2b3a0b",
"favicon.png": "a2586fbf920df613a880632cd6e78d99",
"main.dart.js": "c120d6dd1b664e9a52457e80426af3bb",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"manifest.json": "58eae18d739137ada745168473cc5690"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
