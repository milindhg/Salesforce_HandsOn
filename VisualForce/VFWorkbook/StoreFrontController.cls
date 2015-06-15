public class StoreFrontController {
    List<DisplayMerchandise> products;
    
    public List<DisplayMerchandise> getProducts() {
        if(products==null){
            products = new List<DisplayMerchandise>();
            for(Merchandise__c item: [
                    SELECT Id, Name, Condition__c, Price__c, Quantity__c
                    FROM Merchandise__c]){
                products.add(new DisplayMerchandise(item));
            }
        }
        return products;
    }
    
    //inner class to hold online store details for each merchandise item
    public class DisplayMerchandise{
        private Merchandise__c merchandise;
        
        public DisplayMerchandise(Merchandise__c item){
            this.merchandise = item;
        }
        
        //Properties for using in the visualforce page
        public String name{
            get { return merchandise.Name;}
        }
        
        public Double condition{
            get { return merchandise.Quantity__c;}
        }
        
        public Decimal price{
            get { return merchandise.Price__c;}
        }
        
        public Boolean inStock{
            get { return (0 < merchandise.Quantity__c);}
        }
        
        public Integer qtyToBuy { get; set;}
    }
}