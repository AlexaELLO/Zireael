create table t_books
(
    id    number(10),
    name  varchar2(300) not null,
    price number(10)    not null,
    constraint book_pk primary key (id),
    constraint book_name_uq unique (name)
);

comment on table t_books is 'Book table';
comment on column t_books.id is 'Book ID';
comment on column t_books.name is 'Name of the book';
comment on column t_books.name is 'Book price';