BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "animal_identification_record" (
    "id" bigserial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "species" text NOT NULL,
    "breed" text,
    "confidence" double precision NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "imageSha256" text NOT NULL,
    "modelName" text NOT NULL
);

-- Indexes
CREATE INDEX "animal_identification_user_created_at_index" ON "animal_identification_record" USING btree ("userIdentifier", "createdAt");
CREATE INDEX "animal_identification_species_index" ON "animal_identification_record" USING btree ("species");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "behavior_analysis_result" (
    "id" bigserial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "requestId" text NOT NULL,
    "videoSha256" text NOT NULL,
    "videoDurationSeconds" double precision NOT NULL,
    "identifiedSpecies" text,
    "identifiedBreed" text,
    "activityLevel" text NOT NULL,
    "emotionalState" text NOT NULL,
    "behaviorPatternsJson" text NOT NULL,
    "movementSummary" text NOT NULL,
    "postureSummary" text NOT NULL,
    "vocalizationSummary" text NOT NULL,
    "movementPatternsJson" text NOT NULL,
    "vocalizationPatternsJson" text NOT NULL,
    "keyFramesJson" text NOT NULL,
    "analysisConfidence" double precision NOT NULL,
    "modelName" text NOT NULL,
    "modelResponseCiphertext" text NOT NULL,
    "modelResponseNonce" text NOT NULL,
    "modelResponseMac" text NOT NULL
);

-- Indexes
CREATE INDEX "behavior_analysis_user_created_at_index" ON "behavior_analysis_result" USING btree ("userIdentifier", "createdAt");
CREATE INDEX "behavior_analysis_species_index" ON "behavior_analysis_result" USING btree ("identifiedSpecies");


--
-- MIGRATION VERSION FOR oisely
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('oisely', '20260129220526898', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129220526898', "timestamp" = now();

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
