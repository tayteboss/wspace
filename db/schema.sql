
create database wspace;

create table users (
    id serial primary key,
    email text,
    name text,
    digested_password text,
    location text
);

create table logs (
    id serial primary key,
    log text,
    created_at timestamptz,
    weather integer,
    min_temp integer,
    max_temp integer,
    user_id integer
);












