begin
    for i in (
        select owner, object_name, object_type
        from all_objects
        where owner = 'ZIREAEL_LIBRARY'
        and object_type in ('TABLE', 'SEQUENCE', 'TRIGGER')
        order by object_type desc
    )
    loop
        if i.object_type = 'TABLE' then
            execute immediate 'drop '|| i.object_type || ' ' || i.object_name ||' cascade constraints purge';
        else
            execute immediate 'drop '|| i.object_type || ' ' || i.object_name;
        end if;
    end loop;
end;
/