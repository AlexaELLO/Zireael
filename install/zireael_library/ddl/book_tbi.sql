create or replace trigger book_tbi
    before insert on t_books
    for each row
begin
    :new.id := book_seq.nextval;
end;
/