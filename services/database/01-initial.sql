CREATE TABLE user
(
    username VARCHAR(20) NOT NULL,
    password VARCHAR(40) NOT NULL,
    PRIMARY KEY (username)
);

CREATE TABLE person
(
    person_id  INT         NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name  VARCHAR(20) NOT NULL,
    rfid       VARCHAR(20) NOT NULL,
    PRIMARY KEY (person_id),
    UNIQUE (rfid),
    CHECK (LENGTH(rfid) > 0)
);

CREATE TABLE permission
(
    permission_id INT         NOT NULL AUTO_INCREMENT,
    rfid          VARCHAR(20) NOT NULL,
    PRIMARY KEY (permission_id),
    FOREIGN KEY (rfid)
        REFERENCES person (rfid)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    UNIQUE (rfid)
);

CREATE TABLE sensor
(
    sensor_id INT         NOT NULL AUTO_INCREMENT,
    name      VARCHAR(40) NOT NULL,
    PRIMARY KEY (sensor_id),
    UNIQUE (name)
);

CREATE TABLE actuator
(
    actuator_id INT         NOT NULL AUTO_INCREMENT,
    name        VARCHAR(40) NOT NULL,
    PRIMARY KEY (actuator_id),
    UNIQUE (name)
);

CREATE TABLE actuator_logs
(
    actuator_log_id INT NOT NULL AUTO_INCREMENT,
    actuator_id     INT NOT NULL,
    actuator_state  INT NOT NULL,
    timestamp       INT,
    PRIMARY KEY (actuator_log_id),
    FOREIGN KEY (actuator_id)
        REFERENCES actuator (actuator_id)
        ON DELETE CASCADE,
    CHECK ( actuator_state IN (0, 1))
);

CREATE TABLE sensor_logs
(
    sensor_log_id INT NOT NULL AUTO_INCREMENT,
    sensor_id     INT NOT NULL,
    value         VARCHAR(100),
    timestamp     INT(11),
    PRIMARY KEY (sensor_log_id),
    FOREIGN KEY (sensor_id)
        REFERENCES sensor (sensor_id)
        ON DELETE CASCADE
);

CREATE TABLE entrance_logs
(
    entrance_log_id INT         NOT NULL AUTO_INCREMENT,
    rfid            VARCHAR(20) NOT NULL,
    access          TINYINT(1),
    timestamp       INT(11),
    PRIMARY KEY (entrance_log_id)
);


CREATE TABLE entrance_logs_images
(
    entrance_log_id INT  NOT NULL,
    image           VARCHAR(200000) NOT NULL,
    PRIMARY KEY (entrance_log_id),
    FOREIGN KEY (entrance_log_id)
        REFERENCES entrance_logs (entrance_log_id)
        ON DELETE CASCADE
);

CREATE TABLE debug
(
    proc_id      VARCHAR(100) DEFAULT NULL,
    debug_output TEXT,
    line_id      INT(11) NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (line_id)
);

CREATE TABLE events
(
    event_name VARCHAR(100),
    PRIMARY KEY (event_name)
);

CREATE TABLE event_queue
(
    event_queue_id INT NOT NULL AUTO_INCREMENT,
    event_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (event_name) REFERENCES events(event_name),
    PRIMARY KEY (event_queue_id),
    UNIQUE (event_name)
);

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
END;

CREATE TRIGGER tbi_sensor_logs
    BEFORE INSERT
    ON sensor_logs
    FOR EACH ROW
BEGIN
    SET NEW.timestamp = UNIX_TIMESTAMP();
END;

CREATE TRIGGER tbi_actuator_logs
    BEFORE INSERT
    ON actuator_logs
    FOR EACH ROW
BEGIN
    SET NEW.timestamp = UNIX_TIMESTAMP();
END;

CREATE TRIGGER tbi_users
    BEFORE INSERT
    ON user
    FOR EACH ROW
BEGIN
    SET NEW.password = md5(NEW.password);
END;

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

CREATE VIEW general_stats_view AS
SELECT (SELECT COUNT(1) FROM person) "people_count",
       (SELECT COUNT(1) FROM entrance_logs WHERE access = 1) "successful_entrance_logs",
       (SELECT COUNT(1) FROM entrance_logs WHERE access = 0) "unsuccessful_entrance_logs",
       (SELECT COUNT(1) FROM sensor_logs) "sensor_log_count",
       (SELECT COUNT(1) FROM actuator_logs) "actuator_log_count",
       (SELECT COUNT(1) FROM permission) "permission_count"
FROM dual;

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

INSERT INTO sensor (sensor_id, name) VALUES (1, 'Sensor de Temperatura');
INSERT INTO sensor (sensor_id, name) VALUES (2, 'Sensor de Humidade');
INSERT INTO sensor (sensor_id, name) VALUES (3, 'Sensor de Fumo');
INSERT INTO sensor (sensor_id, name) VALUES (4, 'Sensor de Movimento');
INSERT INTO sensor (sensor_id, name) VALUES (5, 'Leitor RFID');

INSERT INTO actuator (actuator_id, name) VALUES (1, 'Porta (Frente)');
INSERT INTO actuator (actuator_id, name) VALUES (2, 'Porta (Lateral)');
INSERT INTO actuator (actuator_id, name) VALUES (3, 'Portão (Garagem)');
INSERT INTO actuator (actuator_id, name) VALUES (4, 'Buzzer');
INSERT INTO actuator (actuator_id, name) VALUES (5, 'Alarme');
INSERT INTO actuator (actuator_id, name) VALUES (6, 'Ecrã LCD');
INSERT INTO actuator (actuator_id, name) VALUES (7, 'Sprinkler Teto');
INSERT INTO actuator (actuator_id, name) VALUES (8, 'Luzes');

COMMIT;

INSERT INTO user (username, password)
    VALUES ('admin', 'admin');

INSERT INTO user (username, password)
    VALUES ('dev', 'dev');

INSERT INTO user (username, password)
    VALUES ('iot', 'iot');

COMMIT;

INSERT INTO events (event_name) VALUES ('OPEN_DOORS');
INSERT INTO events (event_name) VALUES ('CLOSE_SESSION');
INSERT INTO events (event_name) VALUES ('TOGGLE_LIGHTS');

COMMIT;

INSERT INTO person(first_name, last_name, rfid) VALUES('Vitor', 'Carlos', 1004);
INSERT INTO person(first_name, last_name, rfid) VALUES('Micael', 'Santos', 123345678);
INSERT INTO person(first_name, last_name, rfid) VALUES('Maria', 'Santos', 134);

INSERT INTO permission(rfid) VALUES (1004);
INSERT INTO permission(rfid) VALUES (134);

INSERT INTO entrance_logs(rfid) VALUES (1004);
INSERT INTO entrance_logs(rfid) VALUES (134);

COMMIT;