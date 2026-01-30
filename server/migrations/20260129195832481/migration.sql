BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "magic_link_token" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "magic_link_token" (
    "id" bigserial PRIMARY KEY,
    "token" text NOT NULL,
    "email" text NOT NULL,
    "requestedAt" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "email_index" ON "magic_link_token" USING btree ("email");


--
-- MIGRATION VERSION FOR oisely
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('oisely', '20260129195832481', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129195832481', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260109031533194', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260109031533194', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20250825102351908-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250825102351908-v3-0-0', "timestamp" = now();


COMMIT;
