trigger SensativeDataCaseDetection on Case (after insert, before update) {

	String childCaseSubject = 'Warning: Parent Case contains sensative data';
	Set<String> sensativeData = new Set<String> { 'bodywieght', 'ssn', 'passport', 'Social Security', 'Credit Card'};
	Set<Case> parentCases = new Set<Case>();
	List<Case> childCases  = new List<Case>();
	Set<String> sensativeDataFound = new Set<String>();

	for (Case ca : Trigger.new) {
		if (ca.Subject != childCaseSubject) {
			for (String data : sensativeData) {
				if (ca.Description != NULL && ca.Description.containsIgnoreCase(data)) {
					sensativeDataFound.add(data);
					parentCases.add(ca);
				}
			}
		}
	}

	// create child cases
	for (Case ca : new List<Case> (parentCases)) {
		childCases.add(
			new Case(
				Subject = childCaseSubject,
				Description = 'The sensative keywords are: ' + String.join(new List<String> (sensativeDataFound), ', '),
				ParentId = ca.Id,
				IsEscalated = true,
				Priority = 'High'
			)
		);
	}

	Database.insert(childCases, true);



} // end SensativeDataCaseDetection trigger