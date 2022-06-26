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