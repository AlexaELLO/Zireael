create or replace trigger genre_tbi
    before insert on t_genres
    for each row
begin
    :new.id := genre_seq.nextval;
end;
/