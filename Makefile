DOCUMENT = postgres-on-the-wire

EXTRA_CLEAN = $(wildcard *.toc *.aux *.pdf *.log \
	*.out *.nav *.snm *.vrb *.bbl *.blg *.eps)

DIAGRAM_DOTS = $(wildcard *.dot)
DIAGRAM_PDFS = $(patsubst %.dot,%.pdf,$(DIAGRAM_DOTS))

FLOWCHART_MSC = $(wildcard *.msc)
FLOWCHART_PDFS = $(patsubst %.msc,%.pdf,$(FLOWCHART_MSC))

.SECONDARY: $(DIAGRAM_PDFS) $(FLOWCHART_PDFS)

all: $(DOCUMENT).pdf

clean:
	rm -f $(EXTRA_CLEAN)

full_%.pdf: %.dot
	dot -Tpdf -o $@ $<

full_%.eps: %.msc
	mscgen -Teps -o $@ $<

%.pdf: %.eps
	epstopdf -o $@ $<

%.pdf: full_%.pdf
	pdfcrop $< $@

%.pdf: %.tex $(DIAGRAM_PDFS) $(FLOWCHART_PDFS)
	pdflatex $<
	pdflatex $<
