###INITIAL LOAD 
 ./neo4j-admin database import full
 
./neo4j-admin database import full --auto-skip-subsequent-headers=true --delimiter="," --skip-duplicate-nodes=true --overwrite-destination=true --skip-bad-relationships=true \
--nodes=Customer=/home/ddi/header/head_df_cust.csv,/home/ddi/data/batch1/df_cust.csv \
--nodes=Company=/home/ddi/header/head_df_comp.csv,/home/ddi/data/batch1/df_comp.csv \
--nodes=Product=/home/ddi/header/head_df_product.csv,/home/ddi/data/batch1/df_product.csv \
--nodes=Segmen=/home/ddi/header/head_df_segmen.csv,/home/ddi/data/batch1/df_segmen.csv \
--nodes=Sector=/home/ddi/header/head_df_sector.csv,/home/ddi/data/batch1/df_sector.csv \
--relationships=MEMBER_OF=/home/ddi/header/rel/head_rel_cust_comp.csv,/home/ddi/data/batch1/df_cust_comp.csv \
--relationships=HAS_TRANSACTION=/home/ddi/header/rel/head_rel_cust_product.csv,/home/ddi/data/batch1/trx.csv \
--relationships=HAS_SEGMEN=/home/ddi/header/rel/head_rel_comp_segmen.csv,/home/ddi/data/batch1/df_comp.csv \
--relationships=HAS_SECTOR=/home/ddi/header/rel/head_rel_comp_sector.csv,/home/ddi/data/batch1/df_comp.csv \
perurigraph


###CREATE CONSTRAINT

CREATE CONSTRAINT Customer IF NOT EXISTS
FOR (c:Customer) REQUIRE c.customer_id IS UNIQUE;

CREATE CONSTRAINT Company IF NOT EXISTS
FOR (c:Company) REQUIRE c.company_id IS UNIQUE;

CREATE CONSTRAINT Product IF NOT EXISTS
FOR (c:Product) REQUIRE c.product_id IS UNIQUE;

CREATE CONSTRAINT Segmen IF NOT EXISTS
FOR (c:Segmen) REQUIRE c.segmen IS UNIQUE;

CREATE CONSTRAINT Sector IF NOT EXISTS
FOR (c:Sector) REQUIRE c.sector IS UNIQUE



### STOP DATABASE

stop database perurigraph WAIT;


INCREMENTAL LOAD
bin/neo4j-admin database import incremental --stage=all

### create header incremental
customer_id:ID(CUST-ID){label:Customer},phone,province
product_id:ID(PROD-ID){label:Product},product_name
company_id:ID(COMP-ID){label:Company},segmen,sector


./neo4j-admin database import incremental --stage=all --auto-skip-subsequent-headers=true --delimiter=","  --skip-duplicate-nodes=true --force \
--nodes=Customer=/home/ddi/header2/head_df_cust.csv,/home/ddi/data/batch34/df_cust.csv \
--nodes=Company=/home/ddi/header2/head_df_comp.csv,/home/ddi/data/batch34/df_comp.csv \
--nodes=Product=/home/ddi/header2/head_df_product.csv,/home/ddi/data/batch34/df_product.csv \
--relationships=MEMBER_OF=/home/ddi/header/rel/head_rel_cust_comp.csv,/home/ddi/data/batch34/df_cust_comp.csv \
--relationships=HAS_TRANSACTION=/home/ddi/header/rel/head_rel_cust_product.csv,/home/ddi/data/batch34/trx.csv \
perurigraph
