create table if not exists public.currencies
(
        id serial primary key,
        name character varying(255),
        tag character varying(255)
);

create unique index if not exists in_currencies_id on public.currencies using btree
(
        id
);

create unique index if not exists in_currencies_tag on public.currencies using btree
(
        tag
);

create table if not exists public.curr_rates
(
        id int,
        datetime timestamp without time zone,
        curr_id_from int references public.currencies(id),
        curr_id_to int references public.currencies(id),
        val numeric(15,7)
);

create unique index if not exists in_curr_rates_id on public.curr_rates using btree
(
        id
);

create  index if not exists in_curr_rates_curr_id_from on public.curr_rates using btree
(
        curr_id_from
);

create  index if not exists in_curr_rates_curr_id_to on public.curr_rates using btree
(
        curr_id_to
);

