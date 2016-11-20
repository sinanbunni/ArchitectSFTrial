public with sharing class CallCentre_AdminBasicSupport implements CallCentre_AdminSupport {
	
	public Integer getSLA() {
		return 10;
	}

	public Integer allowedTickets() {
		return 10;
	}
}