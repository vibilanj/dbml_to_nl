from pydbml import PyDBML

with open('data.dbml') as f:
    parsed = PyDBML(f)

tables = parsed.tables
refs = parsed.refs
# test_table = tables[0]
# test_ref = refs[0]


def column_desc_constructor(column):
    name = column.name
    type = column.type
    str = f"- '{name}' of type '{type}'"
    if column.pk:
        str += " which acts as the primary key"
    if column.get_refs():
        str += " which acts as a foreign key"
    if column.comment:
        str += f" ({column.comment})"
    return str + "\n"


def table_desc_constructor(table):
    name = table.name.title()
    str = f"The {name} table contains the following columns:\n"

    columns = table.columns
    for i in range(0, len(columns)):
        str += column_desc_constructor(columns[i])

    return str


def tables_desc_constructor(tables):
    str = ""
    for i in range(0, len(tables)):
        str += table_desc_constructor(tables[i])
        str += "\n"
    return str


def output_tables_description(tables, filename):
    out_str = tables_desc_constructor(tables)
    with open(filename, "w") as text_file:
        print(out_str, file=text_file)


# print(tables_desc_constructor(tables))
output_tables_description(tables, "tables.txt")


def type_to_string(type):
    if type == '-':
        return 'one to one'
    elif type == '<':
        return 'one to many'
    else:
        return 'many to one'


def ref_desc_constructor(ref):
    type_str = type_to_string(ref.type)
    left_col = ref.col1[0].name
    left_table = ref.table1.name.title()
    right_col = ref.col2[0].name
    right_table = ref.table2.name.title()
    str = f"The {left_col} column in the {left_table} table references the \
{right_col} column in the {right_table} table in a {type_str} relationship."
    return str


def references_desc_constructor(refs):
    str = ""
    for i in range(0, len(refs)):
        str += ref_desc_constructor(refs[i])
        str += "\n"
    return str


def output_references_description(refs, filename):
    out_str = references_desc_constructor(refs)
    with open(filename, "w") as text_file:
        print(out_str, file=text_file)


# print(references_desc_constructor(refs))
output_references_description(refs, "references.txt")
