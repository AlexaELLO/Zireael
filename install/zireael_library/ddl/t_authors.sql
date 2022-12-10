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