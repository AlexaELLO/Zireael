create or replace trigger author_tbi
    before insert on t_authors
    for each row
begin
    :new.id := genre_seq.nextval;
end;
/