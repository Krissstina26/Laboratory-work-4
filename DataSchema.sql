CREATE TABLE app_user (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL
    CHECK (
        user_name ~ '^[A-Za-zА-Яа-яЇїІіЄєҐґ]{2,}$'
    ),
    user_surname VARCHAR(100) NOT NULL
    CHECK (
        user_surname ~ '^[A-Za-zА-Яа-яЇїІіЄєҐґ]{2,}$'
    ),
    user_status VARCHAR(20)
    CHECK (user_status IN ('online', 'offline'))
);

CREATE TABLE light (
    light_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    light_level INTEGER CHECK (light_level >= 0),
    measured_at TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE SET NULL
);

CREATE TABLE light_alert (
    alert_id SERIAL PRIMARY KEY,
    light_id INTEGER,
    alert_text TEXT NOT NULL,
    alert_date DATE NOT NULL,
    alert_type VARCHAR(50) CHECK (alert_type IN ('інфо', 'попередження')),
    FOREIGN KEY (light_id) REFERENCES light (light_id) ON DELETE CASCADE
);

CREATE TABLE light_history (
    hist_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    light_level INTEGER CHECK (light_level >= 0),
    record_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE CASCADE
);

CREATE TABLE light_recommendation (
    rec_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    rec_text TEXT NOT NULL,
    rec_category VARCHAR(50)
    CHECK (
        rec_category IN ('яскравість', 'положення', 'лампа')
    ),
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE CASCADE
);

CREATE TABLE safety_recommendation (
    srec_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    srec_text TEXT NOT NULL,
    srec_priority SMALLINT CHECK (srec_priority BETWEEN 1 AND 5),
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE CASCADE
);

CREATE TABLE hazard (
    haz_id SERIAL PRIMARY KEY,
    haz_description TEXT NOT NULL,
    risk_level SMALLINT CHECK (risk_level BETWEEN 1 AND 10)
);

CREATE TABLE safety_log (
    log_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    log_event TEXT NOT NULL,
    log_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE CASCADE
);

CREATE TABLE safety_reminder (
    rem_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    rem_text TEXT NOT NULL,
    rem_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE CASCADE
);

CREATE TABLE chat (
    chat_id SERIAL PRIMARY KEY,
    chat_name VARCHAR(200) NOT NULL
);

CREATE TABLE message (
    msg_id SERIAL PRIMARY KEY,
    chat_id INTEGER,
    user_id INTEGER,
    msg_text TEXT NOT NULL,
    sent_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (chat_id) REFERENCES chat (chat_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE SET NULL
);

CREATE TABLE creative_topic (
    topic_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    topic_name VARCHAR(200) NOT NULL,
    topic_category VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES app_user (user_id) ON DELETE CASCADE
);

