---
title: Databases and SQL
---

## Declarative Programming

In **declarative languages** such as SQL & Prolog:

- A "program" is a description of the desired result.
- The interpreter figures out how to genreate the result.

In **imperative languages** such as Python & Scheme:

- A "program" is a description of computational process.
- The interpreter carries out execution/evaluation rules.

## Databases

Databases hold data in structured tables.

A table is a collection of records, which are rows that have a value for each column.

## Structured Query Language (SQL)

The SQL language is an ANSI and ISO standard, but DBMS's implement custom variants.

- A `select` statement creates a new table, either from scratch or by projecting a table.
- A `create table` statement gives a global name to a table.
- Lots of other statements exist: `analyze`, `delete`, `explain`, `insert`, `replace`, `update`, etc.

### Selecting Value Literals

Selecting literals creates a one-row table.

The `union` of two select statements is a table containing the rows of both of their results.

```sql
select [expression] as [name], [expression] as [name] union
select [expression]          , [expression];
```

The result of a `select` statement is displayed to the user, but not stored.

A `create table` statement gives the result a name.

```sql
create table [name] as [select statement];
```

### Projecting Tables

A `select` statement can specify an input table using a `from` clause.

A subset of the rows of the input table can be selected using a `where` clause.

An ordering over the remaining rows can be declared using an `order by` clause.

```sql
select [columns] from [table] where [condition] order by [order];
```

### Joining Tables

Tow tables A & B joined by a comma to yield all combos of a row from A & a row from B.

Two tables may share a column name; dot expressions and aliases disambiguate column values.

```sql
select [columns] from [table] where [condition] order by [order];
```

[table] is a comma-separated list of table names with optional aliases.

### Aggregation

An aggregate function in the [columns] clause computes a value from a group of rows.

aggregate functions: `max`, `min`, `avg`, `count`, `sum`

### Grouping

Rows in a table can be grouped, and aggregation is performed on each group.

```sql
select [columns] from [table] group by [expression] having [expression];
```

The number of groups is the number of unique values of an expression.
