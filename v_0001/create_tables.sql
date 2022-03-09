create table if not exists organization.job_function
(
    id           uuid                     default uuid_generate_v4() not null
        constraint job_function_pk
            primary key,
    name         varchar(50)                                         not null,
    level        smallint                 default 32767              not null,
    color        varchar(6),
    created_date timestamp with time zone default CURRENT_TIMESTAMP  not null,
    created_by   varchar(25)                                         not null,
    updated_date timestamp with time zone default CURRENT_TIMESTAMP  not null,
    updated_by   varchar(25)                                         not null,
    active       bool                     default true               not null,
    is_deleted   bool                     default false              not null
);

drop trigger if exists job_function_on_update ON organization.job_function;
create trigger job_function_on_update
    before update
    on organization.job_function
    for each row
    execute procedure public.auto_updated_date();

-------------------------------------------------------------------------------------

create table if not exists organization.job_title
(
    id                  uuid                     default uuid_generate_v4() not null
        constraint job_title_pk
            primary key,
    job_function_id     uuid                                                not null,
    name                varchar(50)                                         not null,
    created_date        timestamp with time zone default CURRENT_TIMESTAMP  not null,
    created_by          varchar(25)                                         not null,
    updated_date        timestamp with time zone default CURRENT_TIMESTAMP  not null,
    updated_by          varchar(25)                                         not null,
    active              bool                     default true               not null,
    is_deleted          bool                     default false              not null
);

alter table organization.job_title
    add constraint job_title_job_function_id_fk
        foreign key (job_function_id) references organization.job_function
            on delete cascade;

drop trigger if exists job_title_on_update ON organization.job_title;
create trigger job_title_on_update
    before update
    on organization.job_title
    for each row
    execute procedure public.auto_updated_date();

-------------------------------------------------------------------------------------

create table if not exists organization.team
(
    id                  uuid                     default uuid_generate_v4() not null
        constraint team_pk
            primary key,
    name                varchar(50)                                         not null,
    color               varchar(6),
    created_date        timestamp with time zone default CURRENT_TIMESTAMP  not null,
    created_by          varchar(25)                                         not null,
    updated_date        timestamp with time zone default CURRENT_TIMESTAMP  not null,
    updated_by          varchar(25)                                         not null,
    active              bool                     default true               not null,
    is_deleted          bool                     default false              not null
);

drop trigger if exists team_on_update ON organization.team;
create trigger team_on_update
    before update
    on organization.team
    for each row
    execute procedure public.auto_updated_date();

-------------------------------------------------------------------------------------

create table organization.hierarchy
(
    id              uuid        default uuid_generate_v4()
        constraint hierarchy_pk
            primary key,
    job_title_id    uuid                                  not null,
    report_to       uuid,
    employee_id     varchar(25),
    team_id         uuid,
    created_date    timestamptz default current_timestamp not null,
    created_by      varchar(25)                           not null,
    updated_date    timestamptz default current_timestamp not null,
    updated_by      varchar(25)                           not null,
    active          bool        default true              not null,
    is_deleted      bool        default false             not null
);

alter table organization.hierarchy
    add constraint hierarchy_hierarchy_id_fk
        foreign key (report_to) references organization.hierarchy
            on delete cascade;

alter table organization.hierarchy
    add constraint hierarchy_job_title_id_fk
        foreign key (job_title_id) references organization.job_title
            on delete cascade;

drop trigger if exists hierarchy_on_update ON organization.hierarchy;
create trigger hierarchy_on_update
    before update
    on organization.hierarchy
    for each row
    execute procedure public.auto_updated_date();

-------------------------------------------------------------------------------------
