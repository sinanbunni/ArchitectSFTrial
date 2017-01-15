trigger FuzzyLeadDedupesTrigger on Lead (before insert) {

	Map<Id, Map<String, String>> leadIdToNameMatchMap = new Map<Id, Map<String, String>>();
	Map<String, String> leadFirstNameToFirstLetterMap = new Map<String, String>();
	Map<Id, String> leadLastNamesMap  = new Map<Id, String>();
	Map<Id, String> leadEmailsMap     = new Map<Id, String>();
	Map<Id, String> leadCompaniesMap  = new Map<Id, String>();

	for (Lead lead : Trigger.new) {
		if (lead.FirstName != NULL) {
			if (!leadIdToNameMatchMap.containsKey(lead.Id)) {
				leadFirstNameToFirstLetterMap.put(lead.FirstName, lead.FirstName.substring(0, 1));
				leadIdToNameMatchMap.put(lead.Id, leadFirstNameToFirstLetterMap);
			}
		}

		if (lead.LastName != NULL) {
			if (!leadLastNamesMap.containsKey(lead.LastName)) {
				leadLastNamesMap.put(lead.Id, lead.LastName);
			}
		}

		if (lead.Email != NULL) {
			if (!leadEmailsMap.containsKey(lead.Email)) {
				leadEmailsMap.put(lead.Id, lead.Email);
			}
		}

		if (lead.Company != NULL) {
			if (!leadCompaniesMap.containsKey(lead.Company)) {
				leadCompaniesMap.put(lead.Id, lead.Company);
			}
		}
	} // end for

	List<Contact> matchContacts = new List<Contact>();
	








} // end FuzzyLeadDedupesTrigger trigger