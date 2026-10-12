package permit.generated.conditionset

import future.keywords.in

import data.permit.generated.abac.utils.attributes

default resourceset_serviceable_5ftrucks = false

resourceset_serviceable_5ftrucks {
	attributes.resource.lifecycle_state == "active"
	attributes.resource.geofence == "depot"
	attributes.resource.local_hour >= 2
	attributes.resource.local_hour < 22
	attributes.resource.type == "asset"
}
