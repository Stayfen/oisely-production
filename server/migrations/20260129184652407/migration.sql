BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "magic_link_token" (
    "id" bigserial PRIMARY KEY,
    "token" text NOT NULL,
    "email" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "token_index" ON "magic_link_token" USING btree ("token");


--
-- MIGRATION VERSION FOR oisely
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('oisely', '20260129184652407', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129184652407', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260109031533194', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260109031533194', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
