
global class msd_ru_batch_updateUsernames implements Database.Batchable<sObject>
	{

		global final String Query;
   		global Map<Id,String> userMap; 
		global Map<Id,String> userEmailMap;
   
		global msd_ru_batch_updateUsernames()
		{
		userMap = new Map<Id, String>{'005K0000001LqZF' => 'rahul.arora@merck.com.hhusd7rmo', '005U0000000pPuW' => 'sagar.bhattarai@merck.com.hhusd7rmo'};
		userEmailMap = new Map<Id, String>{'005K0000001LqZF' => 'rahul.arora@merck.com', '005U0000000pPuW' => 'sagar.bhattarai@merck.com'};        
		System.debug('@@@@@@ Map set '+userMap.keyset()); 
		String str = null;
			For(id idd : userMap.keySet())
			{
				if(str == null)
				{
					str = '(\''+idd+'\'';
				}
				else
				{
					str = str + ','+'\''+idd+'\'';
				}
          
			}
   		str = str+')';
		System.debug('@@@@@ string '+str);      
		Query='select id,username,email from User where id in '+str;
   		}    

   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(Query);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
    List<User> updateUsers = new List<User>(); 
    for(SObject s1 : scope){
       
        User s = (User)s1;
        System.debug(userMap.get(s.id)+'username @@@@@ Username '+s.username);
        if(!s.username.equalsIgnoreCase(userMap.get(s.id))||!s.email.equalsIgnoreCase(userEmailMap.get(s.id))){
            s.username = userMap.get(s.id);
            s.email = userEmailMap.get(s.id);
           updateUsers.add(s);
        }
        else{
           
        }
        
        
     }
     try{
        if(updateUsers.size() > 0){
             Database.SaveResult[] lsr = database.update(updateUsers);
        }
     }
     Catch(exception e){
     
     }
     
        
    }
    

   global void finish(Database.BatchableContext BC){
   }
}