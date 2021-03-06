Profile: BCPractitioner
Parent: Practitioner
Id: bc-practitioner
Description: "General constraints on the Practitioner resource for use in the BC Provider Registry project."
* contained ^slicing.discriminator.type = #type
* contained ^slicing.discriminator.path = "$this"
* contained ^slicing.rules = #open
* contained ^slicing.description = "The organization that authorized a qualification."
* contained contains QualificationOrganization 0..* MS
* contained[QualificationOrganization] only BCOrganization
* identifier only BCIdentifier
* identifier 1..* MS
* active MS
* name only BCHumanName 
* name 1..* MS
* telecom only BCContactPoint
* telecom MS
* address only BCAddress 
* address MS
* gender MS
* birthDate MS
* birthDate.extension contains BirthTimeExtension named birthTime 0..1 MS
* qualification MS
* qualification.extension contains PractitionerQualificationIssueDateExtension named issueDate 1..1 MS and EndReasonExtension named endReason 0..1 MS
* qualification.identifier MS
* qualification.code MS
* qualification.code from $PracQualification (required)
* qualification.period MS
* qualification.issuer MS
* qualification.issuer only Reference(BCOrganization)
* communication MS
* communication.extension contains PeriodExtension named period 1..1 MS and EndReasonExtension named endReason 0..1 MS
* extension contains PeriodExtension named demographicsPeriod 1..1 MS and EndReasonExtension named demographicsEndReason 0..1 MS and 
    LicenseStatusExtension named status 0..* MS and 
	DeathDateExtension named deathDate 0..1 MS and 
	BirthPlaceExtension named birthplace 0..1 MS and
	PractitionerConfidentialityExtension named confidentiality 0..1 MS and
	PractitionerRelationshipExtension named relationship 0..* MS and
	PractitionerDiscplinaryActionExtension named disciplinaryAction 0..* MS and
	NoteExtension named note 0..* MS and
	PractitionerConditionExtension named condition 0..* MS

Profile: BCPractitionerRole
Parent: PractitionerRole
Id: bc-practitioner-role
Description: "General constraints on the PractitionerRole resource for use in the BC Provider Registry project."
* identifier 0..* MS
* active MS
* period MS
* practitioner 1..1 MS
* practitioner only Reference(BCPractitioner) 
* organization MS
* organization only Reference(BCOrganization)
* organization.extension contains EndReasonExtension named endReason 0..1 MS
* code MS
* code from $PracRoleCode (required)
* specialty MS
* specialty from $PracSpecialty (required)
* specialty.extension contains PeriodExtension named period 1..1 MS and EndReasonExtension named endReason 0..1 MS
* location MS
* location only Reference(BCLocation)
* location.extension contains PeriodExtension named period 1..1 MS and EndReasonExtension named endReason 0..1 MS
* telecom only BCContactPoint
* telecom MS

Extension: DeathDateExtension
Id: bc-practitioner-deathdate-extension
Title: "BC Practitioner Date of Death Extension"
Description: "The Date of Death of a Practitioner."
* value[x] only dateTime

Extension: BirthTimeExtension
Id: bc-birthtime-extension
Title: "BC Extra birth time information"
Description: "Adds birth time to the birth date."
* value[x] only dateTime

Extension: BirthPlaceExtension
Id: bc-birthplace-extension
Title: "BC Birth Place Extension"
Description: "Captures the place where a patient/practitioner/person was born."
* value[x] only Address

Extension: PractitionerConfidentialityExtension
Id: bc-practitioner-confidentiality-extension
Title: "BC Practitioner Confidentiality Extension"
Description: "Indicates the confidentality of the practitioner's information."
* extension contains code 1..1 MS and PeriodExtension named period 1..1 MS and EndReasonExtension named endReason 0..1 MS
* extension[code].value[x] only CodeableConcept
* extension[code].valueCodeableConcept from http://terminology.hl7.org/ValueSet/v3-ConfidentialityClassification (required)

