CREATE TABLE "store" (
  "id" SERIAL PRIMARY KEY,
  "line_id" varchar NOT NULL,
  "store_name" varchar NOT NULL,
  "address" varchar NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz
);
CREATE TABLE "driver" (
  "id" SERIAL PRIMARY KEY,
  "line_id" varchar NOT NULL,
  "driver_name" varchar NOT NULL,
  "car_no" varchar NOT NULL,
  "car_brand" varchar NOT NULL,
  "car_model" varchar NOT NULL,
  "car_color" varchar NOT NULL,
  "phone" varchar,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz
);
CREATE TABLE "ride_order" (
  "id" SERIAL PRIMARY KEY,
  "store_id" integer NOT NULL,
  "rider_name" varchar,
  "driver_id" integer NOT NULL,
  "address_to" varchar,
  "ask_in_time" timestamptz NOT NULL,
  "pick_up_time" timestamptz,
  "get_out_time" timestamptz,
  "status" integer DEFAULT 0,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz,
  "order_type" integer,
  "challenge_at" timestamptz
);
ALTER TABLE "ride_order"
ADD FOREIGN KEY ("store_id") REFERENCES "store" ("id");
ALTER TABLE "ride_order"
ADD FOREIGN KEY ("driver_id") REFERENCES "driver" ("id");