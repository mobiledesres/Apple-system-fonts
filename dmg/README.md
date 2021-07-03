# .url files
The .url files provide links to download the .dmg archives containing the font files.

Each .url file should contain **exactly one line** that specifies one URL to download.

Example: **SF-Pro.url**
```
https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg
```

# Extracting .dmg files
* To get all fonts (automatically update the .dmg files to the newest version):
    ```shell
    make
    
    ```
* To clean up:
    ```shell
    make clean
    ```
