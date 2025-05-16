const CACHE_VERSION = 'v1.0.0';
const CACHE_NAME = `radio-cache-${CACHE_VERSION}`;
const OFFLINE_URL = '/offline.html';

const URLS_TO_CACHE = [
  '/',
  '/index.html',
  '/manifest.json',
  '/icon-192.png',
  '/icon-512.png',
  '/intro.mp3',  
  OFFLINE_URL
];

self.addEventListener('install', event => {
  self.skipWaiting(); // Forçar ativação imediata
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => {
      return cache.addAll(URLS_TO_CACHE);
    })
  );
});

self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(
        keys.map(key => {
          if (key !== CACHE_NAME) {
            return caches.delete(key);
          }
        })
      )
    )
  );
});

self.addEventListener('fetch', event => {
  const url = new URL(event.request.url);
  // Se for um recurso do próprio site
  if (url.origin === location.origin) {
    event.respondWith(
      caches.match(event.request).then(cached => {
        return cached || fetch(event.request).catch(() => caches.match(OFFLINE_URL));
      })
    );
  }
});
