.phony: build

build:
	pandoc README.md -f markdown -t latex -s -o constitution.pdf
