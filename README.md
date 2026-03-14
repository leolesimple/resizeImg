# resizeImg

A macOS utility to batch resize and convert images to WebP using native Finder dialogs.

## About

`resizeImg` lets you select one or more images through a native macOS file picker, choose a target width and a compression mode (lossless or lossy at 75% quality), and exports everything as `.webp` into a `resize-output/` directory next to the source files.

## Prerequisites

- macOS
- [Homebrew](https://brew.sh)
- `webp` package (provides `cwebp` and `dwebp`):

```bash
brew install webp
```

## Installation

Clone the repository:

```bash
git clone https://github.com/TON_USER/resizeImg.git
```

Copy the script to a directory in your `PATH`:

```bash
mkdir -p ~/.local/bin
cp resizeImg/resizeImg.sh ~/.local/bin/resizeImg
chmod +x ~/.local/bin/resizeImg
```

If `~/.local/bin` is not in your `PATH`, add it:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Usage

```bash
resizeImg
```

1. A Finder dialog opens to select one or more images
2. Enter the target width in pixels
3. Choose the compression mode: **Lossless** or **Lossy (75%)**
4. Converted `.webp` files are saved in a `resize-output/` folder next to the originals

The output folder opens automatically in Finder when processing is complete.

## Supported formats

| Direction | Formats |
|-----------|---------|
| Input | Any format supported by macOS (PNG, JPEG, TIFF, HEIC, WebP…) |
| Output | WebP |

## License

This project is distributed under a custom **No Derivatives** license. You are free to use the software as-is, but modification and redistribution of modified versions are not permitted. See [LICENSE](LICENSE) for details.
