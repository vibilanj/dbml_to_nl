# DBML to NL
Script that converts DBML to natural language and allows you to quickly generate descriptions of your database schema.

## Example
```
 Table users{
  users_email_address varchar [pk]
  password varchar  
  userRunLevel int
  staff_id int [ref: - staff.staff_id] //optional
  client_id int [ref: - client.client_id] //optional
}
```
The above schema in DBML gets converted to:

```
The Users table contains the following columns:
- 'users_email_address' of type 'varchar' which acts as the primary key
- 'password' of type 'varchar'
- 'userRunLevel' of type 'int'
- 'staff_id' of type 'int' which acts as a foreign key (optional)
- 'client_id' of type 'int' which acts as a foreign key (optional)
```

Alternatively, you can also output the relationships between tables:

```
The staff_id column in the Users table references the staff_id column in the Staff table in a one to one relationship.
The client_id column in the Users table references the client_id column in the Client table in a one to one relationship.
```