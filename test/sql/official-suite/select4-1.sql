-- original: select4.test
-- credit:   http://www.sqlite.org/src/tree?ci=trunk&name=test

CREATE TABLE t1(n int, log int);
  BEGIN
;INSERT INTO t1 VALUES(sub_i,sub_j)
;COMMIT
;SELECT DISTINCT log FROM t1 ORDER BY log
;SELECT DISTINCT log FROM t1
;SELECT n FROM t1 WHERE log=3
;SELECT DISTINCT log FROM t1
    UNION ALL
    SELECT n FROM t1 WHERE log=3
    ORDER BY log
;CREATE TABLE t2 AS
      SELECT DISTINCT log FROM t1
      UNION ALL
      SELECT n FROM t1 WHERE log=3
      ORDER BY log;
    SELECT * FROM t2
;DROP TABLE t2
;CREATE TABLE t2 AS
      SELECT DISTINCT log FROM t1
      UNION ALL
      SELECT n FROM t1 WHERE log=3
      ORDER BY log DESC;
    SELECT * FROM t2
;DROP TABLE t2
;SELECT DISTINCT log FROM t1
    UNION ALL
    SELECT n FROM t1 WHERE log=2
;CREATE TABLE t2 AS 
      SELECT DISTINCT log FROM t1
      UNION ALL
      SELECT n FROM t1 WHERE log=2;
    SELECT * FROM t2
;DROP TABLE t2
;SELECT log FROM t1 WHERE n IN 
        (SELECT DISTINCT log FROM t1 UNION ALL
         SELECT n FROM t1 WHERE log=3)
      ORDER BY log
;SELECT DISTINCT log FROM t1
    UNION
    SELECT n FROM t1 WHERE log=3
    ORDER BY log
;SELECT log FROM t1 WHERE n IN 
        (SELECT DISTINCT log FROM t1 UNION
         SELECT n FROM t1 WHERE log=3)
      ORDER BY log
;SELECT 123 AS x ORDER BY (SELECT x ORDER BY 1)
;SELECT DISTINCT log FROM t1
    EXCEPT
    SELECT n FROM t1 WHERE log=3
    ORDER BY log
;CREATE TABLE t2 AS 
      SELECT DISTINCT log FROM t1
      EXCEPT
      SELECT n FROM t1 WHERE log=3
      ORDER BY log;
    SELECT * FROM t2
;DROP TABLE t2
;CREATE TABLE t2 AS 
      SELECT DISTINCT log FROM t1
      EXCEPT
      SELECT n FROM t1 WHERE log=3
      ORDER BY log DESC;
    SELECT * FROM t2
;DROP TABLE t2
;SELECT log FROM t1 WHERE n IN 
        (SELECT DISTINCT log FROM t1 EXCEPT
         SELECT n FROM t1 WHERE log=3)
      ORDER BY log
;SELECT DISTINCT log FROM t1
    INTERSECT
    SELECT n FROM t1 WHERE log=3
    ORDER BY log
;SELECT DISTINCT log FROM t1
    UNION ALL
    SELECT 6
    INTERSECT
    SELECT n FROM t1 WHERE log=3
    ORDER BY t1.log
;CREATE TABLE t2 AS
      SELECT DISTINCT log FROM t1 UNION ALL SELECT 6
      INTERSECT
      SELECT n FROM t1 WHERE log=3
      ORDER BY log;
    SELECT * FROM t2
;DROP TABLE t2
;CREATE TABLE t2 AS
      SELECT DISTINCT log FROM t1 UNION ALL SELECT 6
      INTERSECT
      SELECT n FROM t1 WHERE log=3
      ORDER BY log DESC;
    SELECT * FROM t2
;DROP TABLE t2
;SELECT log FROM t1 WHERE n IN 
        (SELECT DISTINCT log FROM t1 INTERSECT
         SELECT n FROM t1 WHERE log=3)
      ORDER BY log
;SELECT log, count(*) as cnt FROM t1 GROUP BY log
    UNION
    SELECT log, n FROM t1 WHERE n=7
    ORDER BY cnt, log
;SELECT log, count(*) FROM t1 GROUP BY log
    UNION
    SELECT log, n FROM t1 WHERE n=7
    ORDER BY count(*), log
;SELECT NULL UNION SELECT NULL UNION
    SELECT 1 UNION SELECT 2 AS 'x'
    ORDER BY x
;SELECT NULL UNION ALL SELECT NULL UNION ALL
    SELECT 1 UNION ALL SELECT 2 AS 'x'
    ORDER BY x
