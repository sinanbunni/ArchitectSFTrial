public class CallCentre_AdminSupportFactory {
	
	public static CallCentre_AdminSupport getInstance(String supportType) {

		CallCentre_SupportType__c adminSupportType = CallCentre_SupportType__c.getValues(supportType);

		Type classType = Type.forName(adminSupportType.ClassName__c);
		CallCentre_AdminSupport adminSupport = 
				(CallCentre_AdminSupport)classType.newInstance();

		return adminSupport;
	}
}