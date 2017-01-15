/**
 * Created by SinanBunni on 20/11/2016.
 */

public class DefaultClass {

    public static void getContent() {

        List<Account> accounts = [SELECT Id, Name, AnnualRevenue, (SELECT Id, CampaignId FROM Opportunities) FROM Account LIMIT 10 ];
        for (Account acc : accounts) {
            System.debug(acc);
        }
    }

}