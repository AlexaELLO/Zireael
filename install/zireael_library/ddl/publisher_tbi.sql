create or replace trigger publisher_tbi
    before insert on t_publishers
    for each row
begin
    :new.id := genre_seq.nextval;
end;
/