;SELECT * FROM (
         SELECT NULL, 1 UNION ALL SELECT NULL, 1
      )
;SELECT DISTINCT * FROM (
         SELECT NULL, 1 UNION ALL SELECT NULL, 1
      )
;SELECT DISTINCT * FROM (
         SELECT 1,2  UNION ALL SELECT 1,2
      )
;SELECT NULL EXCEPT SELECT NULL
;CREATE TABLE t2 AS SELECT log AS 'x', count(*) AS 'y' FROM t1 GROUP BY log;
    SELECT * FROM t2 ORDER BY x
;BEGIN;
    CREATE TABLE t3(a text, b float, c text);
    INSERT INTO t3 VALUES(1, 1.1, '1.1');
    INSERT INTO t3 VALUES(2, 1.10, '1.10');
    INSERT INTO t3 VALUES(3, 1.10, '1.1');
    INSERT INTO t3 VALUES(4, 1.1, '1.10');
    INSERT INTO t3 VALUES(5, 1.2, '1.2');
    INSERT INTO t3 VALUES(6, 1.3, '1.3');
    COMMIT
;SELECT DISTINCT b FROM t3 ORDER BY c
;SELECT DISTINCT c FROM t3 ORDER BY c
;SELECT 0 AS x, 1 AS y
    UNION
    SELECT 2 AS y, -3 AS x
    ORDER BY x LIMIT 1
;SELECT DISTINCT log FROM t1 ORDER BY log
;SELECT DISTINCT log FROM t1 ORDER BY log LIMIT 4
;SELECT DISTINCT log FROM t1 ORDER BY log LIMIT 0
;SELECT DISTINCT log FROM t1 ORDER BY log LIMIT -1
;SELECT DISTINCT log FROM t1 ORDER BY log LIMIT -1 OFFSET 2
;SELECT DISTINCT log FROM t1 ORDER BY log LIMIT 3 OFFSET 2
;SELECT DISTINCT log FROM t1 ORDER BY +log LIMIT 3 OFFSET 20
;SELECT DISTINCT log FROM t1 ORDER BY log LIMIT 0 OFFSET 3
;SELECT DISTINCT max(n), log FROM t1 ORDER BY +log; -- LIMIT 2 OFFSET 1
;CREATE TABLE t13(a,b);
    INSERT INTO t13 VALUES(1,1);
    INSERT INTO t13 VALUES(2,1);
    INSERT INTO t13 VALUES(3,1);
    INSERT INTO t13 VALUES(2,2);
    INSERT INTO t13 VALUES(3,2);
    INSERT INTO t13 VALUES(4,2);
    CREATE INDEX t13ab ON t13(a,b);
    SELECT DISTINCT b from t13 WHERE a IN (1,2,3)
;CREATE TABLE t14(a,b,c);
  INSERT INTO t14 VALUES(1,2,3),(4,5,6);
  SELECT * FROM t14 INTERSECT VALUES(3,2,1),(2,3,1),(1,2,3),(2,1,3)
;SELECT * FROM t14 INTERSECT VALUES(1,2,3)
;SELECT * FROM t14
   UNION VALUES(3,2,1),(2,3,1),(1,2,3),(7,8,9),(4,5,6)
   UNION SELECT * FROM t14 ORDER BY 1, 2, 3
;SELECT * FROM t14
   UNION VALUES(3,2,1)
   UNION SELECT * FROM t14 ORDER BY 1, 2, 3
;SELECT * FROM t14 EXCEPT VALUES(3,2,1),(2,3,1),(1,2,3),(2,1,3)
;SELECT * FROM t14 EXCEPT VALUES(1,2,3)
;SELECT * FROM t14 EXCEPT VALUES(1,2,3) EXCEPT VALUES(4,5,6)
;SELECT * FROM t14 EXCEPT VALUES('a','b','c') EXCEPT VALUES(4,5,6)
;SELECT * FROM t14 UNION ALL VALUES(3,2,1),(2,3,1),(1,2,3),(2,1,3)
;SELECT (VALUES(1),(2),(3),(4))
;SELECT (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4)
;VALUES(1) UNION VALUES(2)
;VALUES(1),(2),(3) EXCEPT VALUES(2)
;VALUES(1),(2),(3) EXCEPT VALUES(1),(3)
;SELECT * FROM (SELECT 123), (SELECT 456) ON likely(0 OR 1) OR 0
;VALUES(1),(2),(3),(4) UNION ALL SELECT 5 LIMIT 99
;VALUES(1),(2),(3),(4) UNION ALL SELECT 5 LIMIT 3;