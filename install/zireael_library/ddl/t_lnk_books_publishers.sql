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