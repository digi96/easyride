package db

import (
	"context"
	"database/sql"
	"testing"
	"time"

	"github.com/digi96/easyride/util"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func CreateRandomStore(t *testing.T) Store {
	arg := CreateStoreParams{
		LineID:    util.RandomLineID(),
		StoreName: util.RandomStoreName(),
		Address:   util.RandomAddress(),
	}

	store, err := testQueries.CreateStore(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, store)

	require.Equal(t, arg.LineID, store.LineID)
	require.Equal(t, arg.StoreName, store.StoreName)
	require.Equal(t, arg.Address, store.Address)

	require.NotZero(t, store.ID)
	require.NotZero(t, store.CreatedAt)

	return store
}

func TestCreateStore(t *testing.T) {
	CreateRandomStore(t)
}

func TestGetStore(t *testing.T) {
	store1 := CreateRandomStore(t)
	store2, err := testQueries.GetStore(context.Background(), store1.ID)
	require.NoError(t, err)
	require.NotEmpty(t, store2)

	require.Equal(t, store1.ID, store2.ID)
	require.Equal(t, store1.LineID, store2.LineID)
	require.Equal(t, store1.StoreName, store2.StoreName)
	require.Equal(t, store1.Address, store2.Address)
	require.WithinDuration(t, store1.CreatedAt, store2.CreatedAt, time.Second)

}

func TestUpdateStore(t *testing.T) {
	store1 := CreateRandomStore(t)

	arg := UpdateStoreParams{
		ID:        store1.ID,
		LineID:    store1.LineID,
		StoreName: "X plate",
		Address:   store1.Address,
	}

	store2, err := testQueries.UpdateStore(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, store2)

	require.Equal(t, store1.ID, store2.ID)
	require.Equal(t, store1.LineID, store2.LineID)
	require.Equal(t, arg.StoreName, store2.StoreName)
	require.Equal(t, store1.Address, store2.Address)
	require.WithinDuration(t, store1.CreatedAt, store2.CreatedAt, time.Second)

}

func TestDeleteStore(t *testing.T) {
	store1 := CreateRandomStore(t)

	err := testQueries.DeleteStore(context.Background(), store1.ID)
	require.NoError(t, err)

	store2, err := testQueries.GetStore(context.Background(), store1.ID)
	require.Error(t, err)
	require.EqualError(t, err, sql.ErrNoRows.Error())
	require.Empty(t, store2)

}

func TestListStore(t *testing.T) {
	arg := ListStoresParams{
		Limit:  5,
		Offset: 5,
	}

	for i := 0; i < 10; i++ {
		CreateRandomStore(t)
	}

	stores, err := testQueries.ListStores(context.Background(), arg)

	if assert.Nil(t, err) {
		require.NotEmpty(t, stores)
	}

	require.NoError(t, err)
	require.NotEmpty(t, stores)
	require.Len(t, stores, 5)

	for _, store := range stores {
		require.NotEmpty(t, store)
	}

	for _, store := range stores {
		err := testQueries.DeleteStore(context.Background(), store.ID)
		require.NoError(t, err)
	}
}
