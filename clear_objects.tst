PL/SQL Developer Test script 3.0
24
declare 
  pCnt integer;
begin
  -- удаление таблиц system.operation, system.operation_priority и пакета system.pkgtest  
  begin
    select count(*) into pCnt from dba_procedures where object_type = 'PACKAGE' and object_name = 'PKGTEST' and subprogram_id = 0;
    if pCnt = 1 then 
      execute immediate 'drop package system.pkgtest';
      dbms_output.put_line('Пакет system.pkgtest удален.');
    end if; 
    
    select count(*) into pCnt from all_tables where table_name = 'OPERATION_PRIORITY' and owner = 'SYSTEM';
    if pCnt = 1 then 
      execute immediate 'drop table system.operation_priority';
      dbms_output.put_line('Таблица system.operation_priority удалена.');
    end if; 
      
    select count(*) into pCnt from all_tables where table_name = 'OPERATION' and owner = 'SYSTEM';
    if pCnt = 1 then 
      execute immediate 'drop table system.operation';
      dbms_output.put_line('Таблица system.operation удалена.');
    end if;   
  end;   
end;
0
0
