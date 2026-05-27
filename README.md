# Antarac — Native Android Wrapper for YAY Web Panel

**Antarac** adalah aplikasi Android native ringan yang membungkus **YAY Web Panel** (`wibots.vercel.app`) menjadi aplikasi mobile yang terasa seperti aplikasi native sungguhan — bukan sekadar shortcut browser.

Nama **Antarac** berasal dari **"Antara"** (penghubung/jembatan) dan ekstensi **"-ac"** sebagai identitas produk netals. Sesuai fungsinya: menjadi **jembatan** antara pengguna mobile dan sistem manajemen bot WhatsApp **YAY by netals**.

---

## Apa Itu Antarac?

Antarac adalah **Android WebView App** yang dirancang khusus untuk mengakses YAY Panel dari perangkat Android dengan pengalaman yang mulus dan imersif:

- Tampilan **fullscreen total** — tidak ada notifikasi bar, navigation bar, maupun browser UI yang mengganggu
- **Instant Update** — setiap perubahan pada web panel langsung tersinkron tanpa perlu update APK
- **Ringan** — ukuran APK sangat kecil karena konten dimuat dari server web
- **Terasa Native** — pengalaman pengguna menyerupai aplikasi Android asli

---

## Fitur

| Fitur | Keterangan |
|---|---|
| Full Immersive Fullscreen | Sembunyikan status bar, notifikasi bar, dan tombol navigasi |
| Disable Pull-to-Refresh | Mencegah tarikan ke bawah yang merusak navigasi desktop virtual |
| Disable Text Selection | Melarang seleksi teks panjang di dalam WebView |
| Instant Update | Update otomatis mengikuti web panel tanpa rilis APK baru |
| Custom App Icon | Ikon kustom asterisk gradasi transparan khas netals |

---

## Cara Build APK

### Opsi A — Android Studio (Direkomendasikan)

1. Unduh & install [Android Studio](https://developer.android.com/studio)
2. Pilih **Open an Existing Project** → arahkan ke folder `Antrac-Android-Project`
3. Tunggu proses **Gradle Sync** selesai
4. Klik **Build → Build Bundle(s) / APK(s) → Build APK(s)**
5. APK tersedia di: `app/build/outputs/apk/debug/app-debug.apk`

### Opsi B — Cloud Compiler (Tanpa Install, 60 Detik)

1. Kunjungi [WebIntoApp](https://www.webintoapp.com/)
2. Masukkan URL: `https://wibots.vercel.app/`
3. App Name: `Antarac`
4. Icon: gunakan `app/src/main/res/drawable/app_icon.png`
5. Aktifkan **Fullscreen / Immersive Mode** di Advanced Settings
6. Download APK langsung!

---

## Download APK (Beta)

File APK beta tersedia di: [`Antrac-beta-v0.1.apk`](./Antrac-beta-v0.1.apk)

> Beta v0.1 — Hanya untuk pengujian internal. Belum dirilis ke publik.

---

## Teknologi

- **Bahasa**: Java (Android Native)
- **Min SDK**: Android 5.0 (API 21)
- **Target SDK**: Android 14 (API 34)
- **Engine**: Android WebView

---

## Lisensi

Proyek ini dilisensikan di bawah [MIT License](./LICENSE).

Copyright (c) 2026 **netals**

---

## Dibuat oleh

**netals** — Tim pengembang YAY by netals
> Menghubungkan bisnis dengan teknologi WhatsApp automation yang cerdas.
