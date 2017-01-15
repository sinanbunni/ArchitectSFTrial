trigger ValueCountMultiSelectPicklist on Account (before insert, before update) {

	Map<Account, Integer> accIdToMultiSelectPicklistList = new Map<Account, Integer>();

	for (Account acc : Trigger.new) {
		if (acc.Fun_List__c != NULL) {
			List<String> picklistVals = acc.Fun_List__c.split(';');
			if (!picklistVals.isEmpty()) {
				accIdToMultiSelectPicklistList.put(acc, acc.Fun_List__c.split(';').size());
				acc.Fun_Picklist_Counter__c = accIdToMultiSelectPicklistList.get(acc);
			} else {
				acc.Fun_Picklist_Counter__c = 0;
			}
		}
	}

}