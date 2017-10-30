component persistent="true" table="USER" {
  property name="userid" column="id" fieldtype="id" generator="increment" sqltype="integer";
  property name="firstname" column="fName" length="30" notnull="true" ormtype="string";     
  property name="lastname" column="lName" length="30" notnull="true" ormtype="string";     
}