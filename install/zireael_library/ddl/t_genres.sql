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