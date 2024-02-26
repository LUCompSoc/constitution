import shutil
from pathlib import Path

import typst


__dir__ = Path(__file__).parent

FONTS_DIR = __dir__ / "fonts"
BUILD_DIR = __dir__ / "build"


def main():
    if BUILD_DIR.exists():
        shutil.rmtree(BUILD_DIR)
    for doc in __dir__.glob("**/*.typ"):
        if doc.stem.startswith('_'):
            continue
        path = doc.relative_to(__dir__)
        print(f"building `{path}`")
        out_path = (BUILD_DIR / path).with_suffix(".pdf")
        out_path.parent.mkdir(exist_ok=True, parents=True)
        typst.compile(doc, output=out_path, root=__dir__, font_paths=[FONTS_DIR])


if __name__ == "__main__":
    exit(main())
