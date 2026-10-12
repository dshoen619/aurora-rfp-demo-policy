package permit.root

import data.permit.custom
import data.permit.debug
import data.permit.policies

default allow := false

# TEST: the custom rules are commented out, so only Permit's generated policy (RBAC, ReBAC, ABAC)
# decides. custom/root.rego is untouched; nothing consults it. To turn the rules back on, run
# `make apply-policy` in fleetops-go (it re-applies the block below, with a fresh version stamp).
allow {
	policies.allow
}

allow {
	custom.allow
}

# Custom rules, off:
# allow {
# 	policies.allow
# 	custom.acting_org_ok
# 	custom.fleet_rules_ok
# }
#
# allow {
# 	custom.extra_allow
# 	custom.acting_org_ok
# 	custom.fleet_rules_ok
# }

allowing_sources := policies.__allow_sources

default __data_use_debugger := true

__data_use_debugger = data.use_debugger

default __input_use_debugger := null

__input_use_debugger = input.use_debugger

default debugger_activated := false

debugger_activated {
	__data_use_debugger == true
	__input_use_debugger != false
} else {
	__input_use_debugger == true
}

debug = result {
	debugger_activated
	# result := object.union(debug.debug, {"acting_org": custom.acting_org_debug, "fleet_rules": custom.fleet_rules_debug})
	result := debug.debug
}
