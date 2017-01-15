public with sharing class WrapperPageController {

	/**
	*
	* The wrapper requires the following for it to be
	* created and used approperiately
	*
	**/ 
	// We need to prepare the data for the wrapper


	// Create wrapper instances


	// append instances to the list 


	// prototype list member to be instantiated later
	public List<MyWrapper> wrapperList { get; private set; }

	// Constructor
	public WrapperPageController() {

		Map<Id, Contact> contactMap = new Map<Id, Contact>(
			[SELECT Id, Name
			FROM Contact
			WHERE Id IN (SELECT ContactId 
						FROM OpportunityContactRole 
						WHERE IsPrimary = true)]
		);

		Map<Id, Opportunity> opportunityMap = new Map<Id, Opportunity>(
			[SELECT Id, Name
			FROM Opportunity
			WHERE Id IN (SELECT OpportunityId
						FROM OpportunityContactRole
						WHERE IsPrimary = true)]
		);

		List<OpportunityContactRole> oppConRoles = [SELECT OpportunityId, ContactId 
													FROM OpportunityContactRole
													WHERE IsPrimary = true];

		// intialize and populate the wrapper list
		this.wrapperList = new List<MyWrapper>();
		for (OpportunityContactRole ocr : oppConRoles) {
			this.wrapperList.add(
				new MyWrapper(
					contactMap.get(ocr.ContactId),
					opportunityMap.get(ocr.OpportunityId)
				)
			);
		}

	}// end WrapperPageController constructor


	public class MyWrapper {
		public Contact contact {get; private set; }
		public Opportunity opportunity { get; private set; }

		public MyWrapper (Contact contact, Opportunity opportunity) {
			this.contact = contact;
			this.opportunity = opportunity;
		}
	} // end MyWrapper inner class
	
} // end WrapperPageController