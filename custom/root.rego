package permit.custom

import future.keywords.in

# Permit's OR extension point. It stays false: nothing in this folder grants access.
default allow := false

# -------------------------------------------------------------------------------------------------
# R5 (Aurora FGA RFP): every decision is constrained to the acting organization.
#
# The application sends the acting organization as the check's tenant. When the resource instance
# is stored in Permit, it must belong to that organization, so roles and relationships the user
# holds in other organizations never apply. root.rego requires `acting_org_ok` on every allow.
# -------------------------------------------------------------------------------------------------

acting_org := object.get(input.resource, "tenant", null)

instance_key := sprintf("%s:%s", [input.resource.type, input.resource.key])

resource_org := data.resource_instances[instance_key].tenant

default acting_org_ok := false

# Type-level checks and resources not stored in Permit have no owning organization to compare.
acting_org_ok {
	not resource_org
}

acting_org_ok {
	resource_org == acting_org
}

default acting_org_code := "not_applicable"

acting_org_code := "same_org" {
	resource_org == acting_org
}

acting_org_code := "no_acting_org" {
	resource_org
	acting_org == null
}

acting_org_code := "acting_org_mismatch" {
	resource_org != acting_org
	acting_org != null
}

default acting_org_reason := "the resource is not stored in Permit, so the organization constraint does not apply"

acting_org_reason := sprintf("%s belongs to the acting organization '%s'", [instance_key, resource_org]) {
	acting_org_code == "same_org"
}

acting_org_reason := sprintf("%s belongs to organization '%s', but the request names no acting organization", [instance_key, resource_org]) {
	acting_org_code == "no_acting_org"
}

acting_org_reason := sprintf("%s belongs to organization '%s', but the request acts for '%s': roles and relationships held through other organizations do not apply", [instance_key, resource_org, acting_org]) {
	acting_org_code == "acting_org_mismatch"
}

default resource_org_or_null := null

resource_org_or_null := resource_org

acting_org_debug := {
	"allow": acting_org_ok,
	"code": acting_org_code,
	"reason": acting_org_reason,
	"acting_org": acting_org,
	"resource_org": resource_org_or_null,
}
