create or replace procedure put_book_data (p_json in clob)
is
    --authors
    type author_rec is record (
        first_name t_authors.first_name%type,
        last_name t_authors.last_name%type,
        third_name t_authors.third_name%type,
        first_name_exists t_authors.first_name%type,
        last_name_exists t_authors.last_name%type);

    type author_nt is table of author_rec;
    v_authors author_nt;

    e_empty_authors exception;
    --authors
begin
    select ja.first_name,
           ja.last_name,
           ja.third_name,
           a.first_name first_name_exists,
           a.last_name last_name_exists
    bulk collect into v_authors
    from json_table(p_json,
        '$.new_books[*].authors'
        columns(
                first_name varchar2(100) path '$.first_name',
                last_name varchar2(100) path '$.last_name',
                third_name varchar2(100) path '$.third_name')) ja
    left join t_authors a
        on ja.first_name = a.first_name
        and ja.last_name = a.last_name;

    if v_authors.count < 0 then
        raise e_empty_authors;
    else
        forall ai in 1..v_authors.count
            if v_authors(ai).first_name_exists is not null and v_authors(ai).last_name_exists is not null then
                dbms_output.put_line('Автор уже есть');
                --raise_application_error(20000, 'Автор с таким именем - "' || v_authors(ai).first_name || ' ' || v_authors(ai).last_name || '" уже существует.');
            else
                if v_authors(ai).third_name is null then
                    insert into t_authors (first_name, last_name)
                    values(v_authors(ai).first_name, v_authors(ai).last_name);
                else
                    insert into t_authors (first_name, last_name, third_name)
                    values(v_authors(ai).first_name, v_authors(ai).last_name, v_authors(ai).third_name);
                end if;
            end if;
    end if;

exception
    when e_empty_authors then
        raise_application_error(20001, 'Данные с авторами не найдены. Json - ' || p_json || 'Пожалуйста проверьте, заполнен ли json необходимыми данными.');
end put_book_data;
/

