trigger LeadDedupesTrigger on Lead (before insert) {

	Set<String> leadEmails = new Set<String>();
	for (Lead lead : Trigger.new) {
		if (lead.Email != NULL) {
			leadEmails.add(lead.Email);
		}
	}

	List<Contact> contactsWithSameEmailLeads = [SELECT Id, Email
												FROM Contact
												WHERE Email IN :leadEmails];


	Map<String, List<Contact>> emailToContactListMap = new Map<String, List<Contact>>();
	for(String email : leadEmails) {
		if (!emailToContactListMap.containsKey(email)) {
			emailToContactListMap.put(email, [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Email = :email]);
		}
	}

	List<Group> dataQualityGroup = [SELECT Id 
									FROM Group 
									WHERE Type = 'Queue' AND 
									  	  Name = 'Data Quality' 
									LIMIT 1];

	
	if (!contactsWithSameEmailLeads.isEmpty()) {
		// assign Leads to queue
		for (Lead lead : Trigger.new) {
			if (emailToContactListMap.containsKey(lead.Email) && !emailToContactListMap.get(lead.Email).isEmpty()) {
				if (!dataQualityGroup.isEmpty()) {
					lead.OwnerId = dataQualityGroup.get(0).Id;
				}
				
				if (lead.Description != NULL) {
					lead.Description = lead.Description + '\n' +
								'Duplicate Contacts founds are: \n' + 
								String.join(emailToContactListMap.get(lead.Email), '; \n');
					} else {
						lead.Description = 'Duplicate Contacts founds are: \n' + 
						String.join(emailToContactListMap.get(lead.Email), '; \n');
					}
			}
		} // end for 
	}

}// end LeadDedupes trigger