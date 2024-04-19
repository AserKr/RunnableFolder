## to run using this makefile use: make TEST_FILE=general.nm
## to clean using this makefile use: make clean


JAVA = java

MORPHO = java -jar morpho.jar

TEST_FILE ?= test.nm

BASENAME = $(basename $(TEST_FILE))

MASM_FILE = $(BASENAME).masm
MEXE_FILE = $(BASENAME).mexe

all: run

$(MASM_FILE): $(TEST_FILE)
	$(JAVA) NanoMorphoParser $(TEST_FILE) > $(MASM_FILE)

$(MEXE_FILE): $(MASM_FILE)
	$(MORPHO) -c $(MASM_FILE)

run: $(MEXE_FILE)
	$(MORPHO) $(BASENAME)


clean:
	rm -Rf *.masm *.mexe



