import sqlparse

raw_sample = '''
CREATE TABLE `users` (
  `users_email_address` varchar(255) PRIMARY KEY,
  `password` varchar(255),
  `userRunLevel` int,
  `isStaff` bit,
  `staff_id` int,
  `client_id` int
);
'''

parsed = sqlparse.parse(raw_sample)[0]

parsed_type = parsed.get_type()
parsed_tokens = parsed.tokens
parsed_tokens[0]

# no whitespaces
identifiers = sqlparse.sql.IdentifierList(parsed_tokens).get_identifiers()
id_list = []
for id in identifiers:
    id_list.append(id)

# columns
cols = sqlparse.sql.Parenthesis(id_list[3])
col_ids = []
for id in sqlparse.sql.IdentifierList(cols).get_identifiers():
    col_ids.append(id)

# print(col_ids)

cleaned_sample = raw_sample.replace("\n", "")
cleaned_sample = cleaned_sample.replace(" ", "")
toks = sqlparse.parse(cleaned_sample)[0].tokens
cols = sqlparse.sql.Parenthesis(sqlparse.parse(raw_sample.replace("\n", ""))[0].tokens[6])
col_id = []
for col in cols:
    if str(col) != ' ':
        col_id.append(col)

# given a create statement, returns what it does in natural language
# template = f'''
# The {table_name} table is created containing the following columns:
# - {col_1_name} of type {col_1_type} which acts as the Primary Key
# - {col_2_name} of type {col_2_type}
# ...
# '''