--book table
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

--genre table
create sequence genre_seq
start with 1
increment by 1;

create table t_genres (
    id number(10),
    name varchar2(100) not null,
    constraint genre_pk primary key(id)
);

comment on table t_genres is 'Genre Directory';
comment on column t_genres.id is 'Genre ID';
comment on column t_genres.name is 'Genre name';

create or replace trigger genre_tbi
    before insert on t_genres
    for each row
begin
    :new.id := genre_seq.nextval;
end;
/

--t_publishers
create sequence publisher_seq
start with 1
increment by 1;

create table t_publishers (
    id number(10),
    name varchar2(100) not null,
    constraint publisher_pk primary key(id)
);

alter table t_publishers
    add constraint publisher_uq unique(name);

comment on table t_publishers is 'Publisher table';
comment on column t_publishers.id is 'Publisher ID';
comment on column t_publishers.name is 'Publisher name';

create or replace trigger publisher_tbi
    before insert on t_publishers
    for each row
begin
    :new.id := genre_seq.nextval;
end;
/

--
