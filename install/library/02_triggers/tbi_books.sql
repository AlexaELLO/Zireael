create trigger tbi_books
    before insert on t_books
    for each row
begin
    :new.id := seq_books.nextval;
end;
/