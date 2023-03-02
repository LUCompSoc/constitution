.PHONY: build clean

build:
	pdflatex constitution.tex
	pdflatex bye-laws/*.tex
	pdflatex constitution.tex
	pdflatex bye-laws/*.tex
	make clean_build_artefacts
	# pandoc README.md -f markdown -t latex -s -o constitution.pdf


clean_build_artefacts:
	@-rm -f *.aux **/*.aux
	@-rm -f *.log **/*.log
	@-rm -f *.out **/*.out
	@-rm -f *.toc **/*.toc

clean: clean_build_artefacts
	@-rm -f *.pdf **/*.pdf

