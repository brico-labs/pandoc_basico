source  := src
output  := out
sources := $(wildcard $(source)/*.md)
lang    := es-ES
target  := documento

# pdf control, other fonts could be:
# 'Liberation Sans',  'Liberation Mono'
# 'Arial'
mainfont := 'Source Sans Pro'
monofont := 'Source Code Pro'

pdf_opt := --smart --standalone --variable geometry:a4paper --variable lang=$(lang) \
           --number-sections --toc --from=markdown --to latex --latex-engine=xelatex \
           --variable mainfont=$(mainfont) \
           --variable monofont=$(monofont) \
           --variable fontsize='12pt' \

## Recipes for targets

# These targets are not files
.PHONY: clean pdf latex mediawiki epub github

# all -- This target try to build every thing
all: pdf latex mediawiki epub github

# reset -- This target deletes every target and then tries to build everithing
reset: clean all

# pdf  -- buid pdf output
pdf: $(output)/$(target).pdf $(sources)

$(output)/$(target).pdf: $(sources)
	pandoc $(pdf_opt) \
	--output=$(output)/$(target).pdf \
	$(sources)

# latex
latex: $(output)/$(target).tex $(sources)

$(output)/$(target).tex: $(sources)
	pandoc $(pdf_opt) \
	--output=$(output)/$(target).tex \
	$(sources)

# mediawiki
mediawiki: $(output)/$(target).mw $(sources)
$(output)/$(target).mw: $(sources)
	pandoc --from markdown --to mediawiki \
	--output=$(output)/$(target).mw \
	$(sources)

#epub
epub: $(output)/$(target).epub $(sources)
$(output)/$(target).epub: $(sources)
	pandoc --from markdown --to epub \
	--output=$(output)/$(target).epub \
	$(sources)

#odt
odt: $(output)/$(target).odt $(sources)
$(output)/$(target).odt: $(sources)
	pandoc --from markdown --to odt \
	--output=$(output)/$(target).odt \
	$(sources)

# github
github: README.md $(sources)
README.md: $(sources)
	pandoc --from markdown --to markdown_github \
	--output=README.md \
	$(sources)

clean:
	rm -f $(output)/*.pdf
	rm -f $(output)/*.tex
	rm -f $(output)/*.mw
