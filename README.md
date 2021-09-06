# Apple system fonts
This repository provides fonts for the Apple system. The fonts are extracted fron the .dmg files, which can be obtained at https://developer.apple.com/fonts/.

The available fonts are:
* SF Pro
* SF Compact
* SF Mono
* SF Arabic (beta)
* New York

![](fonts-hero-large_2x.png)

## Prerequisites
These packages must be installed:
* `dmg2img`
* `p7zip-full`

## Extract fonts
* Extract all fonts:
    ```shell
    make -j
    ```
* Extract and pack all fonts into `fonts.zip`:
    ```shell
    make -j zip
    ```

## Clean up
* Clean up generated fonts (also removes the `fonts.zip` file):
    ```shell
    make clean
    ```
* Clean up the generated `fonts.zip` file:
    ```shell
    make rmzip
    ```

## Update .dmg files
When Apple releases new versions of the system font files, you can run
```shell
make update
```
to update all .dmg files in the repository.

# See also
* [SF Symbols](https://github.com/mobiledesres/SF-Symbols)