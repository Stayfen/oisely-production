BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "animal_care_plan" (
    "id" bigserial PRIMARY KEY,
    "animalIdentificationRecordId" bigint NOT NULL,
    "userIdentifier" text NOT NULL,
    "version" bigint NOT NULL,
    "generatedAt" timestamp without time zone NOT NULL,
    "modelName" text NOT NULL,
    "generationConfidence" double precision NOT NULL,
    "summary" text,
    "totalDailyTimeMinutes" bigint NOT NULL,
    "totalWeeklyTimeMinutes" bigint NOT NULL,
    "status" text NOT NULL
);

-- Indexes
CREATE INDEX "animal_care_plan_animal_id_index" ON "animal_care_plan" USING btree ("animalIdentificationRecordId");
CREATE INDEX "animal_care_plan_user_index" ON "animal_care_plan" USING btree ("userIdentifier");
CREATE UNIQUE INDEX "animal_care_plan_version_index" ON "animal_care_plan" USING btree ("animalIdentificationRecordId", "version");
CREATE INDEX "animal_care_plan_status_index" ON "animal_care_plan" USING btree ("status");
CREATE INDEX "animal_care_plan_generated_at_index" ON "animal_care_plan" USING btree ("userIdentifier", "generatedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "care_plan_task" (
    "id" bigserial PRIMARY KEY,
    "carePlanId" bigint NOT NULL,
    "taskType" text NOT NULL,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "estimatedDurationMinutes" bigint NOT NULL,
    "priority" text NOT NULL,
    "suggestedTimeOfDay" text,
    "aiReasoning" text,
    "createdAt" timestamp without time zone NOT NULL,
    "_animalCarePlanTasksAnimalCarePlanId" bigint
);

-- Indexes
CREATE INDEX "care_plan_task_plan_id_index" ON "care_plan_task" USING btree ("carePlanId");
CREATE INDEX "care_plan_task_type_index" ON "care_plan_task" USING btree ("carePlanId", "taskType");
CREATE INDEX "care_plan_task_priority_index" ON "care_plan_task" USING btree ("priority");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "care_plan_task"
    ADD CONSTRAINT "care_plan_task_fk_0"
    FOREIGN KEY("carePlanId")
    REFERENCES "animal_care_plan"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "care_plan_task"
    ADD CONSTRAINT "care_plan_task_fk_1"
    FOREIGN KEY("_animalCarePlanTasksAnimalCarePlanId")
    REFERENCES "animal_care_plan"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR oisely
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('oisely', '20260129223317519', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129223317519', "timestamp" = now();

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
