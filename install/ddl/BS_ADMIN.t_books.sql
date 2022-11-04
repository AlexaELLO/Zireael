--creating table BS_ADMIN.t_books
create table BS_ADMIN.t_books (
    id number(10),
    name varchar2(300) not null,
    price number(5,2) not null
);

--adding constraint - primary key on attribute "id"
alter table BS_ADMIN.t_books
    add constraint book_pk primary key (id);

--adding constraint - unique on attribute "name"
alter table BS_ADMIN.t_books
    add constraint book_name_uq unique (name);
