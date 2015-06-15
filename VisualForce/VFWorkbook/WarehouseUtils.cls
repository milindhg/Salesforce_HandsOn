global with sharing class WarehouseUtils {
    public WarehouseUtils(ApexPages.StandardSetController controller) { }
    
    //find warehouses nearest a geolocation
    @RemoteAction
    global static List<Warehouse__c> findNearbyWarehouses(String lat, String lon){
        
        //Initialize results to an empty list
        List<Warehouse__c> results = new List<Warehouse__c>();

        // If geolocation parameters are invalid, use San Francisco
        if(String.isBlank(lat) || String.isBlank(lon)) {
            lat = '37.793731';
            lon = '-122.395002';
        }
        
        
        //SOQL query to get nearest warehouses
        String queryString = 'Select w.Street_Address__c, w.Phone__c, w.Name, w.Location__Longitude__s, w.Location__Latitude__s, w.Id, w.City__c From Warehouse__c w' +
            ' WHERE DISTANCE(Location__c, GEOLOCATION('+lat+','+lon+'), \'mi\') < 10000 ' +
            ' ORDER BY DISTANCE(Location__c, GEOLOCATION('+lat+','+lon+'), \'mi\') ' +
            ' LIMIT 10';
        
        //Run the query
        results = database.query(queryString);
        
        //return the query resutls
        return(results);
        
        
    }
}