# Introduction

Welcome to the **Local-Music-Spectrogram-Gen**—a powerful Bash script designed to convert Local audio files into spectrogram images using FFmpeg. This tool is ideal for users on **Android Termux, Linux, and macOS** who want a simple and efficient way to check spectrograms or visualize sound.
## 🚀 Features- 🎼 **Supports multiple audio formats**: MP3, AAC, M4A, FLAC, WAV, OGG, OPUS.- 🗂️ **Process individual files or entire folders**.
- 🎨 **Generates high-quality spectrograms**.
- 🔧 **Customizable music directory** to fit your file structure.
- 📁 **Outputs spectrograms in a dedicated folder** within your music directory.

---

## 🛠️ Installation & Setup
### 1️⃣ Install Required Packages
Before running the script, ensure you have **FFmpeg** installed:
#### Termux (Android)
```bash
termux-setup-storage
pkg update && pkg upgrade
pkg install ffmpeg
```
#### Linux/macOS
```bash
sudo apt update && sudo apt install ffmpeg
```

### 2️⃣ Download the Script
Clone the GitHub repository and set up the script:
```bash
git clone https://github.com/NetBreak-ops/Local-Music-Spectrogram-Gen.git
cd Local-Music-Spectrogram-Gen
chmod +x spectrogram.sh
```

### 3️⃣ Configure Your Music Directory
By default, the script uses:
```bash
$HOME/storage/music
```

### For Termux users you need to follow path like:
```bash
$HOME/storage/music
```
if it's in music folder in internal storage. Or else:
```bash
$HOME/storage/shared/{your_folder}
```
#### To use a custom path, set the `MUSIC_DIR` environment variable:
```bash
export MUSIC_DIR="/your/custom/path"
./spectrogram.sh
```
Alternatively, you can **edit the script** directly to set a permanent path.

---

## ▶️ How to Use
### **One-by-One Mode** (Manual Selection)
```bash
./spectrogram.sh
```
- Navigate through folders and select files manually.

### **Bulk Mode** (Process Entire Folder)
```bash
./spectrogram.sh
```
- Automatically processes all audio files in a directory.

- ![image alt](https://github.com/NetBreak-ops/Local-Music-Spectrogram-Gen/blob/d819e8bb386407896b9173768ec30550fad33f99/img/1743625703969.jpg) 
 ![image alt](https://github.com/NetBreak-ops/Local-Music-Spectrogram-Gen/blob/d819e8bb386407896b9173768ec30550fad33f99/img/1743625692532.jpg)
 ![image alt](https://github.com/NetBreak-ops/Local-Music-Spectrogram-Gen/blob/d819e8bb386407896b9173768ec30550fad33f99/img/1743625659321.jpg)

### **Where are Spectrograms Saved?**
All spectrograms are stored inside a `Spectrograms` folder within the same directory as the processed audio files.
![image alt](https://github.com/NetBreak-ops/Local-Music-Spectrogram-Gen/blob/237cc4c1176bd357b3b2fa69c4a6c91075f1ea3d/img/V%C3%98J%2C%20TRVNSPORTER%20-%20Lya%20Funk%20(Slowed).png)

![image alt](https://github.com/NetBreak-ops/Local-Music-Spectrogram-Gen/blob/237cc4c1176bd357b3b2fa69c4a6c91075f1ea3d/img/Indila%20-%20Love%20Story.png)

---



## 🤝 Contributing
We welcome contributions! Feel free to fork the repository, submit pull requests, or report issues.

## 📜 License
This project is licensed under the **MIT License**. See the `LICENSE` file for details.

### 🔗 Connect with Us
Have suggestions or questions? Open an issue or start a discussion in the repository!

**Happy visualizing! 🎵📊**

