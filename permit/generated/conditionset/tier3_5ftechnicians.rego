package permit.generated.conditionset

import future.keywords.in

import data.permit.generated.abac.utils.attributes

default userset_tier3_5ftechnicians = false

userset_tier3_5ftechnicians {
	"technician" in attributes.user.roles
	"tier3" in attributes.user.certifications
}
