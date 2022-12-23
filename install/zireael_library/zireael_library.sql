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

alter table t_books
    add constraint book_uq unique(name);

comment on table t_books is 'Book table';
comment on column t_books.id is 'Book ID';
comment on column t_books.name is 'Name of the book';
comment on column t_books.name is 'Book price';

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

alter table t_genres
    add constraint genre_uq unique(name);

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
    add constraint lnk_book_publisher_fk foreign key(book_id)
        references t_books(id);

alter table t_lnk_books_publishers
    add constraint lnk_publisher_book_fk foreign key(publisher_id)
        references t_publishers(id);

comment on table t_lnk_books_publishers is 'Books and publisher link table';
comment on column t_lnk_books_publishers.book_id is 'Book ID';
comment on column t_lnk_books_publishers.publisher_id is 'Publisher ID';

--t_lnk_books_authors - Books and author link table
create table t_lnk_books_authors (
    book_id number(10) not null,
    author_id number(10) not null
);

alter table t_lnk_books_authors
    add constraint lnk_book_author_fk foreign key(book_id)
        references t_books(id);

alter table t_lnk_books_authors
    add constraint lnk_author_book_fk foreign key(author_id)
        references t_authors(id);

comment on table t_lnk_books_authors is 'Books and author link table';
comment on column t_lnk_books_authors.book_id is 'Book ID';
comment on column t_lnk_books_authors.author_id is 'Author ID';

--t_lnk_books_genres - Books and genre link table
create table t_lnk_books_genres (
    book_id number(10) not null,
    genre_id number(10) not null
);

alter table t_lnk_books_genres
    add constraint lnk_book_genre_fk foreign key(book_id)
        references t_books(id);

alter table t_lnk_books_genres
    add constraint lnk_genre_book_fk foreign key(genre_id)
        references t_genres(id);

comment on table t_lnk_books_genres is 'Books and genre link table';
comment on column t_lnk_books_genres.book_id is 'Book ID';
comment on column t_lnk_books_genres.genre_id is 'Genre ID';

--drop tables, seq, triggers
select owner, object_name, object_type
from all_objects
where owner = 'ZIREAEL_LIBRARY'
and object_type in ('TABLE', 'SEQUENCE', 'TRIGGER')
order by object_type desc;

--drop_objects
begin
    for i in (
        select owner, object_name, object_type
        from all_objects
        where owner = 'ZIREAEL_LIBRARY'
        and object_type in ('TABLE', 'SEQUENCE', 'TRIGGER')
        order by object_type desc
    )
    loop
        if i.object_type = 'TABLE' then
            execute immediate 'drop '|| i.object_type || ' ' || i.object_name ||' cascade constraints purge';
        else
            execute immediate 'drop '|| i.object_type || ' ' || i.object_name;
        end if;
    end loop;
end;
/

begin
    put_book_data('');
end;

select substr('Арсений Тарковский Александрович', instr('Арсений Тарковский Александрович', ' ', 1) + 1, instr('Арсений Тарковский Александрович', ' ', 1, 2) - instr('Арсений Тарковский Александрович', ' ', 1))
from dual;

select si.name
from (
    select 'Арсений Тарковский Александрович' name
    from dual
    union
    select 'Тарковский Геннадий Александрович' name
    from dual
)si
where si.name like '%Алекс%';

select instr('Арсений Тарковский Александрович', ' ', 1, 2) - instr('Арсений Тарковский Александрович', ' ', 1)
from dual;

select length('Арсений Тарковский Александрович') - instr('Арсений Тарковский Александрович', ' ', 1)
from dual;

select *
from json_table('{"new_books":[{"authors":{"first_name":"Дженнифер","last_name":"Линкольн"},"publisher":["Манн","Иванов и Фербер"],"genre":["Анотомия и физиология","Акушерство и гинекология"],"book":"Спроси гинеколога. Все что вы хотели знать о месячных, сексе, предохранении и беременности","price":null}]}',
    '$.new_books[*]'
    columns(
        nested path '$.authors'
        columns(
            first_name varchar2(100) path '$.first_name',
            last_name varchar2(100) path '$.last_name'),
        nested path '$.publisher[*]'
        columns(publisher varchar2(100) path '$'))) jb;

select ja.first_name,
       ja.last_name,
       ja.third_name,
       a.first_name first_name_exists,
       a.last_name last_name_exists
from json_table('{"new_books":[{"authors":{"first_name":"Дженнифер","last_name":"Линкольн","third_name":null},"publisher":["Манн","Иванов и Фербер"],"genre":["Анотомия и физиология","Акушерство и гинекология"],"book":"Спроси гинеколога. Все что вы хотели знать о месячных, сексе, предохранении и беременности","price":null}]}',
    '$.new_books[*].authors'
    columns(
            first_name varchar2(100) path '$.first_name',
            last_name varchar2(100) path '$.last_name',
            third_name varchar2(100) path '$.third_name')) ja
left join t_authors a on ja.first_name = a.first_name and ja.last_name = a.last_name;

select *
from t_authors
    where first_name = 'Дженнифер';


select *
from json_table('{"new_books":[{"authors":{"first_name":"Дженнифер","last_name":"Линкольн"},"publisher":["Манн","Иванов и Фербер"],"genre":["Анотомия и физиология","Акушерство и гинекология"],"book":"Спроси гинеколога. Все что вы хотели знать о месячных, сексе, предохранении и беременности","price":null}]}',
    '$.mew_books[*].publisher' columns(
        publisher varchar2(1300) path '$'
                    ));

SELECT *
FROM JSON_TABLE('["a","b"]', '$'
COLUMNS (
    nested_value_0 VARCHAR2(2) PATH '$'));