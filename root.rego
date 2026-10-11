package permit.root

import data.permit.custom
import data.permit.debug
import data.permit.policies

default allow := false

# Aurora demo (R5): the generated policy (RBAC, ReBAC, ABAC) must allow AND the request must satisfy
# the acting-organization constraint in custom/root.rego. Custom code can only narrow access.
# Permit may regenerate this file after policy changes in the dashboard. If `make verify` reports the
# rule missing, run `make apply-policy` in the demo folder to re-apply it.
allow {
	policies.allow
	custom.acting_org_ok
}

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
	result := object.union(debug.debug, {"acting_org": custom.acting_org_debug})
}
