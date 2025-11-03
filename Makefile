DIR := chapters
OUT := fontpub_whitepaper.md
FILES := \
	$(DIR)/00_abstract.md \
	$(DIR)/01_introduction.md \
	$(DIR)/02_philosophy.md \
	$(DIR)/03_system-overview.md \
	$(DIR)/04_cryptographic-model.md \
	$(DIR)/05_distribution-mechanism.md \
	$(DIR)/06_comparison-to-existing-systems.md \
	$(DIR)/07_limitations-and-future-work.md \
	$(DIR)/08_conclusion.md

.PHONY: all

all: $(OUT)

$(OUT): $(FILES)
	@echo "Building $@ from chapter files..."
	@cat $(FILES) > $@
	@echo "Done -> $@"
