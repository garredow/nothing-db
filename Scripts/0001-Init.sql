-- Functions

CREATE OR REPLACE FUNCTION trigger_set_timestamp() RETURNS TRIGGER AS
$$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tables

CREATE TABLE IF NOT EXISTS project
(
    id          integer NOT NULL PRIMARY KEY,
    name        varchar(255),
    slug        varchar(255),
    description text,
    github_id   varchar(255),
    circleci_id varchar(255),
    icon_url    varchar(255),
    created_at  timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_at  timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER project_updated_at
    BEFORE UPDATE
    ON project
    FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

