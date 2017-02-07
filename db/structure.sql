--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: artist_credits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE artist_credits (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    source_id integer
);


--
-- Name: artist_credits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE artist_credits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artist_credits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE artist_credits_id_seq OWNED BY artist_credits.id;


--
-- Name: artist_credits_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE artist_credits_tags (
    artist_credit_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: artist_identifiers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE artist_identifiers (
    id integer NOT NULL,
    source_id integer NOT NULL,
    value text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: artist_identifiers_artists; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE artist_identifiers_artists (
    artist_identifier_id integer NOT NULL,
    artist_id integer NOT NULL
);


--
-- Name: artist_identifiers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE artist_identifiers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artist_identifiers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE artist_identifiers_id_seq OWNED BY artist_identifiers.id;


--
-- Name: artists; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE artists (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    artist_identifier_id integer,
    name citext NOT NULL,
    disambiguation citext,
    begin_date date,
    begin_date_mask smallint,
    end_date date,
    end_date_mask smallint,
    sort_name citext
);


--
-- Name: artists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE artists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE artists_id_seq OWNED BY artists.id;


--
-- Name: artists_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE artists_tags (
    artist_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: ch_companies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ch_companies (
    id integer NOT NULL,
    compilation_head_id integer NOT NULL,
    company_id integer NOT NULL,
    company_role_id integer NOT NULL,
    catalog_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ch_companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ch_companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ch_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ch_companies_id_seq OWNED BY ch_companies.id;


--
-- Name: ch_credits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ch_credits (
    id integer NOT NULL,
    artist_credit_id integer NOT NULL,
    compilation_head_id integer NOT NULL,
    job_id integer,
    role character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ch_credits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ch_credits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ch_credits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ch_credits_id_seq OWNED BY ch_credits.id;


--
-- Name: ch_labels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ch_labels (
    id integer NOT NULL,
    compilation_head_id integer NOT NULL,
    company_id integer NOT NULL,
    catalog_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ch_labels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ch_labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ch_labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ch_labels_id_seq OWNED BY ch_labels.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    text text NOT NULL,
    user_id integer NOT NULL,
    artist_credit_id integer,
    artist_id integer,
    compilation_head_id integer,
    compilation_release_id integer,
    piece_head_id integer,
    piece_release_id integer,
    repository_id integer,
    season_id integer,
    serial_id integer,
    station_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT exact_one_content_on_comments CHECK (((((((((((((artist_credit_id IS NOT NULL))::integer + ((artist_id IS NOT NULL))::integer) + ((compilation_head_id IS NOT NULL))::integer) + ((compilation_release_id IS NOT NULL))::integer) + ((piece_head_id IS NOT NULL))::integer) + ((piece_release_id IS NOT NULL))::integer) + ((repository_id IS NOT NULL))::integer) + ((season_id IS NOT NULL))::integer) + ((serial_id IS NOT NULL))::integer) + ((station_id IS NOT NULL))::integer) = 1))
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE companies (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE companies_id_seq OWNED BY companies.id;


--
-- Name: company_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE company_roles (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: company_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE company_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE company_roles_id_seq OWNED BY company_roles.id;


--
-- Name: compilation_copies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE compilation_copies (
    id integer NOT NULL,
    compilation_release_id integer NOT NULL,
    user_id integer NOT NULL,
    note text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: compilation_copies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE compilation_copies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: compilation_copies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE compilation_copies_id_seq OWNED BY compilation_copies.id;


--
-- Name: compilation_heads; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE compilation_heads (
    id integer NOT NULL,
    artist_credit_id integer,
    title character varying NOT NULL,
    disambiguation character varying,
    type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    source_ident character varying,
    source_id integer
);


--
-- Name: compilation_heads_countries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE compilation_heads_countries (
    country_id integer NOT NULL,
    compilation_head_id integer NOT NULL
);


--
-- Name: compilation_heads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE compilation_heads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: compilation_heads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE compilation_heads_id_seq OWNED BY compilation_heads.id;


--
-- Name: compilation_heads_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE compilation_heads_tags (
    compilation_head_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: compilation_identifiers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE compilation_identifiers (
    id integer NOT NULL,
    compilation_release_id integer NOT NULL,
    identifier_type_id integer NOT NULL,
    code character varying NOT NULL,
    disambiguation character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: compilation_identifiers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE compilation_identifiers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: compilation_identifiers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE compilation_identifiers_id_seq OWNED BY compilation_identifiers.id;


--
-- Name: compilation_releases; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE compilation_releases (
    id integer NOT NULL,
    compilation_head_id integer NOT NULL,
    version character varying,
    type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    date date,
    source_ident character varying,
    source_id integer,
    date_mask smallint
);


--
-- Name: compilation_releases_countries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE compilation_releases_countries (
    compilation_release_id integer NOT NULL,
    country_id integer NOT NULL
);


--
-- Name: compilation_releases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE compilation_releases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: compilation_releases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE compilation_releases_id_seq OWNED BY compilation_releases.id;


--
-- Name: compilation_releases_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE compilation_releases_tags (
    compilation_release_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: compilation_track_details; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE compilation_track_details (
    id integer NOT NULL,
    track_id integer NOT NULL,
    trf_attribute_kind_id integer NOT NULL,
    "position" integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: compilation_track_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE compilation_track_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: compilation_track_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE compilation_track_details_id_seq OWNED BY compilation_track_details.id;


--
-- Name: compilation_tracks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE compilation_tracks (
    id integer NOT NULL,
    piece_release_id integer NOT NULL,
    "position" integer,
    path character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    compilation_release_id integer,
    location character varying,
    heading character varying,
    milliseconds integer,
    accuracy character varying,
    side character varying,
    format_id integer
);


--
-- Name: compilation_tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE compilation_tracks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: compilation_tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE compilation_tracks_id_seq OWNED BY compilation_tracks.id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE countries (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE countries_id_seq OWNED BY countries.id;


--
-- Name: countries_piece_heads; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE countries_piece_heads (
    id integer NOT NULL,
    country_id integer NOT NULL,
    piece_head_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: countries_piece_heads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE countries_piece_heads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: countries_piece_heads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE countries_piece_heads_id_seq OWNED BY countries_piece_heads.id;


--
-- Name: countries_piece_releases; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE countries_piece_releases (
    country_id integer NOT NULL,
    piece_release_id integer NOT NULL
);


--
-- Name: cr_companies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cr_companies (
    id integer NOT NULL,
    company_id integer NOT NULL,
    company_role_id integer NOT NULL,
    catalog_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    compilation_release_id integer NOT NULL
);


--
-- Name: cr_companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cr_companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cr_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cr_companies_id_seq OWNED BY cr_companies.id;


--
-- Name: cr_credits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cr_credits (
    id integer NOT NULL,
    artist_credit_id integer NOT NULL,
    compilation_release_id integer NOT NULL,
    job_id integer,
    role character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: cr_credits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cr_credits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cr_credits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cr_credits_id_seq OWNED BY cr_credits.id;


--
-- Name: cr_format_details; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cr_format_details (
    id integer NOT NULL,
    cr_format_id integer NOT NULL,
    "position" integer NOT NULL,
    format_detail_id integer
);


--
-- Name: cr_format_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cr_format_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cr_format_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cr_format_details_id_seq OWNED BY cr_format_details.id;


--
-- Name: cr_formats; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cr_formats (
    id integer NOT NULL,
    compilation_release_id integer NOT NULL,
    "position" integer NOT NULL,
    quantity integer NOT NULL,
    note text,
    format_id integer
);


--
-- Name: cr_formats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cr_formats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cr_formats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cr_formats_id_seq OWNED BY cr_formats.id;


--
-- Name: cr_labels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cr_labels (
    id integer NOT NULL,
    compilation_release_id integer NOT NULL,
    company_id integer NOT NULL,
    catalog_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: cr_labels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cr_labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cr_labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cr_labels_id_seq OWNED BY cr_labels.id;


--
-- Name: ct_format_details; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ct_format_details (
    id integer NOT NULL,
    compilation_track_id integer NOT NULL,
    "position" integer NOT NULL,
    format_detail_id integer
);


--
-- Name: ct_format_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ct_format_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ct_format_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ct_format_details_id_seq OWNED BY ct_format_details.id;


--
-- Name: descriptions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE descriptions (
    id integer NOT NULL,
    text text NOT NULL,
    user_id integer,
    source_id integer,
    artist_credit_id integer,
    artist_id integer,
    compilation_head_id integer,
    compilation_release_id integer,
    country_id integer,
    piece_head_id integer,
    piece_release_id integer,
    season_id integer,
    serial_id integer,
    station_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT exact_one_content_on_descriptions CHECK (((((((((((((((user_id IS NOT NULL))::integer + ((source_id IS NOT NULL))::integer) + ((artist_credit_id IS NOT NULL))::integer) + ((artist_id IS NOT NULL))::integer) + ((compilation_head_id IS NOT NULL))::integer) + ((compilation_release_id IS NOT NULL))::integer) + ((country_id IS NOT NULL))::integer) + ((piece_head_id IS NOT NULL))::integer) + ((piece_release_id IS NOT NULL))::integer) + ((season_id IS NOT NULL))::integer) + ((serial_id IS NOT NULL))::integer) + ((station_id IS NOT NULL))::integer) = 1))
);


--
-- Name: descriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE descriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: descriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE descriptions_id_seq OWNED BY descriptions.id;


--
-- Name: format_details; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE format_details (
    name text NOT NULL,
    abbr text,
    id integer NOT NULL
);


--
-- Name: format_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE format_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: format_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE format_details_id_seq OWNED BY format_details.id;


--
-- Name: formats; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE formats (
    name text NOT NULL,
    abbr text,
    id integer NOT NULL
);


--
-- Name: formats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE formats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: formats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE formats_id_seq OWNED BY formats.id;


--
-- Name: identifier_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE identifier_types (
    id integer NOT NULL,
    name character varying NOT NULL,
    note character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: identifier_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE identifier_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: identifier_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE identifier_types_id_seq OWNED BY identifier_types.id;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE jobs (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE jobs_id_seq OWNED BY jobs.id;


--
-- Name: original_exemplars; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE original_exemplars (
    id integer NOT NULL,
    compilation_release_id integer NOT NULL,
    user_id integer NOT NULL,
    disambiguation text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: original_exemplars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE original_exemplars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: original_exemplars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE original_exemplars_id_seq OWNED BY original_exemplars.id;


--
-- Name: participants; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE participants (
    id integer NOT NULL,
    "position" integer NOT NULL,
    join_phrase character varying,
    artist_id integer NOT NULL,
    artist_credit_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: participants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE participants_id_seq OWNED BY participants.id;


--
-- Name: ph_companies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ph_companies (
    id integer NOT NULL,
    piece_head_id integer NOT NULL,
    company_id integer NOT NULL,
    company_role_id integer NOT NULL,
    catalog_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ph_companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ph_companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ph_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ph_companies_id_seq OWNED BY ph_companies.id;


--
-- Name: ph_credits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ph_credits (
    id integer NOT NULL,
    artist_credit_id integer NOT NULL,
    piece_head_id integer NOT NULL,
    job_id integer,
    role character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ph_credits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ph_credits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ph_credits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ph_credits_id_seq OWNED BY ph_credits.id;


--
-- Name: ph_labels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ph_labels (
    id integer NOT NULL,
    piece_head_id integer NOT NULL,
    company_id integer NOT NULL,
    catalog_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ph_labels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ph_labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ph_labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ph_labels_id_seq OWNED BY ph_labels.id;


--
-- Name: piece_heads; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE piece_heads (
    id integer NOT NULL,
    artist_credit_id integer,
    season_id integer,
    title character varying NOT NULL,
    disambiguation character varying,
    "position" integer,
    type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    source_ident character varying,
    source_id integer
);


--
-- Name: piece_heads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE piece_heads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: piece_heads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE piece_heads_id_seq OWNED BY piece_heads.id;


--
-- Name: piece_heads_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE piece_heads_tags (
    piece_head_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: piece_releases; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE piece_releases (
    id integer NOT NULL,
    piece_head_id integer NOT NULL,
    station_id integer,
    version character varying,
    type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    date date,
    source_ident character varying,
    source_id integer,
    date_mask smallint
);


--
-- Name: piece_releases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE piece_releases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: piece_releases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE piece_releases_id_seq OWNED BY piece_releases.id;


--
-- Name: piece_releases_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE piece_releases_tags (
    piece_release_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: piece_tracks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE piece_tracks (
    id integer NOT NULL,
    piece_release_id integer NOT NULL,
    tr_format_kind_id integer,
    milliseconds integer,
    accuracy text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: piece_tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE piece_tracks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: piece_tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE piece_tracks_id_seq OWNED BY piece_tracks.id;


--
-- Name: pr_companies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pr_companies (
    id integer NOT NULL,
    piece_release_id integer NOT NULL,
    company_id integer NOT NULL,
    company_role_id integer NOT NULL,
    catalog_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pr_companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pr_companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pr_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pr_companies_id_seq OWNED BY pr_companies.id;


--
-- Name: pr_credits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pr_credits (
    id integer NOT NULL,
    artist_credit_id integer NOT NULL,
    piece_release_id integer NOT NULL,
    job_id integer,
    role character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pr_credits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pr_credits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pr_credits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pr_credits_id_seq OWNED BY pr_credits.id;


--
-- Name: pr_labels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pr_labels (
    id integer NOT NULL,
    piece_release_id integer NOT NULL,
    company_id integer NOT NULL,
    catalog_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pr_labels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pr_labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pr_labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pr_labels_id_seq OWNED BY pr_labels.id;


--
-- Name: ratings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ratings (
    id integer NOT NULL,
    value smallint NOT NULL,
    user_id integer NOT NULL,
    artist_credit_id integer,
    artist_id integer,
    compilation_head_id integer,
    compilation_release_id integer,
    piece_head_id integer,
    piece_release_id integer,
    season_id integer,
    serial_id integer,
    station_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT exact_one_content_on_ratings CHECK ((((((((((((artist_credit_id IS NOT NULL))::integer + ((artist_id IS NOT NULL))::integer) + ((compilation_head_id IS NOT NULL))::integer) + ((compilation_release_id IS NOT NULL))::integer) + ((piece_head_id IS NOT NULL))::integer) + ((piece_release_id IS NOT NULL))::integer) + ((season_id IS NOT NULL))::integer) + ((serial_id IS NOT NULL))::integer) + ((station_id IS NOT NULL))::integer) = 1)),
    CONSTRAINT ratings_value_between_0_and_10 CHECK (((value >= 0) AND (value <= 10)))
);


--
-- Name: ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ratings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ratings_id_seq OWNED BY ratings.id;


--
-- Name: repositories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE repositories (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    format_id integer
);


--
-- Name: repositories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE repositories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: repositories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE repositories_id_seq OWNED BY repositories.id;


--
-- Name: repository_format_details; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE repository_format_details (
    id integer NOT NULL,
    repository_id integer NOT NULL,
    "position" integer NOT NULL,
    format_detail_id integer
);


--
-- Name: repository_format_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE repository_format_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: repository_format_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE repository_format_details_id_seq OWNED BY repository_format_details.id;


--
-- Name: repository_positions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE repository_positions (
    id integer NOT NULL,
    compilation_track_id integer,
    compilation_release_id integer,
    piece_release_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    repository_id integer NOT NULL,
    user_id integer NOT NULL,
    compilation_copy_id integer,
    piece_track_id integer,
    CONSTRAINT only_one_track_type CHECK (((((compilation_track_id IS NOT NULL))::integer + ((piece_track_id IS NOT NULL))::integer) <= 1))
);


--
-- Name: repository_positions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE repository_positions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: repository_positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE repository_positions_id_seq OWNED BY repository_positions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: seasons; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE seasons (
    id integer NOT NULL,
    serial_id integer NOT NULL,
    "position" integer NOT NULL,
    title character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: seasons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE seasons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seasons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE seasons_id_seq OWNED BY seasons.id;


--
-- Name: seasons_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE seasons_tags (
    season_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: serials; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE serials (
    id integer NOT NULL,
    title character varying NOT NULL,
    disambiguation character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    type character varying NOT NULL
);


--
-- Name: serials_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE serials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: serials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE serials_id_seq OWNED BY serials.id;


--
-- Name: serials_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE serials_tags (
    serial_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: sources; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sources (
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: sources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sources_id_seq OWNED BY sources.id;


--
-- Name: stations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stations (
    id integer NOT NULL,
    name character varying NOT NULL,
    disambiguation character varying,
    type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: stations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stations_id_seq OWNED BY stations.id;


--
-- Name: stations_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stations_tags (
    station_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name text NOT NULL,
    note text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY artist_credits ALTER COLUMN id SET DEFAULT nextval('artist_credits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY artist_identifiers ALTER COLUMN id SET DEFAULT nextval('artist_identifiers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY artists ALTER COLUMN id SET DEFAULT nextval('artists_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ch_companies ALTER COLUMN id SET DEFAULT nextval('ch_companies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ch_credits ALTER COLUMN id SET DEFAULT nextval('ch_credits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ch_labels ALTER COLUMN id SET DEFAULT nextval('ch_labels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY companies ALTER COLUMN id SET DEFAULT nextval('companies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY company_roles ALTER COLUMN id SET DEFAULT nextval('company_roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_copies ALTER COLUMN id SET DEFAULT nextval('compilation_copies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_heads ALTER COLUMN id SET DEFAULT nextval('compilation_heads_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_identifiers ALTER COLUMN id SET DEFAULT nextval('compilation_identifiers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_releases ALTER COLUMN id SET DEFAULT nextval('compilation_releases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_track_details ALTER COLUMN id SET DEFAULT nextval('compilation_track_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_tracks ALTER COLUMN id SET DEFAULT nextval('compilation_tracks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY countries ALTER COLUMN id SET DEFAULT nextval('countries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY countries_piece_heads ALTER COLUMN id SET DEFAULT nextval('countries_piece_heads_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_companies ALTER COLUMN id SET DEFAULT nextval('cr_companies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_credits ALTER COLUMN id SET DEFAULT nextval('cr_credits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_format_details ALTER COLUMN id SET DEFAULT nextval('cr_format_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_formats ALTER COLUMN id SET DEFAULT nextval('cr_formats_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_labels ALTER COLUMN id SET DEFAULT nextval('cr_labels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ct_format_details ALTER COLUMN id SET DEFAULT nextval('ct_format_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions ALTER COLUMN id SET DEFAULT nextval('descriptions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY format_details ALTER COLUMN id SET DEFAULT nextval('format_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY formats ALTER COLUMN id SET DEFAULT nextval('formats_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY identifier_types ALTER COLUMN id SET DEFAULT nextval('identifier_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY jobs ALTER COLUMN id SET DEFAULT nextval('jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY original_exemplars ALTER COLUMN id SET DEFAULT nextval('original_exemplars_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY participants ALTER COLUMN id SET DEFAULT nextval('participants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ph_companies ALTER COLUMN id SET DEFAULT nextval('ph_companies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ph_credits ALTER COLUMN id SET DEFAULT nextval('ph_credits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ph_labels ALTER COLUMN id SET DEFAULT nextval('ph_labels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_heads ALTER COLUMN id SET DEFAULT nextval('piece_heads_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_releases ALTER COLUMN id SET DEFAULT nextval('piece_releases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_tracks ALTER COLUMN id SET DEFAULT nextval('piece_tracks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pr_companies ALTER COLUMN id SET DEFAULT nextval('pr_companies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pr_credits ALTER COLUMN id SET DEFAULT nextval('pr_credits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pr_labels ALTER COLUMN id SET DEFAULT nextval('pr_labels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings ALTER COLUMN id SET DEFAULT nextval('ratings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY repositories ALTER COLUMN id SET DEFAULT nextval('repositories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY repository_format_details ALTER COLUMN id SET DEFAULT nextval('repository_format_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY repository_positions ALTER COLUMN id SET DEFAULT nextval('repository_positions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY seasons ALTER COLUMN id SET DEFAULT nextval('seasons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY serials ALTER COLUMN id SET DEFAULT nextval('serials_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sources ALTER COLUMN id SET DEFAULT nextval('sources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stations ALTER COLUMN id SET DEFAULT nextval('stations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: artist_credits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY artist_credits
    ADD CONSTRAINT artist_credits_pkey PRIMARY KEY (id);


--
-- Name: artist_identifiers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY artist_identifiers
    ADD CONSTRAINT artist_identifiers_pkey PRIMARY KEY (id);


--
-- Name: artists_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (id);


--
-- Name: ch_companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ch_companies
    ADD CONSTRAINT ch_companies_pkey PRIMARY KEY (id);


--
-- Name: ch_credits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ch_credits
    ADD CONSTRAINT ch_credits_pkey PRIMARY KEY (id);


--
-- Name: ch_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ch_labels
    ADD CONSTRAINT ch_labels_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: company_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY company_roles
    ADD CONSTRAINT company_roles_pkey PRIMARY KEY (id);


--
-- Name: compilation_copies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY compilation_copies
    ADD CONSTRAINT compilation_copies_pkey PRIMARY KEY (id);


--
-- Name: compilation_heads_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY compilation_heads
    ADD CONSTRAINT compilation_heads_pkey PRIMARY KEY (id);


--
-- Name: compilation_identifiers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY compilation_identifiers
    ADD CONSTRAINT compilation_identifiers_pkey PRIMARY KEY (id);


--
-- Name: compilation_releases_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY compilation_releases
    ADD CONSTRAINT compilation_releases_pkey PRIMARY KEY (id);


--
-- Name: compilation_track_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY compilation_track_details
    ADD CONSTRAINT compilation_track_details_pkey PRIMARY KEY (id);


--
-- Name: compilation_tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY compilation_tracks
    ADD CONSTRAINT compilation_tracks_pkey PRIMARY KEY (id);


--
-- Name: countries_piece_heads_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY countries_piece_heads
    ADD CONSTRAINT countries_piece_heads_pkey PRIMARY KEY (id);


--
-- Name: countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: cr_companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cr_companies
    ADD CONSTRAINT cr_companies_pkey PRIMARY KEY (id);


--
-- Name: cr_credits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cr_credits
    ADD CONSTRAINT cr_credits_pkey PRIMARY KEY (id);


--
-- Name: cr_format_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cr_format_details
    ADD CONSTRAINT cr_format_details_pkey PRIMARY KEY (id);


--
-- Name: cr_formats_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cr_formats
    ADD CONSTRAINT cr_formats_pkey PRIMARY KEY (id);


--
-- Name: cr_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cr_labels
    ADD CONSTRAINT cr_labels_pkey PRIMARY KEY (id);


--
-- Name: ct_format_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ct_format_details
    ADD CONSTRAINT ct_format_details_pkey PRIMARY KEY (id);


--
-- Name: descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT descriptions_pkey PRIMARY KEY (id);


--
-- Name: format_details_abbr_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY format_details
    ADD CONSTRAINT format_details_abbr_key UNIQUE (abbr);


--
-- Name: format_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY format_details
    ADD CONSTRAINT format_details_pkey PRIMARY KEY (id);


--
-- Name: formats_abbr_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY formats
    ADD CONSTRAINT formats_abbr_key UNIQUE (abbr);


--
-- Name: formats_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY formats
    ADD CONSTRAINT formats_pkey PRIMARY KEY (id);


--
-- Name: identifier_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY identifier_types
    ADD CONSTRAINT identifier_types_pkey PRIMARY KEY (id);


--
-- Name: jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: original_exemplars_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY original_exemplars
    ADD CONSTRAINT original_exemplars_pkey PRIMARY KEY (id);


--
-- Name: participants_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY participants
    ADD CONSTRAINT participants_pkey PRIMARY KEY (id);


--
-- Name: ph_companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ph_companies
    ADD CONSTRAINT ph_companies_pkey PRIMARY KEY (id);


--
-- Name: ph_credits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ph_credits
    ADD CONSTRAINT ph_credits_pkey PRIMARY KEY (id);


--
-- Name: ph_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ph_labels
    ADD CONSTRAINT ph_labels_pkey PRIMARY KEY (id);


--
-- Name: piece_heads_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY piece_heads
    ADD CONSTRAINT piece_heads_pkey PRIMARY KEY (id);


--
-- Name: piece_releases_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY piece_releases
    ADD CONSTRAINT piece_releases_pkey PRIMARY KEY (id);


--
-- Name: piece_tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY piece_tracks
    ADD CONSTRAINT piece_tracks_pkey PRIMARY KEY (id);


--
-- Name: pr_companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pr_companies
    ADD CONSTRAINT pr_companies_pkey PRIMARY KEY (id);


--
-- Name: pr_credits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pr_credits
    ADD CONSTRAINT pr_credits_pkey PRIMARY KEY (id);


--
-- Name: pr_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pr_labels
    ADD CONSTRAINT pr_labels_pkey PRIMARY KEY (id);


--
-- Name: ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (id);


--
-- Name: repositories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY repositories
    ADD CONSTRAINT repositories_pkey PRIMARY KEY (id);


--
-- Name: repository_format_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY repository_format_details
    ADD CONSTRAINT repository_format_details_pkey PRIMARY KEY (id);


--
-- Name: repository_positions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY repository_positions
    ADD CONSTRAINT repository_positions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: seasons_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY seasons
    ADD CONSTRAINT seasons_pkey PRIMARY KEY (id);


--
-- Name: serials_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY serials
    ADD CONSTRAINT serials_pkey PRIMARY KEY (id);


--
-- Name: sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: stations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stations
    ADD CONSTRAINT stations_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: artists_name_disambiguation_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX artists_name_disambiguation_idx ON artists USING btree (name, disambiguation) WHERE (artist_identifier_id IS NULL);


--
-- Name: artists_name_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX artists_name_idx ON artists USING btree (name) WHERE ((disambiguation IS NULL) AND (artist_identifier_id IS NULL));


--
-- Name: compilation_tracks_id_and_compilation_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX compilation_tracks_id_and_compilation_release_id ON compilation_tracks USING btree (id, compilation_release_id);


--
-- Name: cr_format_details_cr_format_id_position_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX cr_format_details_cr_format_id_position_idx ON cr_format_details USING btree (cr_format_id, "position");


--
-- Name: cr_formats_compilation_release_id_position_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX cr_formats_compilation_release_id_position_idx ON cr_formats USING btree (compilation_release_id, "position");


--
-- Name: ct_format_details_compilation_track_id_position_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX ct_format_details_compilation_track_id_position_idx ON ct_format_details USING btree (compilation_track_id, "position");


--
-- Name: format_details_lower_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX format_details_lower_idx ON format_details USING btree (lower(name));


--
-- Name: formats_lower_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX formats_lower_idx ON formats USING btree (lower(name));


--
-- Name: index_artist_credits_tags_on_artist_credit_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_artist_credits_tags_on_artist_credit_id ON artist_credits_tags USING btree (artist_credit_id);


--
-- Name: index_artist_credits_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_artist_credits_tags_on_tag_id ON artist_credits_tags USING btree (tag_id);


--
-- Name: index_artist_identifiers_artists_on_artist_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_artist_identifiers_artists_on_artist_id ON artist_identifiers_artists USING btree (artist_id);


--
-- Name: index_artist_identifiers_artists_on_artist_identifier_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_artist_identifiers_artists_on_artist_identifier_id ON artist_identifiers_artists USING btree (artist_identifier_id);


--
-- Name: index_artist_identifiers_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_artist_identifiers_on_source_id ON artist_identifiers USING btree (source_id);


--
-- Name: index_artists_on_artist_identifier_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_artists_on_artist_identifier_id ON artists USING btree (artist_identifier_id);


--
-- Name: index_artists_tags_on_artist_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_artists_tags_on_artist_id ON artists_tags USING btree (artist_id);


--
-- Name: index_artists_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_artists_tags_on_tag_id ON artists_tags USING btree (tag_id);


--
-- Name: index_ch_companies_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ch_companies_on_company_id ON ch_companies USING btree (company_id);


--
-- Name: index_ch_companies_on_company_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ch_companies_on_company_role_id ON ch_companies USING btree (company_role_id);


--
-- Name: index_ch_companies_on_compilation_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ch_companies_on_compilation_head_id ON ch_companies USING btree (compilation_head_id);


--
-- Name: index_ch_credits_on_artist_credit_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ch_credits_on_artist_credit_id ON ch_credits USING btree (artist_credit_id);


--
-- Name: index_ch_credits_on_compilation_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ch_credits_on_compilation_head_id ON ch_credits USING btree (compilation_head_id);


--
-- Name: index_ch_credits_on_job_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ch_credits_on_job_id ON ch_credits USING btree (job_id);


--
-- Name: index_ch_labels_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ch_labels_on_company_id ON ch_labels USING btree (company_id);


--
-- Name: index_ch_labels_on_compilation_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ch_labels_on_compilation_head_id ON ch_labels USING btree (compilation_head_id);


--
-- Name: index_comments_on_artist_credit_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_artist_credit_id ON comments USING btree (artist_credit_id);


--
-- Name: index_comments_on_artist_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_artist_id ON comments USING btree (artist_id);


--
-- Name: index_comments_on_compilation_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_compilation_head_id ON comments USING btree (compilation_head_id);


--
-- Name: index_comments_on_compilation_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_compilation_release_id ON comments USING btree (compilation_release_id);


--
-- Name: index_comments_on_piece_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_piece_head_id ON comments USING btree (piece_head_id);


--
-- Name: index_comments_on_piece_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_piece_release_id ON comments USING btree (piece_release_id);


--
-- Name: index_comments_on_repository_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_repository_id ON comments USING btree (repository_id);


--
-- Name: index_comments_on_season_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_season_id ON comments USING btree (season_id);


--
-- Name: index_comments_on_serial_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_serial_id ON comments USING btree (serial_id);


--
-- Name: index_comments_on_station_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_station_id ON comments USING btree (station_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_user_id ON comments USING btree (user_id);


--
-- Name: index_companies_on_lower_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_companies_on_lower_name ON companies USING btree (lower((name)::text));


--
-- Name: index_company_roles_on_lower_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_company_roles_on_lower_name ON company_roles USING btree (lower((name)::text));


--
-- Name: index_compilation_copies; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_compilation_copies ON compilation_copies USING btree (id, compilation_release_id, user_id);


--
-- Name: index_compilation_copies_on_compilation_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_compilation_copies_on_compilation_release_id ON compilation_copies USING btree (compilation_release_id);


--
-- Name: index_compilation_copies_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_compilation_copies_on_user_id ON compilation_copies USING btree (user_id);


--
-- Name: index_compilation_heads_countries_on_compilation_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_compilation_heads_countries_on_compilation_head_id ON compilation_heads_countries USING btree (compilation_head_id);


--
-- Name: index_compilation_heads_countries_on_country_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_compilation_heads_countries_on_country_id ON compilation_heads_countries USING btree (country_id);


--
-- Name: index_compilation_heads_on_artist_credit_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_compilation_heads_on_artist_credit_id ON compilation_heads USING btree (artist_credit_id);


--
-- Name: index_compilation_heads_on_lower_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_compilation_heads_on_lower_title ON compilation_heads USING btree (type, lower((title)::text)) WHERE ((disambiguation IS NULL) AND (source_ident IS NULL));


--
-- Name: index_compilation_heads_on_lower_title_disambiguation; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_compilation_heads_on_lower_title_disambiguation ON compilation_heads USING btree (type, lower((title)::text), lower((disambiguation)::text)) WHERE (source_ident IS NULL);


--
-- Name: index_compilation_heads_tags_on_compilation_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_compilation_heads_tags_on_compilation_head_id ON compilation_heads_tags USING btree (compilation_head_id);


--
-- Name: index_compilation_heads_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_compilation_heads_tags_on_tag_id ON compilation_heads_tags USING btree (tag_id);


--
-- Name: index_compilation_identifiers_on_code; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_compilation_identifiers_on_code ON compilation_identifiers USING btree (compilation_release_id, identifier_type_id, code) WHERE (disambiguation IS NULL);


--
-- Name: index_compilation_identifiers_on_code_disambiguation; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_compilation_identifiers_on_code_disambiguation ON compilation_identifiers USING btree (compilation_release_id, identifier_type_id, code, lower((disambiguation)::text));


--
-- Name: index_compilation_releases_countries_no_and_ids; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_compilation_releases_countries_no_and_ids ON compilation_releases_countries USING btree (compilation_release_id, country_id);


--
-- Name: index_compilation_releases_on_compilation_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_compilation_releases_on_compilation_head_id ON compilation_releases USING btree (compilation_head_id);


--
-- Name: index_compilation_releases_on_compilation_head_id_lower_version; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_compilation_releases_on_compilation_head_id_lower_version ON compilation_releases USING btree (compilation_head_id, lower((version)::text));


--
-- Name: index_compilation_releases_on_lower_version; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_compilation_releases_on_lower_version ON compilation_releases USING btree (type, compilation_head_id, lower((version)::text)) WHERE (source_ident IS NULL);


--
-- Name: index_compilation_releases_tags_on_compilation_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_compilation_releases_tags_on_compilation_release_id ON compilation_releases_tags USING btree (compilation_release_id);


--
-- Name: index_compilation_releases_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_compilation_releases_tags_on_tag_id ON compilation_releases_tags USING btree (tag_id);


--
-- Name: index_compilation_track_details_on_track_id_and_position; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_compilation_track_details_on_track_id_and_position ON compilation_track_details USING btree (track_id, "position");


--
-- Name: index_compilation_tracks_on_compilation_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_compilation_tracks_on_compilation_release_id ON compilation_tracks USING btree (compilation_release_id);


--
-- Name: index_compilation_tracks_on_piece_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_compilation_tracks_on_piece_release_id ON compilation_tracks USING btree (piece_release_id);


--
-- Name: index_countries_on_lower_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_countries_on_lower_name ON countries USING btree (lower((name)::text));


--
-- Name: index_countries_piece_heads_on_country_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_countries_piece_heads_on_country_id ON countries_piece_heads USING btree (country_id);


--
-- Name: index_countries_piece_heads_on_country_id_and_piece_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_countries_piece_heads_on_country_id_and_piece_head_id ON countries_piece_heads USING btree (country_id, piece_head_id);


--
-- Name: index_countries_piece_heads_on_piece_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_countries_piece_heads_on_piece_head_id ON countries_piece_heads USING btree (piece_head_id);


--
-- Name: index_countries_piece_releases_on_country_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_countries_piece_releases_on_country_id ON countries_piece_releases USING btree (country_id);


--
-- Name: index_countries_piece_releases_on_piece_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_countries_piece_releases_on_piece_release_id ON countries_piece_releases USING btree (piece_release_id);


--
-- Name: index_cpr_on_country_id_and_piece_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_cpr_on_country_id_and_piece_release_id ON countries_piece_releases USING btree (country_id, piece_release_id);


--
-- Name: index_cr_companies_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cr_companies_on_company_id ON cr_companies USING btree (company_id);


--
-- Name: index_cr_companies_on_company_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cr_companies_on_company_role_id ON cr_companies USING btree (company_role_id);


--
-- Name: index_cr_companies_on_compilation_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cr_companies_on_compilation_release_id ON cr_companies USING btree (compilation_release_id);


--
-- Name: index_cr_credits_on_artist_credit_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cr_credits_on_artist_credit_id ON cr_credits USING btree (artist_credit_id);


--
-- Name: index_cr_credits_on_compilation_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cr_credits_on_compilation_release_id ON cr_credits USING btree (compilation_release_id);


--
-- Name: index_cr_credits_on_job_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cr_credits_on_job_id ON cr_credits USING btree (job_id);


--
-- Name: index_cr_labels_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cr_labels_on_company_id ON cr_labels USING btree (company_id);


--
-- Name: index_cr_labels_on_compilation_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cr_labels_on_compilation_release_id ON cr_labels USING btree (compilation_release_id);


--
-- Name: index_descriptions_on_artist_credit_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_descriptions_on_artist_credit_id ON descriptions USING btree (artist_credit_id);


--
-- Name: index_descriptions_on_artist_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_descriptions_on_artist_id ON descriptions USING btree (artist_id);


--
-- Name: index_descriptions_on_compilation_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_descriptions_on_compilation_head_id ON descriptions USING btree (compilation_head_id);


--
-- Name: index_descriptions_on_compilation_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_descriptions_on_compilation_release_id ON descriptions USING btree (compilation_release_id);


--
-- Name: index_descriptions_on_country_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_descriptions_on_country_id ON descriptions USING btree (country_id);


--
-- Name: index_descriptions_on_piece_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_descriptions_on_piece_head_id ON descriptions USING btree (piece_head_id);


--
-- Name: index_descriptions_on_piece_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_descriptions_on_piece_release_id ON descriptions USING btree (piece_release_id);


--
-- Name: index_descriptions_on_season_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_descriptions_on_season_id ON descriptions USING btree (season_id);


--
-- Name: index_descriptions_on_serial_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_descriptions_on_serial_id ON descriptions USING btree (serial_id);


--
-- Name: index_descriptions_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_descriptions_on_source_id ON descriptions USING btree (source_id);


--
-- Name: index_descriptions_on_station_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_descriptions_on_station_id ON descriptions USING btree (station_id);


--
-- Name: index_descriptions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_descriptions_on_user_id ON descriptions USING btree (user_id);


--
-- Name: index_identifier_types_on_lower_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_identifier_types_on_lower_name ON identifier_types USING btree (lower((name)::text));


--
-- Name: index_jobs_on_lower_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_jobs_on_lower_name ON jobs USING btree (lower((name)::text));


--
-- Name: index_original_exemplars_on_compilation_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_original_exemplars_on_compilation_release_id ON original_exemplars USING btree (compilation_release_id);


--
-- Name: index_original_exemplars_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_original_exemplars_on_user_id ON original_exemplars USING btree (user_id);


--
-- Name: index_participants_on_artist_credit_id_and_no; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_participants_on_artist_credit_id_and_no ON participants USING btree ("position", artist_credit_id);


--
-- Name: index_participants_on_artist_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_participants_on_artist_id ON participants USING btree (artist_id);


--
-- Name: index_ph_companies_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ph_companies_on_company_id ON ph_companies USING btree (company_id);


--
-- Name: index_ph_companies_on_company_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ph_companies_on_company_role_id ON ph_companies USING btree (company_role_id);


--
-- Name: index_ph_companies_on_piece_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ph_companies_on_piece_head_id ON ph_companies USING btree (piece_head_id);


--
-- Name: index_ph_credits_on_artist_credit_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ph_credits_on_artist_credit_id ON ph_credits USING btree (artist_credit_id);


--
-- Name: index_ph_credits_on_job_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ph_credits_on_job_id ON ph_credits USING btree (job_id);


--
-- Name: index_ph_credits_on_piece_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ph_credits_on_piece_head_id ON ph_credits USING btree (piece_head_id);


--
-- Name: index_ph_labels_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ph_labels_on_company_id ON ph_labels USING btree (company_id);


--
-- Name: index_ph_labels_on_piece_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ph_labels_on_piece_head_id ON ph_labels USING btree (piece_head_id);


--
-- Name: index_phc_on_country_id_and_compilation_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_phc_on_country_id_and_compilation_head_id ON compilation_heads_countries USING btree (country_id, compilation_head_id);


--
-- Name: index_piece_heads_on_artist_credit_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_piece_heads_on_artist_credit_id ON piece_heads USING btree (artist_credit_id);


--
-- Name: index_piece_heads_on_lower_title_disambiguation; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_piece_heads_on_lower_title_disambiguation ON piece_heads USING btree (artist_credit_id, type, lower((title)::text), lower((disambiguation)::text));


--
-- Name: index_piece_heads_on_season_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_piece_heads_on_season_id ON piece_heads USING btree (season_id);


--
-- Name: index_piece_heads_tags_on_piece_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_piece_heads_tags_on_piece_head_id ON piece_heads_tags USING btree (piece_head_id);


--
-- Name: index_piece_heads_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_piece_heads_tags_on_tag_id ON piece_heads_tags USING btree (tag_id);


--
-- Name: index_piece_releases_on_piece_head_id_and_lower_version; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_piece_releases_on_piece_head_id_and_lower_version ON piece_releases USING btree (piece_head_id, lower((version)::text));


--
-- Name: index_piece_releases_on_station_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_piece_releases_on_station_id ON piece_releases USING btree (station_id);


--
-- Name: index_piece_releases_tags_on_piece_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_piece_releases_tags_on_piece_release_id ON piece_releases_tags USING btree (piece_release_id);


--
-- Name: index_piece_releases_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_piece_releases_tags_on_tag_id ON piece_releases_tags USING btree (tag_id);


--
-- Name: index_piece_tracks_on_piece_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_piece_tracks_on_piece_release_id ON piece_tracks USING btree (piece_release_id);


--
-- Name: index_piece_tracks_on_tr_format_kind_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_piece_tracks_on_tr_format_kind_id ON piece_tracks USING btree (tr_format_kind_id);


--
-- Name: index_pr_companies_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pr_companies_on_company_id ON pr_companies USING btree (company_id);


--
-- Name: index_pr_companies_on_company_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pr_companies_on_company_role_id ON pr_companies USING btree (company_role_id);


--
-- Name: index_pr_companies_on_piece_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pr_companies_on_piece_release_id ON pr_companies USING btree (piece_release_id);


--
-- Name: index_pr_credits_on_artist_credit_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pr_credits_on_artist_credit_id ON pr_credits USING btree (artist_credit_id);


--
-- Name: index_pr_credits_on_job_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pr_credits_on_job_id ON pr_credits USING btree (job_id);


--
-- Name: index_pr_credits_on_piece_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pr_credits_on_piece_release_id ON pr_credits USING btree (piece_release_id);


--
-- Name: index_pr_labels_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pr_labels_on_company_id ON pr_labels USING btree (company_id);


--
-- Name: index_pr_labels_on_piece_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pr_labels_on_piece_release_id ON pr_labels USING btree (piece_release_id);


--
-- Name: index_ratings_on_artist_credit_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ratings_on_artist_credit_id ON ratings USING btree (artist_credit_id);


--
-- Name: index_ratings_on_artist_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ratings_on_artist_id ON ratings USING btree (artist_id);


--
-- Name: index_ratings_on_compilation_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ratings_on_compilation_head_id ON ratings USING btree (compilation_head_id);


--
-- Name: index_ratings_on_compilation_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ratings_on_compilation_release_id ON ratings USING btree (compilation_release_id);


--
-- Name: index_ratings_on_piece_head_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ratings_on_piece_head_id ON ratings USING btree (piece_head_id);


--
-- Name: index_ratings_on_piece_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ratings_on_piece_release_id ON ratings USING btree (piece_release_id);


--
-- Name: index_ratings_on_season_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ratings_on_season_id ON ratings USING btree (season_id);


--
-- Name: index_ratings_on_serial_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ratings_on_serial_id ON ratings USING btree (serial_id);


--
-- Name: index_ratings_on_station_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ratings_on_station_id ON ratings USING btree (station_id);


--
-- Name: index_ratings_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ratings_on_user_id ON ratings USING btree (user_id);


--
-- Name: index_repositories_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_repositories_id_and_user_id ON repositories USING btree (id, user_id);


--
-- Name: index_repositories_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_repositories_on_user_id ON repositories USING btree (user_id);


--
-- Name: index_seasons_on_position_and_serial_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_seasons_on_position_and_serial_id ON seasons USING btree ("position", serial_id);


--
-- Name: index_seasons_tags_on_season_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_seasons_tags_on_season_id ON seasons_tags USING btree (season_id);


--
-- Name: index_seasons_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_seasons_tags_on_tag_id ON seasons_tags USING btree (tag_id);


--
-- Name: index_serials_on_lower_disambiguation_and_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_serials_on_lower_disambiguation_and_title ON serials USING btree (lower((title)::text), lower((disambiguation)::text));


--
-- Name: index_serials_on_lower_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_serials_on_lower_title ON serials USING btree (lower((title)::text)) WHERE (disambiguation IS NULL);


--
-- Name: index_serials_tags_on_serial_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_serials_tags_on_serial_id ON serials_tags USING btree (serial_id);


--
-- Name: index_serials_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_serials_tags_on_tag_id ON serials_tags USING btree (tag_id);


--
-- Name: index_stations_on_lower_disambiguation_and_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_stations_on_lower_disambiguation_and_name ON stations USING btree (lower((disambiguation)::text), lower((name)::text));


--
-- Name: index_stations_on_lower_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_stations_on_lower_name ON stations USING btree (lower((name)::text)) WHERE (disambiguation IS NULL);


--
-- Name: index_stations_tags_on_station_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_stations_tags_on_station_id ON stations_tags USING btree (station_id);


--
-- Name: index_stations_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_stations_tags_on_tag_id ON stations_tags USING btree (tag_id);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_tags_on_name ON tags USING btree (name);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: repository_format_details_repository_id_position_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX repository_format_details_repository_id_position_idx ON repository_format_details USING btree (repository_id, "position");


--
-- Name: cr_format_details_cr_format_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_format_details
    ADD CONSTRAINT cr_format_details_cr_format_id_fkey FOREIGN KEY (cr_format_id) REFERENCES cr_formats(id);


--
-- Name: cr_formats_compilation_release_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_formats
    ADD CONSTRAINT cr_formats_compilation_release_id_fkey FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id);


--
-- Name: ct_format_details_compilation_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ct_format_details
    ADD CONSTRAINT ct_format_details_compilation_track_id_fkey FOREIGN KEY (compilation_track_id) REFERENCES compilation_tracks(id);


--
-- Name: fk_artist_credits_source_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY artist_credits
    ADD CONSTRAINT fk_artist_credits_source_id FOREIGN KEY (source_id) REFERENCES sources(id);


--
-- Name: fk_compilation_heads_source_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_heads
    ADD CONSTRAINT fk_compilation_heads_source_id FOREIGN KEY (source_id) REFERENCES sources(id);


--
-- Name: fk_compilation_releases_source_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_releases
    ADD CONSTRAINT fk_compilation_releases_source_id FOREIGN KEY (source_id) REFERENCES sources(id);


--
-- Name: fk_compilation_tracks_format_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_tracks
    ADD CONSTRAINT fk_compilation_tracks_format_id FOREIGN KEY (format_id) REFERENCES formats(id);


--
-- Name: fk_cr_format_details_format_detail_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_format_details
    ADD CONSTRAINT fk_cr_format_details_format_detail_id FOREIGN KEY (format_detail_id) REFERENCES format_details(id);


--
-- Name: fk_cr_formats_format_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_formats
    ADD CONSTRAINT fk_cr_formats_format_id FOREIGN KEY (format_id) REFERENCES formats(id);


--
-- Name: fk_ct_format_details_format_detail_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ct_format_details
    ADD CONSTRAINT fk_ct_format_details_format_detail_id FOREIGN KEY (format_detail_id) REFERENCES format_details(id);


--
-- Name: fk_piece_heads_source_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_heads
    ADD CONSTRAINT fk_piece_heads_source_id FOREIGN KEY (source_id) REFERENCES sources(id);


--
-- Name: fk_piece_releases_source_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_releases
    ADD CONSTRAINT fk_piece_releases_source_id FOREIGN KEY (source_id) REFERENCES sources(id);


--
-- Name: fk_rails_01ebf7126a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_heads_countries
    ADD CONSTRAINT fk_rails_01ebf7126a FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id);


--
-- Name: fk_rails_03de2dc08c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_03de2dc08c FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_04307d4c11; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_tracks
    ADD CONSTRAINT fk_rails_04307d4c11 FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id);


--
-- Name: fk_rails_09feef8331; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_heads
    ADD CONSTRAINT fk_rails_09feef8331 FOREIGN KEY (artist_credit_id) REFERENCES artist_credits(id);


--
-- Name: fk_rails_0c6cb59e89; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ph_labels
    ADD CONSTRAINT fk_rails_0c6cb59e89 FOREIGN KEY (company_id) REFERENCES companies(id);


--
-- Name: fk_rails_0e5c05a1d3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY serials_tags
    ADD CONSTRAINT fk_rails_0e5c05a1d3 FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- Name: fk_rails_0ebfa9dfb8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_copies
    ADD CONSTRAINT fk_rails_0ebfa9dfb8 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_1185695be6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_1185695be6 FOREIGN KEY (artist_credit_id) REFERENCES artist_credits(id);


--
-- Name: fk_rails_12d1a6dd66; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY original_exemplars
    ADD CONSTRAINT fk_rails_12d1a6dd66 FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id);


--
-- Name: fk_rails_14cd9888d9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stations_tags
    ADD CONSTRAINT fk_rails_14cd9888d9 FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- Name: fk_rails_22c208a585; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT fk_rails_22c208a585 FOREIGN KEY (serial_id) REFERENCES serials(id);


--
-- Name: fk_rails_2493022b8a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY artist_credits_tags
    ADD CONSTRAINT fk_rails_2493022b8a FOREIGN KEY (artist_credit_id) REFERENCES artist_credits(id);


--
-- Name: fk_rails_2536f5da69; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY countries_piece_releases
    ADD CONSTRAINT fk_rails_2536f5da69 FOREIGN KEY (country_id) REFERENCES countries(id);


--
-- Name: fk_rails_25a57070fa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_25a57070fa FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id);


--
-- Name: fk_rails_2989b795e7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY countries_piece_heads
    ADD CONSTRAINT fk_rails_2989b795e7 FOREIGN KEY (country_id) REFERENCES countries(id);


--
-- Name: fk_rails_2ac63d8fba; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pr_credits
    ADD CONSTRAINT fk_rails_2ac63d8fba FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id);


--
-- Name: fk_rails_2cae2f4774; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_heads_countries
    ADD CONSTRAINT fk_rails_2cae2f4774 FOREIGN KEY (country_id) REFERENCES countries(id);


--
-- Name: fk_rails_2d90bc0fba; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_companies
    ADD CONSTRAINT fk_rails_2d90bc0fba FOREIGN KEY (company_role_id) REFERENCES company_roles(id);


--
-- Name: fk_rails_2e12f470e1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_credits
    ADD CONSTRAINT fk_rails_2e12f470e1 FOREIGN KEY (job_id) REFERENCES jobs(id);


--
-- Name: fk_rails_2f8a503c91; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pr_credits
    ADD CONSTRAINT fk_rails_2f8a503c91 FOREIGN KEY (artist_credit_id) REFERENCES artist_credits(id);


--
-- Name: fk_rails_2ff06832e6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ph_companies
    ADD CONSTRAINT fk_rails_2ff06832e6 FOREIGN KEY (company_role_id) REFERENCES company_roles(id);


--
-- Name: fk_rails_2ff57459b2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_identifiers
    ADD CONSTRAINT fk_rails_2ff57459b2 FOREIGN KEY (identifier_type_id) REFERENCES identifier_types(id);


--
-- Name: fk_rails_3257861963; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_releases
    ADD CONSTRAINT fk_rails_3257861963 FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id);


--
-- Name: fk_rails_33247dd051; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pr_companies
    ADD CONSTRAINT fk_rails_33247dd051 FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id);


--
-- Name: fk_rails_3393e4186d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ph_companies
    ADD CONSTRAINT fk_rails_3393e4186d FOREIGN KEY (company_id) REFERENCES companies(id);


--
-- Name: fk_rails_37cf3dc329; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pr_companies
    ADD CONSTRAINT fk_rails_37cf3dc329 FOREIGN KEY (company_role_id) REFERENCES company_roles(id);


--
-- Name: fk_rails_39dbeba97b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_39dbeba97b FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id);


--
-- Name: fk_rails_3fa8efa307; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY artist_identifiers_artists
    ADD CONSTRAINT fk_rails_3fa8efa307 FOREIGN KEY (artist_identifier_id) REFERENCES artist_identifiers(id);


--
-- Name: fk_rails_41d01a9df9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_releases_tags
    ADD CONSTRAINT fk_rails_41d01a9df9 FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id);


--
-- Name: fk_rails_47535a2160; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY serials_tags
    ADD CONSTRAINT fk_rails_47535a2160 FOREIGN KEY (serial_id) REFERENCES serials(id);


--
-- Name: fk_rails_49b539283c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ch_labels
    ADD CONSTRAINT fk_rails_49b539283c FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id);


--
-- Name: fk_rails_4b101ee403; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT fk_rails_4b101ee403 FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id);


--
-- Name: fk_rails_4b9a174361; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_heads_tags
    ADD CONSTRAINT fk_rails_4b9a174361 FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- Name: fk_rails_4d417c1eb4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_releases_tags
    ADD CONSTRAINT fk_rails_4d417c1eb4 FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- Name: fk_rails_53799465b8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_tracks
    ADD CONSTRAINT fk_rails_53799465b8 FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id);


--
-- Name: fk_rails_548c057ea1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_companies
    ADD CONSTRAINT fk_rails_548c057ea1 FOREIGN KEY (company_id) REFERENCES companies(id);


--
-- Name: fk_rails_58ab0d4634; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_58ab0d4634 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_5b62c0dff0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ph_labels
    ADD CONSTRAINT fk_rails_5b62c0dff0 FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id);


--
-- Name: fk_rails_5c7f0a15dd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY repositories
    ADD CONSTRAINT fk_rails_5c7f0a15dd FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_5d93041b13; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT fk_rails_5d93041b13 FOREIGN KEY (station_id) REFERENCES stations(id);


--
-- Name: fk_rails_60c42b31e6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ch_credits
    ADD CONSTRAINT fk_rails_60c42b31e6 FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id);


--
-- Name: fk_rails_663552d742; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT fk_rails_663552d742 FOREIGN KEY (artist_credit_id) REFERENCES artist_credits(id);


--
-- Name: fk_rails_6c850f5f4a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY artists_tags
    ADD CONSTRAINT fk_rails_6c850f5f4a FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- Name: fk_rails_6daae60d18; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_releases_tags
    ADD CONSTRAINT fk_rails_6daae60d18 FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id);


--
-- Name: fk_rails_6df434c598; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_6df434c598 FOREIGN KEY (serial_id) REFERENCES serials(id);


--
-- Name: fk_rails_6e325ae0d7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stations_tags
    ADD CONSTRAINT fk_rails_6e325ae0d7 FOREIGN KEY (station_id) REFERENCES stations(id);


--
-- Name: fk_rails_6ff07629cd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_6ff07629cd FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id);


--
-- Name: fk_rails_70f67fa677; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT fk_rails_70f67fa677 FOREIGN KEY (season_id) REFERENCES seasons(id);


--
-- Name: fk_rails_716a08d546; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY artist_credits_tags
    ADD CONSTRAINT fk_rails_716a08d546 FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- Name: fk_rails_7204f5c5ca; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_labels
    ADD CONSTRAINT fk_rails_7204f5c5ca FOREIGN KEY (company_id) REFERENCES companies(id);


--
-- Name: fk_rails_73a874ce99; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_73a874ce99 FOREIGN KEY (season_id) REFERENCES seasons(id);


--
-- Name: fk_rails_7440c7f021; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pr_companies
    ADD CONSTRAINT fk_rails_7440c7f021 FOREIGN KEY (company_id) REFERENCES companies(id);


--
-- Name: fk_rails_74772a69c1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY seasons_tags
    ADD CONSTRAINT fk_rails_74772a69c1 FOREIGN KEY (season_id) REFERENCES seasons(id);


--
-- Name: fk_rails_75c715b1c3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY artist_identifiers
    ADD CONSTRAINT fk_rails_75c715b1c3 FOREIGN KEY (source_id) REFERENCES sources(id);


--
-- Name: fk_rails_7b69ed2838; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ch_credits
    ADD CONSTRAINT fk_rails_7b69ed2838 FOREIGN KEY (artist_credit_id) REFERENCES artist_credits(id);


--
-- Name: fk_rails_7c9508df49; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_copies
    ADD CONSTRAINT fk_rails_7c9508df49 FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id);


--
-- Name: fk_rails_7d0e08dd6b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY seasons_tags
    ADD CONSTRAINT fk_rails_7d0e08dd6b FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- Name: fk_rails_8015f9d7ae; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT fk_rails_8015f9d7ae FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id);


--
-- Name: fk_rails_815a91ee09; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_heads_tags
    ADD CONSTRAINT fk_rails_815a91ee09 FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id);


--
-- Name: fk_rails_81dd9f559b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_releases_tags
    ADD CONSTRAINT fk_rails_81dd9f559b FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- Name: fk_rails_8b910926c7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY countries_piece_releases
    ADD CONSTRAINT fk_rails_8b910926c7 FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id);


--
-- Name: fk_rails_8dc25981ef; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_8dc25981ef FOREIGN KEY (artist_id) REFERENCES artists(id);


--
-- Name: fk_rails_8e7336dad9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pr_labels
    ADD CONSTRAINT fk_rails_8e7336dad9 FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id);


--
-- Name: fk_rails_90dbd0e7f9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ph_credits
    ADD CONSTRAINT fk_rails_90dbd0e7f9 FOREIGN KEY (job_id) REFERENCES jobs(id);


--
-- Name: fk_rails_96379d348a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pr_credits
    ADD CONSTRAINT fk_rails_96379d348a FOREIGN KEY (job_id) REFERENCES jobs(id);


--
-- Name: fk_rails_97a4d11676; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_97a4d11676 FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id);


--
-- Name: fk_rails_9951108430; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ch_companies
    ADD CONSTRAINT fk_rails_9951108430 FOREIGN KEY (company_id) REFERENCES companies(id);


--
-- Name: fk_rails_9a3108629b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_track_details
    ADD CONSTRAINT fk_rails_9a3108629b FOREIGN KEY (track_id) REFERENCES compilation_tracks(id);


--
-- Name: fk_rails_9c0a03d24c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY artists
    ADD CONSTRAINT fk_rails_9c0a03d24c FOREIGN KEY (artist_identifier_id) REFERENCES artist_identifiers(id);


--
-- Name: fk_rails_9d0928ab85; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_9d0928ab85 FOREIGN KEY (season_id) REFERENCES seasons(id);


--
-- Name: fk_rails_9eadad0a3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT fk_rails_9eadad0a3d FOREIGN KEY (artist_id) REFERENCES artists(id);


--
-- Name: fk_rails_a55ea41678; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_a55ea41678 FOREIGN KEY (serial_id) REFERENCES serials(id);


--
-- Name: fk_rails_a7dfeb9f5f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT fk_rails_a7dfeb9f5f FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_ab22361422; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_companies
    ADD CONSTRAINT fk_rails_ab22361422 FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id);


--
-- Name: fk_rails_ace92ec2ab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_ace92ec2ab FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id);


--
-- Name: fk_rails_b25e5ea472; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ph_credits
    ADD CONSTRAINT fk_rails_b25e5ea472 FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id);


--
-- Name: fk_rails_b2e6126bda; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_credits
    ADD CONSTRAINT fk_rails_b2e6126bda FOREIGN KEY (artist_credit_id) REFERENCES artist_credits(id);


--
-- Name: fk_rails_b59f9b25b6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_b59f9b25b6 FOREIGN KEY (source_id) REFERENCES sources(id);


--
-- Name: fk_rails_b751628f21; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ch_labels
    ADD CONSTRAINT fk_rails_b751628f21 FOREIGN KEY (company_id) REFERENCES companies(id);


--
-- Name: fk_rails_b91aa70e14; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_b91aa70e14 FOREIGN KEY (artist_id) REFERENCES artists(id);


--
-- Name: fk_rails_b93a075402; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ph_companies
    ADD CONSTRAINT fk_rails_b93a075402 FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id);


--
-- Name: fk_rails_bbd6cbbc5f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY artist_identifiers_artists
    ADD CONSTRAINT fk_rails_bbd6cbbc5f FOREIGN KEY (artist_id) REFERENCES artists(id);


--
-- Name: fk_rails_be93d8ae79; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_be93d8ae79 FOREIGN KEY (station_id) REFERENCES stations(id);


--
-- Name: fk_rails_bf91f3d39d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT fk_rails_bf91f3d39d FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id);


--
-- Name: fk_rails_c0c37ae7ab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_releases_countries
    ADD CONSTRAINT fk_rails_c0c37ae7ab FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id);


--
-- Name: fk_rails_c24b3a4fff; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_heads_tags
    ADD CONSTRAINT fk_rails_c24b3a4fff FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id);


--
-- Name: fk_rails_c723c589bc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_c723c589bc FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id);


--
-- Name: fk_rails_c7a3ec0a86; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_releases_countries
    ADD CONSTRAINT fk_rails_c7a3ec0a86 FOREIGN KEY (country_id) REFERENCES countries(id);


--
-- Name: fk_rails_cf815a1510; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY countries_piece_heads
    ADD CONSTRAINT fk_rails_cf815a1510 FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id);


--
-- Name: fk_rails_d02a5a1df1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_d02a5a1df1 FOREIGN KEY (artist_credit_id) REFERENCES artist_credits(id);


--
-- Name: fk_rails_d4da78d1c9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_tracks
    ADD CONSTRAINT fk_rails_d4da78d1c9 FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id);


--
-- Name: fk_rails_d560853ced; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_labels
    ADD CONSTRAINT fk_rails_d560853ced FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id);


--
-- Name: fk_rails_d5fe6b4f15; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ch_credits
    ADD CONSTRAINT fk_rails_d5fe6b4f15 FOREIGN KEY (job_id) REFERENCES jobs(id);


--
-- Name: fk_rails_d6bdd09097; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ch_companies
    ADD CONSTRAINT fk_rails_d6bdd09097 FOREIGN KEY (company_role_id) REFERENCES company_roles(id);


--
-- Name: fk_rails_d9764bf4b0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY compilation_identifiers
    ADD CONSTRAINT fk_rails_d9764bf4b0 FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id);


--
-- Name: fk_rails_da212ea42e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_heads_tags
    ADD CONSTRAINT fk_rails_da212ea42e FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- Name: fk_rails_e0359ee6bb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY artists_tags
    ADD CONSTRAINT fk_rails_e0359ee6bb FOREIGN KEY (artist_id) REFERENCES artists(id);


--
-- Name: fk_rails_e147a88bdb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_e147a88bdb FOREIGN KEY (station_id) REFERENCES stations(id);


--
-- Name: fk_rails_e562cf7d82; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cr_credits
    ADD CONSTRAINT fk_rails_e562cf7d82 FOREIGN KEY (compilation_release_id) REFERENCES compilation_releases(id);


--
-- Name: fk_rails_e726ca8458; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_e726ca8458 FOREIGN KEY (country_id) REFERENCES countries(id);


--
-- Name: fk_rails_e838047dd4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ph_credits
    ADD CONSTRAINT fk_rails_e838047dd4 FOREIGN KEY (artist_credit_id) REFERENCES artist_credits(id);


--
-- Name: fk_rails_ed786e6e71; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pr_labels
    ADD CONSTRAINT fk_rails_ed786e6e71 FOREIGN KEY (company_id) REFERENCES companies(id);


--
-- Name: fk_rails_f1597c62ab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_f1597c62ab FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id);


--
-- Name: fk_rails_f63bb9a79b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT fk_rails_f63bb9a79b FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id);


--
-- Name: fk_rails_f7dd8d775b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_f7dd8d775b FOREIGN KEY (repository_id) REFERENCES repositories(id);


--
-- Name: fk_rails_f9f0bc8f37; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT fk_rails_f9f0bc8f37 FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id);


--
-- Name: fk_rails_fc315208ac; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY original_exemplars
    ADD CONSTRAINT fk_rails_fc315208ac FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_fddf8f8bbb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ch_companies
    ADD CONSTRAINT fk_rails_fddf8f8bbb FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads(id);


--
-- Name: fk_repositories_format_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY repositories
    ADD CONSTRAINT fk_repositories_format_id FOREIGN KEY (format_id) REFERENCES formats(id);


--
-- Name: fk_repository_format_details_format_detail_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY repository_format_details
    ADD CONSTRAINT fk_repository_format_details_format_detail_id FOREIGN KEY (format_detail_id) REFERENCES format_details(id);


--
-- Name: fk_repository_position_repository; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY repository_positions
    ADD CONSTRAINT fk_repository_position_repository FOREIGN KEY (repository_id, user_id) REFERENCES repositories(id, user_id);


--
-- Name: fk_repository_position_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY repository_positions
    ADD CONSTRAINT fk_repository_position_user FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_repository_positions_compilation_copies; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY repository_positions
    ADD CONSTRAINT fk_repository_positions_compilation_copies FOREIGN KEY (compilation_copy_id, compilation_release_id, user_id) REFERENCES compilation_copies(id, compilation_release_id, user_id);


--
-- Name: fk_repository_positions_piece_tracks; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY repository_positions
    ADD CONSTRAINT fk_repository_positions_piece_tracks FOREIGN KEY (piece_track_id) REFERENCES piece_tracks(id);


--
-- Name: participants_fk_artist_credits; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY participants
    ADD CONSTRAINT participants_fk_artist_credits FOREIGN KEY (artist_credit_id) REFERENCES artist_credits(id);


--
-- Name: participants_fk_artists; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY participants
    ADD CONSTRAINT participants_fk_artists FOREIGN KEY (artist_id) REFERENCES artists(id);


--
-- Name: piece_heads_fk_artist_credits; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_heads
    ADD CONSTRAINT piece_heads_fk_artist_credits FOREIGN KEY (artist_credit_id) REFERENCES artist_credits(id);


--
-- Name: piece_heads_fk_seasons; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_heads
    ADD CONSTRAINT piece_heads_fk_seasons FOREIGN KEY (season_id) REFERENCES seasons(id);


--
-- Name: pieces_fk_piece_heads; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_releases
    ADD CONSTRAINT pieces_fk_piece_heads FOREIGN KEY (piece_head_id) REFERENCES piece_heads(id);


--
-- Name: pieces_fk_stations; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY piece_releases
    ADD CONSTRAINT pieces_fk_stations FOREIGN KEY (station_id) REFERENCES stations(id);


--
-- Name: repository_format_details_repository_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY repository_format_details
    ADD CONSTRAINT repository_format_details_repository_id_fkey FOREIGN KEY (repository_id) REFERENCES repositories(id);


--
-- Name: repository_positions_compilation_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY repository_positions
    ADD CONSTRAINT repository_positions_compilation_track_id_fkey FOREIGN KEY (compilation_track_id, compilation_release_id) REFERENCES compilation_tracks(id, compilation_release_id);


--
-- Name: repository_positions_piece_release_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY repository_positions
    ADD CONSTRAINT repository_positions_piece_release_id_fkey FOREIGN KEY (piece_release_id) REFERENCES piece_releases(id);


--
-- Name: seasons_fk_seasons; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY seasons
    ADD CONSTRAINT seasons_fk_seasons FOREIGN KEY (serial_id) REFERENCES serials(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES
('20150209182752'),
('20150210191122'),
('20150210194156'),
('20150210202443'),
('20150210205238'),
('20150211191334'),
('20150211192009'),
('20150212200749'),
('20150212204306'),
('20150216192334'),
('20150216193353'),
('20150216194417'),
('20150216200436'),
('20150216202333'),
('20150216210813'),
('20150216211655'),
('20150216213806'),
('20150216214047'),
('20150217191223'),
('20150217192130'),
('20150217193017'),
('20150217193440'),
('20150217194106'),
('20150217194613'),
('20150217200211'),
('20150217202308'),
('20150217204538'),
('20150217210043'),
('20150217210543'),
('20150218185301'),
('20150218185737'),
('20150223192055'),
('20150223194519'),
('20150224204843'),
('20150302101456'),
('20150302104120'),
('20150302105527'),
('20150303072944'),
('20150303074923'),
('20150303075652'),
('20150303083831'),
('20150303085214'),
('20150303090246'),
('20150303094838'),
('20150303095730'),
('20150303103154'),
('20150303191121'),
('20150303192009'),
('20150304091900'),
('20150304095254'),
('20150304100906'),
('20150304103427'),
('20150304111115'),
('20150304112236'),
('20150304194039'),
('20150309101346'),
('20150309104743'),
('20150312083620'),
('20150313074602'),
('20150313093301'),
('20150325192035'),
('20150325192619'),
('20150325195646'),
('20150325211225'),
('20150326185844'),
('20150326192227'),
('20150330183819'),
('20150330184009'),
('20150330185706'),
('20150330191242'),
('20150330200424'),
('20150330201257'),
('20150331183053'),
('20150331192611'),
('20150401181529'),
('20150401182330'),
('20150401191204'),
('20150401192652'),
('20150407181801'),
('20150408181753'),
('20150408183457'),
('20150408185141'),
('20150408191152'),
('20150408194132'),
('20150408195157'),
('20150409180730'),
('20150409182552'),
('20150409183650'),
('20150409184600'),
('20150409191023'),
('20150409192934'),
('20150409193705'),
('20150409195031'),
('20150409200014'),
('20150413172155'),
('20150413183115'),
('20150413190041'),
('20150413190343'),
('20150414174328'),
('20150414175031'),
('20150414175339'),
('20150414180044'),
('20150414180615'),
('20150414180958'),
('20150923092337'),
('20150923095239'),
('20150923100941'),
('20150923122847'),
('20150923125014'),
('20150923133759'),
('20150924073647'),
('20150924081816'),
('20150924084200'),
('20150924091625'),
('20150924182359'),
('20150928074159'),
('20151002074436'),
('20151005174738'),
('20151005175911'),
('20151005181325'),
('20151006191430'),
('20151007193423'),
('20151008192822'),
('20151008193954'),
('20151012172945'),
('20151019182745'),
('20151019185121'),
('20151019193519'),
('20151019204433'),
('20151020174527'),
('20151020180558'),
('20151020184304'),
('20151020190111'),
('20151020192043'),
('20151021193947'),
('20151021195108'),
('20151022174605'),
('20151022191427'),
('20151026183034'),
('20151026183832'),
('20151026184713'),
('20151026190328'),
('20151026193522'),
('20151026201856'),
('20151027200008'),
('20151027213504'),
('20151027213921'),
('20151028194758'),
('20151028203918'),
('20151028204109'),
('20151028205705'),
('20151028211916'),
('20151028212133'),
('20151028213616'),
('20151103191658'),
('20151103193403'),
('20151103200251'),
('20151103202204'),
('20151221090925'),
('20160125112007'),
('20160201160617'),
('20160224185409'),
('20160224185703'),
('20160224190230'),
('20160224190459'),
('20160224190707'),
('20160224191007'),
('20160224191334'),
('20160225183757'),
('20160225184451'),
('20160225184819'),
('20160225185521'),
('20160225185743'),
('20160225190031'),
('20160225191349'),
('20160225191906'),
('20160225192208'),
('20160229080055'),
('20160229110907'),
('20160229145013'),
('20160301072222'),
('20160301072739'),
('20160303085841'),
('20160303092017'),
('20160303093820'),
('20160303100947'),
('20160303102339'),
('20160303111207'),
('20160304075502'),
('20160304083600'),
('20160304085500'),
('20160307192657'),
('20160307205804'),
('20160310185226'),
('20160310195918'),
('20160404185507'),
('20160921081959'),
('20160921085212'),
('20160921085906'),
('20160921091340'),
('20160921094354'),
('20160921102758'),
('20160922074414'),
('20160922084803'),
('20160922090734'),
('20160922092355'),
('20160922095725'),
('20160922101919'),
('20160926084934'),
('20160927075441'),
('20160927082950'),
('20160927092128'),
('20160927095538'),
('20160928073711'),
('20160930074015'),
('20160930082725'),
('20161004074841'),
('20161004083007'),
('20161006091904'),
('20161006093359'),
('20161010175755'),
('20161010181156'),
('20161011180836'),
('20161011200834'),
('20161012175931'),
('20161018194210'),
('20161019181024'),
('20161020190400'),
('20161026180334'),
('20161026184402'),
('20161026191209'),
('20161026200140'),
('20161027174106'),
('20161031201724'),
('20161129214240'),
('20161201190320'),
('20161201191730'),
('20161201194053'),
('20161205195640'),
('20161205203712'),
('20161206185829'),
('20161206193034'),
('20161206202120'),
('20161207190648'),
('20161207194423'),
('20161208085103'),
('20161208091207'),
('20161208095252'),
('20161208095731'),
('20161208101430'),
('20161208104739'),
('20161208130637'),
('20161215191105'),
('20170110190706'),
('20170110200910'),
('20170111190945'),
('20170117193418'),
('20170118191726'),
('20170119194017'),
('20170123185156'),
('20170123213126'),
('20170124190758'),
('20170124200135'),
('20170124202508'),
('20170124210548'),
('20170125191914'),
('20170125203906'),
('20170201191359'),
('20170201195746'),
('20170202201511'),
('20170206191751'),
('20170206193520'),
('20170206195311'),
('20170207184138'),
('20170207192224'),
('20170207200705'),
('20170207203824');