Extension: PractitionerRelationshipExtension
Id: bc-practitioner-relationship-extension
Title: "BC Practitioner to Practitioner Relationship"
Description: "Allows for relationships of practitioners to practitioners without needing CareTeam semantics."
* extension contains PeriodExtension named period 1..1 MS and practitioner 1..1 MS and type 1..1 MS and EndReasonExtension named endReason 0..1 MS
* extension[practitioner].value[x] only Reference(BCPractitioner)
* extension[type].value[x] only CodeableConcept

Extension: PractitionerDiscplinaryActionExtension
Id: bc-practitioner-disciplinary-action-extension
Title: "BC Practitioner Disciplinary Actions"
Description: "Provides details of disciplinary actions against the provider."
* extension contains identifier 1..1 MS and description 1..1 MS and PeriodExtension named period 1..1 MS and archiveDate 1..1 MS and displayFlag 1..1 MS and EndReasonExtension named endReason 0..1 MS
* extension[identifier].value[x] only Identifier
* extension[description].value[x] only string
* extension[archiveDate].value[x] only dateTime
* extension[displayFlag].value[x] only boolean

Extension: NoteExtension
Id: bc-note-extension
Title: "BC Notes"
Description: "Notes about the practitioner/location/organization."
* extension contains identifier 1..1 MS and text 1..1 MS and PeriodExtension named period 1..1 MS and EndReasonExtension named endReason 0..1 MS
* extension[identifier].value[x] only Identifier
* extension[text].value[x] only string

Extension: PractitionerConditionExtension
Id: bc-practitioner-condition-extension
Title: "BC Practitioner Conditions"
Description: "Conditions on the provider's role"
* extension contains identifier 1..1 MS and PeriodExtension named period 1..1 MS and restriction 1..1 MS and restrictionText 1..1 MS and code 1..1 MS and EndReasonExtension named endReason 0..1 MS
* extension[identifier].value[x] only Identifier
* extension[restriction].value[x] only boolean
* extension[restrictionText].value[x] only string
* extension[code].value[x] only CodeableConcept

Extension: PractitionerQualificationIssueDateExtension
Id: bc-practitioner-qualification-issue-date-extension
Title: "BC Practitioner Qualification Issue Date"
Description: "The issue date of the practitioner's qualification."
* value[x] only dateTime

Extension: LicenseStatusExtension
Id: bc-license-status-extension
Title: "BC License Status Extension"
Description: "Tracking the status and changes to the status of a practitioner/organization license."
* extension contains statusCode 1..1 MS and period 1..1 MS and statusReasonCode 1..1 MS and endReasonCode 0..1 MS and custodianId 0..1 MS
* extension[statusCode].value[x] only CodeableConcept
* extension[statusCode].valueCodeableConcept from $StatusVS (required)
* extension[period].value[x] only Period
* extension[statusReasonCode].value[x] only CodeableConcept
* extension[endReasonCode].value[x] only CodeableConcept
* extension[custodianId].value[x] only Identifier

Profile: BCProviderBundle
Parent: Bundle
Id: bc-provider-bundle
Description: "A bundle that submits Practitioner and PractitionerRole information."
* type 1..1 MS
* type = #transaction (exactly)
* entry 1..*
* entry.resource 1..1 MS
* entry.fullUrl 1..1 MS
* entry.search 0..0
* entry.request 1..1 MS
* entry.response 0..0
* entry ^slicing.discriminator.type = #type
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.description = "The specific bundle entries that are needed for creating or updating a BC Practitioner."
* entry contains Practitioner 1..1 MS and PractitionerRole 0..* MS
* entry[Practitioner].resource only BCPractitioner
* entry[PractitionerRole].resource only BCPractitionerRole

