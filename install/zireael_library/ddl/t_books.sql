create table t_books (
    id number(10),
    name varchar2(300) not null,
    price number(10,2) not null,
    constraint book_pk primary key (id)
);

comment on table t_books is 'Book table';
comment on column t_books.id is 'Identifier of row';
comment on column t_books.name is 'Name of book';
comment on column t_books.name is 'Price of book';