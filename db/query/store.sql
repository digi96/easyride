-- name: CreateStore :one
Insert Into store (line_id, store_name, address)
VALUES ($1, $2, $3)
RETURNING *;
-- name: GetStore :one
SELECT *
FROM store
WHERE id = $1
LIMIT 1;
-- name: ListStores :many
SELECT *
FROM store
ORDER BY id
LIMIT $1 OFFSET $2;
-- name: UpdateStore :one
UPDATE store
SET line_id = $2,
  store_name = $3,
  address = $4
WHERE id = $1
RETURNING *;
-- name: DeleteStore :exec
DELETE FROM store
WHERE id = $1;