Instance: Example-AddProvider-Bundle
InstanceOf: BCProviderBundle
Description: "Example of a bundle of resources sent when requesting a provider create."
* type = #transaction
* entry[0].fullUrl = "http://plr.moh.bc.ca/fhir/Practitioner/12345"
* entry[0].resource = Example-AddProvider-Practitioner
* entry[0].request.method = #POST
* entry[0].request.url = "http://plr.moh.bc.ca/fhir/Practitioner"
* entry[1].fullUrl = "http://plr.moh.bc.ca/fhir/PractitionerRole/12345"
* entry[1].resource = Example-AddProvider-PractitionerRole
* entry[1].request.method = #POST
* entry[1].request.url = "http://plr.moh.bc.ca/fhir/PractitionerRole"

Instance: Example-AddProvider-Practitioner
InstanceOf: BCPractitioner
Description: "Example of a BC practitioner that is being created."
* extension[status].extension[statusCode].valueCodeableConcept = $RoleStatus#active
* extension[status].extension[period].valuePeriod.start = "2000-01-01"
* extension[status].extension[period].valuePeriod.end = "2020-01-01"
* extension[status].extension[custodianId].valueIdentifier.system = "urn:oid:2.16.840.1.113883.3.40.1.16"
* extension[status].extension[custodianId].valueIdentifier.value = "RNA"
* extension[status].extension[statusReasonCode].valueCodeableConcept = http://example.org/status_reason_code#PRAC
* extension[demographicsEndReason].extension[custodianId].valueIdentifier.system = "urn:oid:2.16.840.1.113883.3.40.1.16"
* extension[demographicsEndReason].extension[custodianId].valueIdentifier.value = "RNA"
* extension[demographicsEndReason].extension[endReasonCode].valueCodeableConcept = http://example.org/status_reason_code#PRAC
* extension[deathDate].valueDateTime = "2000-02-01"
* extension[birthplace].valueAddress.state = "AL"
* extension[birthplace].valueAddress.country = "US"
* extension[disciplinaryAction].extension[identifier].valueIdentifier.system = "urn:oid:2.16.840.1.113883.3.40.1.4"
* extension[disciplinaryAction].extension[identifier].valueIdentifier.value = "DISCIPLINARY_ACTION_TEST1"
* extension[disciplinaryAction].extension[description].valueString = "DISCIPLINARYACTION_DESCRIPTIONTXT_1"
* extension[disciplinaryAction].extension[period].valuePeriod.start = "1950-11-20T00:00:00-07:00"
* extension[disciplinaryAction].extension[period].valuePeriod.end = "2020-01-01"
* extension[disciplinaryAction].extension[archiveDate].valueDateTime = "2020-01-01"
* extension[disciplinaryAction].extension[displayFlag].valueBoolean = true
* extension[confidentiality].extension[code].valueCodeableConcept = http://terminology.hl7.org/CodeSystem/v3-Confidentiality#N
* extension[confidentiality].extension[period].valuePeriod.start = "2000-01-01"
* extension[confidentiality].extension[period].valuePeriod.end = "2020-01-01"
* extension[note].extension[identifier].valueIdentifier.system = "urn:oid:2.16.840.1.113883.3.40.1.6"
* extension[note].extension[identifier].valueIdentifier.value = "noteID1"
* extension[note].extension[text].valueString = "Note text sample"
* extension[note].extension[period].valuePeriod.start = "2000-01-01"
* extension[note].extension[period].valuePeriod.end = "2020-01-01"
* extension[condition].extension[identifier].valueIdentifier.system = "urn:oid:2.16.840.1.113883.3.40.1.1"
* extension[condition].extension[identifier].valueIdentifier.value = "23"
* extension[condition].extension[period].valuePeriod.start = "2000-01-01"
* extension[condition].extension[period].valuePeriod.end = "2020-01-01"
* extension[condition].extension[restriction].valueBoolean = true
* extension[condition].extension[restrictionText].valueString = "CONDITION_RESTRICTION_EXPLANATION TEXT"
* extension[condition].extension[code].valueCodeableConcept = http://example.org/condition_type_code#LOC
* extension[relationship].extension[period].valuePeriod.start = "2000-01-01"
* extension[relationship].extension[period].valuePeriod.end = "2020-01-01"
* extension[relationship].extension[type].valueCodeableConcept = http://example.org/provider_relationship_type_code#LOC
* extension[relationship].extension[practitioner].valueReference = Reference(Example-AddProvider-RelatedPractitioner)
* extension[demographicsPeriod].valuePeriod.start = "2000-01-01"
* extension[demographicsPeriod].valuePeriod.end = "2020-01-01"
* contained[QualificationOrganization] = Example-Qualification-Organization
* contained[QualificationOrganization].id = "qualificationOrganization"
* identifier.system = "urn:oid:2.16.840.1.113883.3.40.2.4"
* identifier.value = "MD20180719V01"
* identifier.period.start = "2000-01-01"
* identifier.period.end = "2020-01-01"
* active = true
* name.family = "KELASEY"
* name.given = "SONYA"
* name.given[1] = "NAME PRSNSECONDGIVENNAMETXT"
* name.given[2] = "NAME PRSNTHIRDGIVENNAMETXT"
* name.prefix = "PRSNPREFIX"
* name.suffix = "PRSNSUFFIX"
* name.period.start = "2000-01-01"
* name.period.end = "2020-01-01"
* name.use = #official
* telecom[0].system = #phone
* telecom[0].use = #home
* telecom[0].value = "2507654333"
* telecom[0].period.start = "2000-01-01"
* telecom[0].period.end = "2020-01-01"
* telecom[1].system = #email
* telecom[1].use = #work
* telecom[1].value = "hey@day.com"
* telecom[1].period.start = "2000-01-01"
* telecom[1].period.end = "2020-01-01"
* address.use = #work
* address.type = #postal
* address.line = "91 RD"
* address.line[1] = "ADDRESS ADDRESSLINE2TXT"
* address.line[2] = "ADDRESS ADDRESSLINE3TXT"
* address.city = "VICTORIA"
* address.state = "BC"
* address.postalCode = "V8V8V8"
* address.period.start = "2000-01-01"
* address.period.end = "2020-01-01"
* gender = #female
* birthDate = "1951-11-12"
* birthDate.extension[birthTime].valueDateTime = "1951-11-12T00:00:01-06:00"
* qualification.identifier.system = "urn:oid:2.16.840.1.113883.3.40.1.2"
* qualification.identifier.value = "CREDENTIAL_REGISTRATIONNUMBERTXT"
* qualification.code = $SCPQual#BD
* qualification.code.text = "CREDENTIAL_CREDENTIALDESIGNATIONTXT"
* qualification.period.start = "2000-01-01"
* qualification.period.end = "2020-01-01"
* qualification.issuer.reference = "#qualificationOrganization"
* qualification.extension[issueDate].valueDateTime = "2001"

