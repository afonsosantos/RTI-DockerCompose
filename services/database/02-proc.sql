DELIMITER $$
CREATE TRIGGER tbi_entrance_logs
    BEFORE INSERT
    ON entrance_logs
    FOR EACH ROW
BEGIN
    DECLARE n_permission_id INTEGER;

    SET NEW.timestamp = UNIX_TIMESTAMP();

    SET n_permission_id = (SELECT permission_id
                                FROM permission
                                WHERE rfid = NEW.rfid);

    IF n_permission_id IS NOT NULL THEN
        SET NEW.access = 1;
    ELSE
        SET NEW.access = 0;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tbi_sensor_logs
    BEFORE INSERT
    ON sensor_logs
    FOR EACH ROW
BEGIN
    SET NEW.timestamp = UNIX_TIMESTAMP();
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tbi_actuator_logs
    BEFORE INSERT
    ON actuator_logs
    FOR EACH ROW
BEGIN
    SET NEW.timestamp = UNIX_TIMESTAMP();
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tbi_users
    BEFORE INSERT
    ON user
    FOR EACH ROW
BEGIN
    SET NEW.password = md5(NEW.password);
END$$
DELIMITER ;

CREATE VIEW entrance_logs_person_view AS
SELECT el.entrance_log_id,
       el.rfid,
       (CASE
           WHEN p.person_id IS NULL THEN 'Desconhecido'
            ELSE CONCAT_WS(' ', p.first_name, p.last_name)
        END) "person_name",
       el.timestamp,
       el.access
FROM entrance_logs el
    LEFT JOIN person p
ON el.rfid  = p.rfid;
/

CREATE VIEW general_stats_view AS
SELECT (SELECT COUNT(1) FROM person) "people_count",
       (SELECT COUNT(1) FROM entrance_logs WHERE access = 1) "successful_entrance_logs",
       (SELECT COUNT(1) FROM entrance_logs WHERE access = 0) "unsuccessful_entrance_logs",
       (SELECT COUNT(1) FROM sensor_logs) "sensor_log_count",
       (SELECT COUNT(1) FROM actuator_logs) "actuator_log_count",
       (SELECT COUNT(1) FROM permission) "permission_count"
FROM dual;
/

CREATE VIEW sensor_log_sensor_view AS
SELECT sl.sensor_log_id,
       s.sensor_id,
       s.name,
       sl.value,
       sl.timestamp
FROM sensor s,
     sensor_logs sl
WHERE s.sensor_id = sl.sensor_id
ORDER BY sl.sensor_log_id DESC;
/

CREATE VIEW actuator_logs_actuator_view AS
SELECT al.actuator_log_id,
       a.actuator_id,
       al.actuator_state,
       a.name,
       al.timestamp
FROM actuator a,
     actuator_logs al
WHERE a.actuator_id = al.actuator_id
ORDER BY al.actuator_log_id DESC;
/