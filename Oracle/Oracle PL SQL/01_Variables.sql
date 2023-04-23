DECLARE
--Declaring variables

    v_vc2 VARCHAR2(100) := 'ABC';
    v_n NUMBER          := 1.23;
    v_p PLS_INTEGER     := 1.4;
    
BEGIN
    
    DBMS_OUTPUT.PUT_LINE(v_vc2);
    DBMS_OUTPUT.PUT_LINE(v_n);
    DBMS_OUTPUT.PUT_LINE(v_p);
END;