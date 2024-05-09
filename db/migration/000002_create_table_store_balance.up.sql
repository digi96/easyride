CREATE TABLE "store_balance" (
  "id" SERIAL PRIMARY KEY,
  "store_id" integer NOT NULL,
  "amount" integer NOT NULL,
  "type_id" varchar NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);
ALTER TABLE "store_balance"
ADD FOREIGN KEY ("store_id") REFERENCES "store" ("id");