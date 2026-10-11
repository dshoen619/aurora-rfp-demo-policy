package permit.generated.conditionset

import future.keywords.in

import data.permit.generated.abac.utils.attributes

default userset__5f_5fautogen_5ftechnician = false

userset__5f_5fautogen_5ftechnician {
	"technician" in attributes.user.roles
}
