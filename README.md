# Viber-AppImage-Enhanced 🐧

[![GitHub Downloads](https://img.shields.io/github/downloads/pkgforge-dev/Viber-AppImage-Enhanced/total?logo=github&label=GitHub%20Downloads)](https://github.com/pkgforge-dev/Viber-AppImage-Enhanced/releases/latest)
[![CI Build Status](https://github.com//pkgforge-dev/Viber-AppImage-Enhanced/actions/workflows/appimage.yml/badge.svg)](https://github.com/pkgforge-dev/Viber-AppImage-Enhanced/releases/latest)

<p align="center">
  <img src="https://github.com/user-attachments/assets/29a55811-3898-4818-aaef-96d12cb35e46" width="128" />
</p>

* [Latest Stable Release](https://github.com/pkgforge-dev/Viber-AppImage-Enhanced/releases/latest)

---

Unofficial AppImage of Viber, which works on any Linux distribution and is more reliable than the official Viber AppImage, hence the `-Enhanced` suffix.  

## Official Viber AppImage issues
- It depends on the EOL `libfuse2` library, which had the last release in 2019.
  - Linux distributions like Ubuntu and others don't ship `libfuse2`, so Viber AppImage doesn't work by default
- It doesn't bundle every library that is necessary for the app function
- Due to the above, video camera function is inconsistent, requiring older `libtheora` v1.x to be installed on the host, which some distros don't have

## How this AppImage solves the above issues
- It doesn't depend on `libfuse` at all, as it can utilize kernel's unprivileged user namespaces function or as a fallback simply extract directory to `/tmp/` and run
  - Thanks to the [`uruntime`](https://github.com/VHSgunzo/uruntime)
- It ships all the needed libs, binaries and directories reliably and relatively easy, thanks to the robust stracing system called [`sharun`](https://github.com/VHSgunzo/sharun) and it's wrapper [`quick-sharun`](https://github.com/pkgforge-dev/Anylinux-AppImages/blob/main/useful-tools/quick-sharun.sh)
  - If it ever happens that some dependencies are missing, it's clear to troubleshoot with `APPIMAGE_DEBUG=1` variable
- GPU acceleration, video camera function, calls, notifications, everything is tested to work accordingly compared to the upstream app capabilities

## Requirements
They are very minimal, but they are just listed here for transparency.

**AppImage's side:**  
- POSIX `/bin/sh` shell
- writable `/tmp/` directory

**Viber's side:**  
- Linux 3.8+ kernel
  - application uses QtWebEngine, which depends on unprivileged user namespaces, which were introduced in Linux 3.8 kernel (released in 2013)
- display server being active (X11 or Wayland)

Not mandatory, but recommended:
- `xdg-open` (part of `xdg-utils`)
  - So opening URLs or files redirects to the default system applications (clicking on URL opens the web browser, clicking on file opens the file manager etc.)

## Screenshot of Viber-AppImage-Enhanced working on Ubuntu 14.04 LTS VM
<details>
  <summary><b><i>Click to preview</i></b></summary>
    <img src="https://github.com/user-attachments/assets/36c85e64-8c1e-4e16-a273-40cb7623f5ea" alt="Inspiration Image">
  </a>
</details>

## Screenshot on why AppImage is preferred for low-storage devices
<details>
  <summary><b><i>Click to preview</i></b></summary>
    <img src="https://github.com/user-attachments/assets/29576c50-b39c-46c3-8c16-a54999438646" alt="Inspiration Image">
  </a>
</details>

---

More at: [AnyLinux-AppImages](https://pkgforge-dev.github.io/Anylinux-AppImages/)
