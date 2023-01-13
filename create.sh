#!/bin/bash
for a in $(seq 2 50)
do
  echo "./neo4j-admin database import incremental --stage=all --auto-skip-subsequent-headers=true --delimiter=","  --skip-duplicate-nodes=true --force \
--nodes=Customer=/home/ddi/header2/head_df_cust.csv,/home/ddi/data/batch$a/df_cust.csv \
--nodes=Company=/home/ddi/header2/head_df_comp.csv,/home/ddi/data/batch$a/df_comp.csv \
--nodes=Product=/home/ddi/header2/head_df_product.csv,/home/ddi/data/batch$a/df_product.csv \
--relationships=MEMBER_OF=/home/ddi/header/rel/head_rel_cust_comp.csv,/home/ddi/data/batch$a/df_cust_comp.csv \
--relationships=HAS_TRANSACTION=/home/ddi/header/rel/head_rel_cust_product.csv,/home/ddi/data/batch$a/trx.csv \
perurigraph" >> import$a.sh
sh import$a.sh
done
