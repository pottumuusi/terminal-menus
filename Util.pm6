unit module Util;

class Debug {
	my constant DEBUG_ON = 1;
	my constant DEBUG_TAG = "[D]";

	method print($module_debug_on, $msg) {
		if (! $module_debug_on) {
			return;
		}

		say(DEBUG_TAG ~ " $msg");
	}

	method is_on() {
		return DEBUG_ON;
	}
};
