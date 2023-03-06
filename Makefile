
LATEX_OPTIONS := -file-line-error -halt-on-error

TEX_FILES := $(wildcard *.tex) $(wildcard **/*.tex)
PDF_FILES := $(patsubst %.tex,build/%.pdf,$(TEX_FILES))


build: $(PDF_FILES)
	@# pandoc README.md -f markdown -t latex -s -o constitution.pdf


build/%.pdf : %.tex
	@-mkdir -p "$(dir $@)"
	@pdflatex -output-directory "$(dir $@)" $(LATEX_OPTIONS) $^


clean_build_artefacts:
	@-rm -f build/*.aux build/**/*.aux
	@-rm -f build/*.log build/**/*.log
	@-rm -f build/*.out build/**/*.out
	@-rm -f build/*.toc build/**/*.toc

clean_pdfs:
	@-rm -f build/*.pdf build/**/*.pdf

clean: clean_build_artefacts clean_pdfs


.PHONY: build clean clean_pdfs clean_build_artefacts

