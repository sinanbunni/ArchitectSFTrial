public with sharing class CallCentre_AdminGoldSupport implements CallCentre_AdminSupport {
	
	public Integer getSLA() {
		return 30;
	}

	public Integer allowedTickets() {
		return 30;
	}
}