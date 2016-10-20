
CREATE TABLE IF NOT EXISTS "T_Status" (
"statusid" INTEGER NOT NULL,
"status" TEXT,
"uid" INTEGER NOT NULL,
PRIMARY KEY("statusid","uid")
);
