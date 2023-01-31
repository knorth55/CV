TARGET := main

OS := $(shell uname -s)
LATEXMK_OPTION := -time -recorder -rules
LATEXMK_EXEC := latexmk $(LATEXMK_OPTION)

.PHONY: all preview forever clean wipe

all:
	$(LATEXMK_EXEC) -pvc- $(TARGET)

pub:
	cp $(TARGET).pdf CV.pdf

preview:
	$(LATEXMK_EXEC) -pv $(TARGET)

forever:
	$(LATEXMK_EXEC) -pvc $(TARGET)

clean:
	$(LATEXMK_EXEC) -c

wipe: clean
	$(LATEXMK_EXEC) -C
	git clean -X -f -i -e '.tex' -e '.tex.orig'

compress:
	ghostscript -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -dPrinted=false -dAutoRotatePages=/None -sOutputFile=$(TARGET)_compressed.pdf $(TARGET).pdf
