package permit.generated.conditionset

import future.keywords.in

import data.permit.generated.abac.utils.attributes

default resourceset_Trucks_5fServicing_5fOrg = false

resourceset_Trucks_5fServicing_5fOrg {
	attributes.resource.operator_org == attributes.user.home_tenant
	attributes.resource.type == "asset"
}
