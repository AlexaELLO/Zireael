create procedure put_book_data (p_json in clob)
is
    e_json_data exception;
    type data_books is record (
        first_name t_authors.first_name%type,
        last_name t_authors.last_name%type,
        third_name t_authors.third_name%type,
        publisher t_publishers.name%type,
        genre t_genres.name%type,
        book t_books.name%type,
        price t_books.price%type
    );

    type data_books_nt is table of data_books;

    v_data_books  data_books_nt;
begin
    select jb.first_name,
           jb.last_name,
           jb.third_name,
           jb.publisher,
           jb.genre,
           jb.book,
           jb.price
    bulk collect into v_data_books
    from json_table(p_json, '$.new_books[*]'
        columns(
            nested path '$.author'
                columns(
                    first_name varchar2(100) path '$.first_name',
                    last_name varchar2(100) path '$.first_name',
                    third_name varchar2(100) path '$.third_name'),
            publisher varchar2(100) path '$.publisher',
            genre varchar2(100) path '$.genre',
            book varchar2(300) path '$.book',
            price number(10,2) path '$.price')) jb;

    if v_data_books.count is null then
        raise no_data_found;
    end if;
exception
    when no_data_found then
        raise_application_error(20000, 'Json is empty. ' || p_json || 'Please check data in json.');
end put_book_data;
/