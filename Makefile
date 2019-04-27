MENU_MAIN := new_main.p6

MENU_MAIN:
	$(shell true) # No build steps at the moment

# TODO Does depend on NewModule.pm6 being up to date
run: $(MENU_MAIN)
	perl6 -I . $(MENU_MAIN)
