package permit.generated.conditionset

import future.keywords.in

import data.permit.generated.abac.utils.attributes

default userset_acct1_5fmanagers = false

userset_acct1_5fmanagers {
	"account_manager" in attributes.user.roles
}