Instance: Example-AddProvider-RelatedPractitioner
InstanceOf: BCPractitioner
Description: "Example of a practitioner that has a relationship to the example created practitioner."
* extension[demographicsPeriod].valuePeriod.start = "2000-01-01"
* identifier.system = "urn:oid:2.16.840.1.113883.3.40.20.19"
* identifier.value = "3DEGDIDERCHIDMAY22T02"
* name.text = "23"

Instance: Example-AddProvider-PractitionerRole
InstanceOf: BCPractitionerRole
Description: "Example of the role that the created practitioner is playing."
* practitioner = Reference(Example-AddProvider-Practitioner)
* organization.display = "BC"
* code = $SCPType#MD
* specialty = http://snomed.info/sct#419772000
* specialty.extension[period].valuePeriod.start = "2000-01-01"
* specialty.extension[period].valuePeriod.end = "2020-01-01"
* specialty.extension[endReason].extension[endReasonCode].valueCodeableConcept = http://example.org/status_reason_code#PRAC
* specialty.extension[endReason].extension[custodianId].valueIdentifier.system = "http://example.org/custodian-ids"
* specialty.extension[endReason].extension[custodianId].valueIdentifier.value = "123456679"
* location = Reference(Example-AddProvider-WorkLocation)
* location.extension[period].valuePeriod.start = "2000-01-01"
* location.extension[period].valuePeriod.end = "2020-01-01"
