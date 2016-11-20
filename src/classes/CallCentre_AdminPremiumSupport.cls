public with sharing class CallCentre_AdminPremiumSupport implements CallCentre_AdminSupport {
	
	public Integer getSLA() {
		return 20;
	}

	public Integer allowedTickets() {
		return 20;
	}
}