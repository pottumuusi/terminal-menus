MENU_MAIN := menu_main.pl

MENU_MAIN:
	$(shell true) # No build steps at the moment

run: $(MENU_MAIN)
	perl -I . $(MENU_MAIN)
