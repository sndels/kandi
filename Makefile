.PHONY: all
TARGETS=kandi
AUXPATH=aux
OUTPATH=out
LATEXFLAGS=-halt-on-error -output-directory=$(OUTPATH) -aux-directory=$(AUXPATH)
all: $(TARGETS:=.pdf)

kandi.pdf: kandi.tex kandi.bib

$(AUXPATH):
	mkdir $(AUXPATH)

$(OUTPATH):
	mkdir $(OUTPATH)

%.pdf: %.tex $(AUXPATH) $(OUTPATH)
	pdflatex $(LATEXFLAGS) $<
	(cd $(OUTPATH); BIBINPUTS="../" bibtex $*.aux)
	pdflatex $(LATEXFLAGS) $<
	pdflatex $(LATEXFLAGS) $<

.PHONY: clean
clean:
	rm -f out/* aux/*
