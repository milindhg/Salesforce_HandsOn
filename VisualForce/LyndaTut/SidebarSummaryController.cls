public with sharing class SidebarSummaryController {

    public Map<String, Integer> oppstages { get; set; }
    
    public SidebarSummaryController()
    {
        oppstages = new Map<String, Integer>();
        for(AggregateResult ar : [Select StageName, Count(ID) cnt FROM Opportunity GROUP BY StageName])
        {
            oppstages.put((String)ar.get('StageName'), (Integer) ar.get('cnt'));
        }
    }
    
}