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
    image           BLOB NOT NULL,
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
