trigger LeadingCompetitor on Lead (before insert, before update) {

	Map<String, Decimal> competitorNameToPriceMap = new Map<String, Decimal>();

	for (Lead lead : Trigger.new) {
		competitorNameToPriceMap.put(lead.Competitor_1__c, lead.Competitor_1_Price__c);
		competitorNameToPriceMap.put(lead.Competitor_2__c, lead.Competitor_2_Price__c);
		competitorNameToPriceMap.put(lead.Competitor_3__c, lead.Competitor_3_Price__c);

		Decimal lowestPrice;
		String lowestCompetitor;

		Decimal highestPrice;
		String hightestCompetitor;

		for (String competitorName : competitorNameToPriceMap.keySet()) {
			Decimal competitorPrice = competitorNameToPriceMap.get(competitorName);
			if (lowestPrice == NULL || competitorPrice < lowestPrice) {
				lowestPrice = competitorPrice;
				lowestCompetitor = competitorName;
			}

			if (highestPrice == NULL || competitorPrice > highestPrice) {
				highestPrice = competitorPrice;
				hightestCompetitor = competitorName;
			}
		}

		lead.Leading_Competitor__c = lowestCompetitor;
		lead.Lowest_Competitor_Price__c = lowestPrice;
		lead.Highest_Competitor_Name__c = hightestCompetitor;
		lead.Highest_Competitor_Price__c = highestPrice;
	}

}