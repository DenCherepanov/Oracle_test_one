PL/SQL Developer Test script 3.0
88
declare
  -- объявление необходимых для тестирования переменных
  pColl1 pkgtest.tNumTbl;
  pColl2 pkgtest.tNumTbl;
  pColl3 pkgtest.tNumTbl;    
  pRes number;
  pCnt number;
  i pls_integer;
  pRef sys_refcursor;
  pOperName varchar2(50); 
  cursor pGetOperPriority is
    select t.* from system.operation_priority t
    order by t.oper_position;
  pGet pGetOperPriority%rowtype;    
begin
  dbms_output.put_line('Первое задание:');
  -- инициализация коллекции 1
  pColl1(-11) := null;
  pColl1(-5) := null;
  pColl1(-3) := -5;    
  pColl1(2) := -5; 
  -- вызов функции, возвращающей минимальное значение из непустых элементов коллекции
  pRes := pkgtest.get_min(pColl1);
  -- вывод результата
  dbms_output.put_line('Минимальное значение: ' || pRes);
  
  dbms_output.put_line('');
  dbms_output.put_line('Второе задание:');
  -- инициализация коллекции 2  
  pColl2(-5) := 5;
  pColl2(4) := 7;  
  pColl2(6) := -3;
  pColl2(12) := null;
  pColl2(13) := -22;
  -- вызов функции, возвращающей коллекцию уникальных чисел из двух коллекций
  -- включая пустое значение, если таковое встретилось
  pColl3 := pkgtest.get_unique(pColl1, pColl2); 
  -- вывод результата
  dbms_output.put_line('Уникальные числа:');
  i := pColl3.first;
  while (i is not null)
    loop
     dbms_output.put(nvl(to_char(pColl3(i)), 'null') || ', ');      
     i := pColl3.next(i);
    end loop; 
    
  dbms_output.put_line('');
  dbms_output.put_line('');
  dbms_output.put_line('Третье задание:'); 
  dbms_output.put_line('Список основных операций:'); 
  -- вызов функции, возвращающей курсор с наименованиями основных операций
  pRef := pkgtest.get_oper_list;
  loop
    fetch pRef into pOperName;
    exit when pRef%notfound;
    dbms_output.put_line(pOperName);
  end loop;
  close pRef;
  
  dbms_output.put_line(''); 
  dbms_output.put_line('Четвертое задание:');
  dbms_output.put_line('Таблица operation_priority до изменений');
  dbms_output.put_line(lpad('OPER_ID', 15) || lpad('MAIN_POSITION', 15) || 
                       lpad('CHILD_POSITION', 15) || lpad('OPER_POSITION', 15));

  open pGetOperPriority;  
    loop
      fetch pGetOperPriority into pGet;
      exit when pGetOperPriority%notfound;        
      dbms_output.put_line(lpad(to_char(pGet.oper_id), 15) || lpad(to_char(pGet.main_position), 15) || 
                           lpad(to_char(pGet.child_position), 15) || lpad(to_char(pGet.oper_position), 15));
    end loop;  
  close pGetOperPriority;  
  
  -- вызов процедуры, меняющий приоритет у операции
  pkgtest.change_position(2, true);  
  
  dbms_output.put_line('Таблица operation_priority после изменений');  
  open pGetOperPriority;  
    loop
      fetch pGetOperPriority into pGet;
      exit when pGetOperPriority%notfound;        
      dbms_output.put_line(lpad(to_char(pGet.oper_id), 15) || lpad(to_char(pGet.main_position), 15) || 
                           lpad(to_char(pGet.child_position), 15) || lpad(to_char(pGet.oper_position), 15));
    end loop;
  
  close pGetOperPriority;     
end;  
0
17
pIncDec
pID
pMP_1
pCP_1
pOP_1
pTO_1
pCnt_1
pMin_1
pMax_1
pID_2
pMP_2
pCP_2
pOP_2
pTO_2
pCnt_2
pMin_2
pMax_2
