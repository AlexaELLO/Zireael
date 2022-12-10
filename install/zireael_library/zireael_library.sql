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

--t_authors - Author table
create sequence author_seq
start with 1
increment by 1;

create table t_authors (
    id number(10),
    first_name varchar2(100) not null,
    last_name varchar2(100),
    third_name varchar2(100),
    constraint author_pk primary key(id)
);

alter table t_authors
    add constraint name_uq unique(first_name, last_name, third_name);

comment on table t_authors is 'Author table';
comment on column t_authors.id is 'Author ID';
comment on column t_authors.first_name is 'Author''s name';
comment on column t_authors.last_name is 'Author''s last name';
comment on column t_authors.third_name is 'Author''s third name';


create or replace trigger author_tbi
    before insert on t_authors
    for each row
begin
    :new.id := genre_seq.nextval;
end;
/

--t_lnk_books_publishers - Books and publisher link table
create table t_lnk_books_publishers (
    book_id number(10) not null,
    publisher_id number(10) not null
);

alter table t_lnk_books_publishers
    add constraint lnk_book_fk foreign key(book_id)
        references t_books(id);

alter table t_lnk_books_publishers
    add constraint lnk_publisher_fk foreign key(publisher_id)
        references t_publishers(id);

comment on table t_lnk_books_publishers is 'Books and publisher link table';
comment on column t_lnk_books_publishers.book_id is 'Book ID';
comment on column t_lnk_books_publishers.publisher_id is 'Publisher ID';

