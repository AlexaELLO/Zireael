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