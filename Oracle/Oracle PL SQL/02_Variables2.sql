DECLARE
    --characters restrictions
    text VARCHAR2(2)    := 'A';
    numeric NUMBER;
BEGIN
    
    DBMS_OUTPUT.PUT_LINE(text);
    text := text || 'BC';
    
    numeric := 'ABC';
    
END;