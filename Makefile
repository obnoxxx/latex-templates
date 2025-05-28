#
# This is a generic Makefile for building LaTeX docs.
# You can copy it to you project directory and
# only have to change the variable CASE to the basename of youe main latex file
# (i. e. the filename without the .tex suffix.
# You can then render you document by typing 'make pdf'.
#

SHELL=/bin/sh

.SUFFIXES: .tex .pdf

BASE=beispiel
SOURCE=$(BASE).tex
TARGET=$(BASE).pdf

FILES_WC=$(wildcard $(BASE).*)
FILES_LS=$(shell ls $(BASE).*)
FILES=$(FILES_LS)

GENERATED_S=$(subst $(SOURCE), ,$(FILES))
GENERATED_FO=$(filter-out $(SOURCE),$(FILES))
GENERATED=$(GENERATED_S)

.PHONY: info

info:
	@echo       source: $(SOURCE)
	@echo       target: $(TARGET)
	@echo all files wc: $(FILES_WC)
	@echo all files ls: $(FILES_LS)
	@echo    all files: $(FILES)
	@echo  gen-files-s:  $(GENERATED_S)
	@echo gen-files-fo: $(GENERATED_FO)
	@echo    gen-files: $(GENERATED)



.tex.pdf:
	@pdflatex $<
	@pdflatex $<
	@makeindex $<
	@pdflatex $<

.PHONY: $(BASE)
	
$BASE): pdf
.PHONY: pdf
pdf: clean $(TARGET)

show:  $(BASE)
	@$(VIEWER) $(TARGET)

.PHONY: clean
clean:
	rm -f $(GENERATED)

