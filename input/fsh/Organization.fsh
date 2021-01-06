Profile: BCOrganization
Parent: Organization
Id: bc-organization
Description: "General constraints on the Organization resource for use in the BC Provider Registry project."

* identifier 0..* MS
* active MS
* type MS
* name 1..1 MS
* name.extension contains ValidFlagExtension named validFlag 0..1 MS and 
	NameUseExtension named use 0..1 MS and 
	PeriodExtension named period 0..1 MS and
	StatusExtension named status 0..* MS
* telecom only BCContactPoint 
* telecom MS
* address only BCAddress
* address MS
* extension contains LicenseStatusExtension named status 0..* MS and
	NoteExtension named note 0..* MS

Profile: BCOrganizationAffiliation
Parent: OrganizationAffiliation
Id: bc-organizationaffiliation
Description: "General constraints on the OrganizationAffiliation resource for use in the BC Provider Registry project."

* identifier 0..*  MS
* active MS
* period MS
* organization MS
* organization only Reference(BCOrganization)
* participatingOrganization MS
* participatingOrganization only Reference(BCOrganization)
* network MS
* code MS
* specialty MS
* location MS
* location only Reference(BCLocation)
* telecom only BCContactPoint
* telecom MS

Extension: NameUseExtension
Id: bc-name-use-extension
Title: "BC Name Use Extension"
Description: "Allows for use on a simple name string."
* value[x] only code
* valueCode from http://hl7.org/fhir/ValueSet/name-use (required)

Instance: Example-Qualification-Organization
InstanceOf: BCOrganization
* name = "CREDENTIAL_CREDENTIALGRANTINGINSTTXT"
* address.city = "CALGARY"
* address.state = "AB"
* address.country = "CA"

Instance: Example-AddOrganization-Bundle
InstanceOf: Bundle
* type = #transaction
* entry[0].fullUrl = "http://plr.moh.bc.ca/fhir/Organization/12345"
* entry[0].resource = Example-AddOrganization-Organization
* entry[0].request.method = #POST
* entry[0].request.url = "http://plr.moh.bc.ca/fhir/Organization"
* entry[1].fullUrl = "http://plr.moh.bc.ca/fhir/OrganizationAffiliation/12345"
* entry[1].resource = Example-AddOrganization-OrganizationAffiliation
* entry[1].request.method = #POST
* entry[1].request.url = "http://plr.moh.bc.ca/fhir/OrganizationAffiliation"
* entry[2].fullUrl = "http://plr.moh.bc.ca/fhir/Location/12345"
* entry[2].resource = Example-AddOrganization-Location
* entry[2].request.method = #POST
* entry[2].request.url = "http://plr.moh.bc.ca/fhir/Location"

Instance: Example-AddOrganization-Organization
InstanceOf: BCOrganization
* identifier[0].system = "urn:oid:2.16.840.1.113883.3.40.2.3"
* identifier[0].value = "CPN.00147422.BC.PRS"
* identifier[1].system = "urn:oid:2.16.840.1.113883.3.40.2.8"
* identifier[1].value = "IPC.00147422.BC.PRS"
* identifier[2].system = "urn:oid:2.16.840.1.113883.3.40.2.23"
* identifier[2].value = "1000095892"
* name = "Kelowna Clinic"
* name.extension[use].valueCode = #official
* name.extension[period].valuePeriod.start = "2014-01-31T00:00:00-07:00"
* address.use = #work
* address.type = #postal
* address.line = "2541 Townsend Rd"
* address.city = "Sooke"
* address.state = "BC"
* address.country = "CA"
* address.postalCode = "V4R8T8"
* address.period.start = "2014-01-31T00:00:00-07:00"
* telecom[0].use = #work
* telecom[0].system = #phone
* telecom[0].value = "7786428585"
* telecom[0].period.start = "2014-01-31T00:00:00-07:00"
* active = true
* extension[status].extension[statusCode].valueCode = http://terminology.hl7.org/CodeSystem/v3-RoleStatus#normal
* extension[status].extension[period].valuePeriod.start = "2014-01-31T00:00:00-07:00"
* extension[status].extension[period].valuePeriod.end = "2030-01-31T00:00:00-07:00"
* extension[status].extension[eventId].valueIdentifier.system = "urn:oid:2.16.840.1.113883.3.40.1.12"
* extension[status].extension[eventId].valueIdentifier.value = "status1"
* extension[status].extension[statusReasonCode].valueCodeableConcept = http://example.org/status_reason_code#ORG

Instance: Example-AddOrganization-OrganizationAffiliation
InstanceOf: BCOrganizationAffiliation
* active = true
* period.start = "1989-04-04T00:00:00-07:00"
* organization = Reference(Example-AddOrganization-Organization)
* location = Reference(Example-AddOrganization-Location)