DOCUMENT = postgres-on-the-wire

EXTRA_CLEAN = $(wildcard *.toc *.aux *.pdf *.log \
	*.out *.nav *.snm *.vrb *.bbl *.blg)

all: $(DOCUMENT).pdf

clean:
	rm -f $(EXTRA_CLEAN)

%.pdf: %.tex
	pdflatex $<
	pdflatex $<
