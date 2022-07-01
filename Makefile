BUILDDIR = build

OPTIONS  = -d build/html -t

OPTIONS += $(foreach theme,$(THEMES),-T $(theme))
OPTIONS += $(HTML_OPTS)

.PHONY: usage clean harrierattack
usage:
	@echo "Targets:"
	@echo "  usage          show this help"
	@echo "  harrierattack  build the Harrier Attack disassembly"
	@echo ""
	@echo "Variables:"
	@echo "  THEMES         CSS theme(s) to use"
	@echo "  HTML_OPTS      options passed to skool2html.py"

.PHONY: clean
clean:
	-rm -rf $(BUILDDIR)/*

.PHONY: harrierattack
harrierattack:
	if [ ! -f HarrierAttack.z80 ]; then tap2sna.py @harrierattack.t2s; fi
	sna2skool.py -H -c sources/harrierattack.ctl HarrierAttack.z80 > sources/harrierattack.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=harrierattack/dec -c Config/InitModule=sources:bases sources/harrierattack.skool sources/harrierattack.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=harrierattack/hex -c Config/InitModule=sources:bases sources/harrierattack.skool sources/harrierattack.ref

all : harrierattack
.PHONY : all
