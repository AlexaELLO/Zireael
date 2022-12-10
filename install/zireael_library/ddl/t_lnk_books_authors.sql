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