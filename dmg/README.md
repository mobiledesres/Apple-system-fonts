# .url files
The .url files provide links to download the .dmg archives containing the font files.

Each .url file should contain **exactly one line** that specifies one URL to download.

* Example: **SF-Pro.url**
    ```
    https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg
    ```

# .dmg?? files
The .dmg?? files (.dmg00, .dmg01, …) are the split .dmg files. They are split so that they do not exceed GitHub file size limits.

You may use `cat` to combine the split .dmg files. For example, you can run
```shell
cat SF-Compact.dmg?? > SF-Compact.dmg
```
to produce the **SF-Compact.dmg** file.

Run
```shell
make split
```
to generate the split .dmg files from the original .dmg file. This uses the `split` program.

# Downloading .dmg files
* To get all .dmg files containing the fonts, you may run:
    ```shell
    make
    ```
    The program does two things for each .dmg file to generate:
    1. First it tries to combine the split .dmg files given in the repository using `cat`.
    2. After combining the split .dmg files to generate the complete .dmg files, the program contacts Apple server to see if the files have been updated on their side.
        * If updated, then the newer .dmg files will be downloaded using `wget`. Then it uses `split` to update the split .dmg files.
* To clean up, run:
    ```shell
    make clean
    ```
    Both the complete and split .dmg files will be removed.