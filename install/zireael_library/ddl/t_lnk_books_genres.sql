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