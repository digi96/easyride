-- name: CreateStoreBalance :one
Insert Into store_balance (store_id, amount, type_id)
VALUES ($1, $2, $3)
RETURNING *;
-- name: GetStoreBalance :one
SELECT *
FROM store_balance
WHERE id = $1
LIMIT 1;
-- name: ListStoreBalances :many
SELECT *
FROM store_balance
WHERE store_id = $1
ORDER BY id;