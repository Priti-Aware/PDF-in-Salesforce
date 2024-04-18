public class InvoicePDFController {
    public Account account {get; set;}
    
    public List<Opportunity> wonOppList {get; set;}
    public List<Opportunity> notWonOppList {get; set;}
    
    public invoicePDFController(){
        this.account = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, 
                        	   BillingPostalCode, BillingCountry
                        FROM Account
                        WHERE Id = ''
                       ];
        
        this.wonOppList = [SELECT Name, Amount, CloseDate
                           FROM Opportunity
                           WHERE AccountId = :this.account.Id 
                           AND StageName = 'Closed Won'                              
                          ];
        
        this.notWonOppList = [SELECT Name, Amount, StageName
                              FROM Opportunity
                              WHERE AccountId =:this.account.Id
                              AND StageName != 'Closed Won'
                             ];
    }
}