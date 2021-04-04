DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS exam;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS person_address;
DROP TABLE IF EXISTS school;
DROP TABLE IF EXISTS school_address;


CREATE TABLE address (
    address_id  SERIAL,
    region      VARCHAR(255),
    area        VARCHAR(255),
    territory   VARCHAR(255),
    type_terr   VARCHAR(50)
);

ALTER TABLE address ADD CONSTRAINT address_pk PRIMARY KEY ( address_id );

CREATE TABLE exam (
    person_id      VARCHAR(50) NOT NULL,
    year_test      INTEGER NOT NULL,
    school_name    VARCHAR(255) NOT NULL,
    object_name    VARCHAR(255) NOT NULL,
    object_status  VARCHAR(255),
    ball           INTEGER,
    ball_12        INTEGER,
    ball_100       INTEGER,
    dpa_level      VARCHAR(255),
    adapt_scale    VARCHAR(10),
    test_lang      VARCHAR(255)
);

ALTER TABLE exam
    ADD CONSTRAINT exam_pk PRIMARY KEY ( person_id,
                                         year_test,
                                         object_name );

CREATE TABLE person (
    person_id     VARCHAR(50) NOT NULL,
    birth         INTEGER,
    gender        VARCHAR(50),
    type_person   VARCHAR(255),
    profile      VARCHAR(255),
    class_lang  VARCHAR(255)
);

ALTER TABLE person ADD CONSTRAINT person_pk PRIMARY KEY ( person_id );

CREATE TABLE person_address (
    person_id  VARCHAR(50) NOT NULL,
    address_id  INTEGER NOT NULL
);

CREATE UNIQUE INDEX person_address__idx ON
    person_address (
        person_id
    ASC );

ALTER TABLE person_address ADD CONSTRAINT person_address_pk PRIMARY KEY ( person_id,
                                                                          address_id );

CREATE TABLE school (
    school_name  VARCHAR(255) NOT NULL,
    type         VARCHAR(255),
    parent       VARCHAR(255)
);

ALTER TABLE school ADD CONSTRAINT school_pk PRIMARY KEY ( school_name );

CREATE TABLE school_address (
    school_name  VARCHAR(255) NOT NULL,
    address_id   INTEGER NOT NULL
);

CREATE UNIQUE INDEX school_address__idx ON
    school_address (
        school_name
    ASC );

ALTER TABLE school_address ADD CONSTRAINT school_address_pk PRIMARY KEY ( school_name,
                                                                          address_id );

ALTER TABLE exam
    ADD CONSTRAINT exam_person_fk FOREIGN KEY ( person_id )
        REFERENCES person ( person_id );

ALTER TABLE exam
    ADD CONSTRAINT exam_school_fk FOREIGN KEY ( school_name )
        REFERENCES school ( school_name );

ALTER TABLE person_address
    ADD CONSTRAINT person_address_address_fk FOREIGN KEY ( address_id )
        REFERENCES address ( address_id );

ALTER TABLE person_address
    ADD CONSTRAINT person_address_person_fk FOREIGN KEY ( person_id )
        REFERENCES person ( person_id );

ALTER TABLE school_address
    ADD CONSTRAINT school_address_address_fk FOREIGN KEY ( address_id )
        REFERENCES address ( address_id );

ALTER TABLE school_address
    ADD CONSTRAINT school_address_school_fk FOREIGN KEY ( school_name )
        REFERENCES school ( school_name );