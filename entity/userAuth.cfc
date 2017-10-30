component persistent="true" table="USER_AUTH" {
  property name="authid" column="id" fieldtype="id" generator="increment" sqltype="integer" insert="false" update="false";
  property name="user" fieldtype="one-to-one" cfc="user" sqltype="integer" fkcolumn="userid" notnull="true";      
  property name="username" ormtype="string" length="80" notnull="true";    
  property name="password" ormtype="string" length="160" notnull="true";    
  property name="salt" ormtype="string" length="160" notnull="true";    
}