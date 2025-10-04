# Makefile fuer das automatisierte Verarbeiten von Bildern. .jpg, .tga oder .ppm Dateien werden skaliert, in das PNG-
# Format umgewandelt und zusammen in ein TGZ-Archiv gepackt.
#
# Qualldateien werden nicht veraendert, Zieldateien nur erzeugt wenn sie nicht vorhanden sind oder ihre Quelldateien
# neuer als die Zieldateien sind. Konvertierungstools koennen nur eine Datei zur Zeit konvertieren.
#
# Mögliche Ausgaben von make, beispielsweise, dass eine Datei bereits aktuell ist oder keine zu konvertierenden
# Dateien vorhanden sind, muessen nicht beachtet werden. Ebenfalls kann davon ausgegangen werden, dass die Dateinamen
# keine Leerzeichen enthalten.
#
# Autor: co

# Variable fuer Bildskalierung
SIZE = 100

# Sammle alle Bilddateien
JPGS  = $(wildcard *.jpg)
TGAS  = $(wildcard *.tga)
PPMS = $(wildcard *.ppm)
ARCHIVE = archive.tgz
OBJS = $(JPGS:.jpg=.png) $(TGAS:.tga=.png) $(PPMS:.ppm=.png)

.PHONY: all archive png help clean
.SECONDARY:
# Default Target macht dasselbe wie archive
all: archive png

# alias fuer Archive
archive: $(ARCHIVE)
# Schalter: c - create (neues Archiv erstellen), z - komprimieren in gzip format, f - dateiname angeben
archive.tgz: $(OBJS)
	@tar -czf $(ARCHIVE) $^

png: $(OBJS)
# Konvertierungen
%.png: %.scaled
	@pnmtopng $< > $@
%.scaled: %.ppm
	@pnmscale -xysize $(SIZE) $(SIZE) $< > $@
%.ppm: %.jpg
	@jpegtopnm $< > $@
%.ppm: %.tga
	@tgatoppm $< > $@
# Hilfeanzeige
help:
	@echo "Makefile which scales and converts jpg, tga and ppm files to png and generates an archive"
	@echo ""
	@echo "VARIABLES"
	@echo "  SIZE     - specifies the largest image size (default=100)"
	@echo ""
	@echo "TARGETS"
	@echo "  all      - default target, does the same as tar target"
	@echo "  archive  - scale and convert all jpg, tga and ppm files to png and create an archive.tgz"
	@echo "  png      - scale and convert all jpg, tga and ppm files to png"
	@echo "  help     - display this help and exit"
	@echo "  clean    - remove all generated files"

# Aufraeumen
# f - force remove, -f - und keine Fehlermeldung wenn Dateien nicht existieren
clean:
	@rm -f $(OBJS) *.scaled $(ARCHIVE)
