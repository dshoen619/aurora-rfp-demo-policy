package permit.generated.conditionset

import future.keywords.in

import data.permit.generated.abac.utils.attributes

default userset_south_5fdispatchers = false

userset_south_5fdispatchers {
	"south_dispatcher" in attributes.user.roles
}
