trigger CloseCaseMoreContacts on Case (before insert, before update) {

	// Get List of contactIds and accountIds from the inserted Cases 
	List<Id> contactIds = new List<Id>();
	List<Id> accountIds = new List<Id>();
	for (Case ca : Trigger.new) {
		if (ca.contactId != NULL) {
			contactIds.add(ca.contactId);
		}

		if (ca.AccountId != NULL) {
			accountIds.add(ca.AccountId);
		}
	}

	// get a list of Cases associated with the Contacts being inserted by the trigger
	List<Case> contactWithCases = [SELECT Id, ContactId, Status 
									FROM Case 
									WHERE ContactId IN :contactIds AND 
											CreatedDate = today];

	// get a list of Cases associated with the Accounts being inserted by the trigger
	List<Case> contactWithAccounts = [SELECT Id, AccountId, Status
									FROM Case
									WHERE AccountId IN :accountIds AND 
											CreatedDate = today];

	// get a map collection where key is the ContactId and value is the a list of cases associated with it
	Map<Id, List<Case>> contactIdToCaseListMap = new Map<Id, List<Case>>();
	for (Case ca : contactWithCases) {
		if (ca.ContactId != NULL) {
			if (!contactIdToCaseListMap.containsKey(ca.ContactId)) {
				contactIdToCaseListMap.put(ca.ContactId, new List<Case> { ca });
			} else {
				contactIdToCaseListMap.get(ca.ContactId).add(ca);
			}
		}
	}

	// get a map collection where key is the AccountId and value is the a list of cases associated with it
	Map<Id, List<Case>> accountIdToCaseListMap = new Map<Id, List<Case>>();
	for (Case ca : contactWithAccounts) {
		if (ca.AccountId != NULL) {
			if (!accountIdToCaseListMap.containsKey(ca.AccountId)) {
				accountIdToCaseListMap.put(ca.AccountId, new List<Case> { ca });
			} else {
				accountIdToCaseListMap.get(ca.AccountId).add(ca);
			}
		}
	}

	// update the status
	for (Case ca : Trigger.new) {
		if (ca.contactId != NULL) {
			if(contactIdToCaseListMap.containsKey(ca.contactId) && contactIdToCaseListMap.get(ca.contactId).size() >= 2) {
				ca.Status = 'Closed';
			}
		}

		if (ca.AccountId != NULL) {
			if(accountIdToCaseListMap.containsKey(ca.AccountId) && accountIdToCaseListMap.get(ca.AccountId).size() >= 3) {
				ca.Status = 'Closed';
			}
		}
	}

} // end CloseCaseMoreContacts trigger