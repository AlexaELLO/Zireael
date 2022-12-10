create sequence book_seq
start with 1
increment by 1;

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

create or replace trigger book_tbi
    before insert on t_books
    for each row
begin
    :new.id := book_seq.nextval;
end;
/

create sequence genre_seq
start with 1
increment by 1;

create table t_genres (
    id number(10),
    name varchar2(100) not null,
    constraint genre_pk
);