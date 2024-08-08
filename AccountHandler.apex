public class AccountHandler {
    public static Account insertNewAccount(String accountName, String emailAddress){
        
        try{   // try-catch to handle unexpected exceptions
        
        if(accountName != '' || accountName != null){   // Since Name is mandatory field for Account creation. 
            
            Account acc = new Account(Name = accountName);
            
          insert acc; // insert single account, can use Database.insert if going for bulk insert.
          
            System.debug('Account ' + accountName + ' created successfully.');  
           
            sendMail(emailAddress, 'Salesforce Account Creation', 'Your Salesforce Account ' + accountName + 'created successfully');  // calling send email method on successful account creation.
            return acc;
         }
            
            else 
                return null;
        
      
            
        } catch(DmlException e){

System.debug('error message ' + e.getMessage());  // errorObject.getMessage() returns the error message on DmlException/ any other exception.
             return null;
        }
        
        
          
    }
    
    
    
    
     public static void sendMail(String address, String subject, String body) {  
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         
        String[] toAddresses = new String[]{address}; // 
            
        mail.setToAddresses(toAddresses);
         
        mail.setSubject(subject);
         
        mail.setPlainTextBody(body);
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
                                 new Messaging.SingleEmailMessage[] { mail });   // returns object of type MEssaging.sendEmailResult which can be further used to verify results.
    
         for(Messaging.sendEmailResult res: results){  
             
         if(res.isSuccess()){   
             
             System.debug('Email sent successfully');
         }
         
         else
             System.debug('The following errors occurred: ' + res.getErrors());  
         }
    }

}
