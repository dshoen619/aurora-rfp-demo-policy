package permit.generated.conditionset

import future.keywords.in

import data.permit.generated.abac.utils.attributes

default resourceset_south_5ftrucks = false

resourceset_south_5ftrucks {
	attributes.resource.region == "South"
	attributes.resource.type == "asset"
}
