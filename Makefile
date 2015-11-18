# Makefile for Sphinx documentation
#

# You can set these variables from the command line.

# Saves half a second!
SPHINXOPTS    = -j4

SPHINXBUILD   = sphinx-build
PAPER         =
BUILDDIR      = _build

GH_PAGES_TARGET	= html

# User-friendly check for sphinx-build
ifeq ($(shell which $(SPHINXBUILD) >/dev/null 2>&1; echo $$?), 1)
$(error The '$(SPHINXBUILD)' command was not found. Make sure you have Sphinx installed, then set the SPHINXBUILD environment variable to point to the full path of the '$(SPHINXBUILD)' executable. Alternatively you can add the directory with the executable to your PATH. If you don't have Sphinx installed, grab it from http://sphinx-doc.org/)
endif

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .

RENDER = _build/commit-render

# This is called on every use. 
find-src-commit = $(shell cd $(RENDER)/src && git rev-parse master)
find-dest-tree = $(shell cd $(RENDER)/src && git rev-parse master)
verify-ghpages-exists-cmd = git show-ref --verify -q refs/heads/gh-pages

.PHONY: \
	changes clean default dirhtml epub fresh help html html-silent json linkcheck pickle preview pseudoxml publish reload-silent render render-ensure-changes render-setup render-update singlehtml text xml


default: html reload-silent
preview: html reload-silent

clean:
	rm -rf $(BUILDDIR)/*
	@$(verify-ghpages-exists-cmd) && (git branch -d gh-pages >/dev/null 2>/dev/null || (echo; echo "* Discarding some renders that we made."; echo; git branch -D gh-pages)); true

fresh: clean
	git pull



# We use the .git/config files as a tag to see if the directories
# have been set up correctly.

$(RENDER)/src/.git/config $(RENDER)/dest/.git/config: 
	# Check that gh-pages exists in the current directory, otherwise make it.
	$(verify-ghpages-exists-cmd) || git branch --track gh-pages remotes/origin/gh-pages

	rm -rf $(RENDER)

	# Will always be on branch 'master'
	git clone -b master . $(RENDER)/src
	git clone -b gh-pages . $(RENDER)/dest

# Checks for correct setup.

render-setup: $(RENDER)/src/.git/config $(RENDER)/dest/.git/config

render-update: render-setup
	cd $(RENDER)/src && git pull -q
	cd $(RENDER)/dest && git pull -q

	cd $(RENDER)/src  && rm -rf *
	cd $(RENDER)/src  && git reset --hard -q

render-ensure-changes:
	@cd $(RENDER)/dest && (if git merge -q --ff-only origin/master 2>/dev/null; \
	then \
		echo; \
		echo "* It seems like you made no changes at all, which is fine."; \
		echo; \
		false; \
	fi )

render: render-update render-ensure-changes

	@echo
	@echo "* I will now build commit ${find-src-commit}:"
	@echo
	@cd $(RENDER)/src  && git log -n 1 --format=short master | cat
	@echo

	cd $(RENDER)/src  && make html-silent

	cd $(RENDER)/dest && (git merge -q -s ours -m '(new version)' origin/master)

	cd $(RENDER)/dest && rm -rf *
	cd $(RENDER)/dest && git checkout CNAME .nojekyll
	cp -rt $(RENDER)/dest/ $(RENDER)/src/_build/html/*
	cd $(RENDER)/dest && git add -A
	@echo
	@echo "* These changes are newly included in the build:"
	@echo
	@cd $(RENDER)/dest && git diff --cached | diffstat
	@echo
	cd $(RENDER)/dest && git commit --amend -C HEAD -q
	@echo
	@echo "* These changes you made (if any) are not included in the latest build."
	@echo
	@git diff ${find-src-commit} | diffstat
	@git st -su
	@echo

	git fetch $(RENDER)/dest +gh-pages:gh-pages

reload-silent:
	@test ! -L reload-trigger || date > reload-trigger

publish:
	git push --all

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html       to make standalone HTML files"
	@echo "  dirhtml    to make HTML files named index.html in directories"
	@echo "  singlehtml to make a single large HTML file"
	@echo "  pickle     to make pickle files"
	@echo "  json       to make JSON files"
	@echo "  htmlhelp   to make HTML files and a HTML help project"
	@echo "  qthelp     to make HTML files and a qthelp project"
	@echo "  devhelp    to make HTML files and a Devhelp project"
	@echo "  epub       to make an epub"
	@echo "  latex      to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  latexpdf   to make LaTeX files and run them through pdflatex"
	@echo "  latexpdfja to make LaTeX files and run them through platex/dvipdfmx"
	@echo "  text       to make text files"
	@echo "  man        to make manual pages"
	@echo "  texinfo    to make Texinfo files"
	@echo "  info       to make Texinfo files and run them through makeinfo"
	@echo "  gettext    to make PO message catalogs"
	@echo "  changes    to make an overview of all changed/added/deprecated items"
	@echo "  xml        to make Docutils-native XML files"
	@echo "  pseudoxml  to make pseudoxml-XML files for display purposes"
	@echo "  linkcheck  to check all external links for integrity"
	@echo "  doctest    to run all doctests embedded in the documentation (if enabled)"

html:
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."

html-silent:
	$(SPHINXBUILD) -b html -q $(ALLSPHINXOPTS) $(BUILDDIR)/html

dirhtml:
	$(SPHINXBUILD) -b dirhtml $(ALLSPHINXOPTS) $(BUILDDIR)/dirhtml
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/dirhtml."

singlehtml:
	$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS) $(BUILDDIR)/singlehtml
	@echo
	@echo "Build finished. The HTML page is in $(BUILDDIR)/singlehtml."

pickle:
	$(SPHINXBUILD) -b pickle $(ALLSPHINXOPTS) $(BUILDDIR)/pickle
	@echo
	@echo "Build finished; now you can process the pickle files."

json:
	$(SPHINXBUILD) -b json $(ALLSPHINXOPTS) $(BUILDDIR)/json
	@echo
	@echo "Build finished; now you can process the JSON files."

epub:
	$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS) $(BUILDDIR)/epub
	@echo
	@echo "Build finished. The epub file is in $(BUILDDIR)/epub."

text:
	$(SPHINXBUILD) -b text $(ALLSPHINXOPTS) $(BUILDDIR)/text
	@echo
	@echo "Build finished. The text files are in $(BUILDDIR)/text."

changes:
	$(SPHINXBUILD) -b changes $(ALLSPHINXOPTS) $(BUILDDIR)/changes
	@echo
	@echo "The overview file is in $(BUILDDIR)/changes."

linkcheck:
	$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $(BUILDDIR)/linkcheck
	@echo
	@echo "Link check complete; look for any errors in the above output " \
	      "or in $(BUILDDIR)/linkcheck/output.txt."

xml:
	$(SPHINXBUILD) -b xml $(ALLSPHINXOPTS) $(BUILDDIR)/xml
	@echo
	@echo "Build finished. The XML files are in $(BUILDDIR)/xml."

pseudoxml:
	$(SPHINXBUILD) -b pseudoxml $(ALLSPHINXOPTS) $(BUILDDIR)/pseudoxml
	@echo
	@echo "Build finished. The pseudo-XML files are in $(BUILDDIR)/pseudoxml."
