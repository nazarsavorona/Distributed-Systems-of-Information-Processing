# Database Performance Comparison

## Performance Table

| No | Query Description                                             | Columnstore     | Relational     |
|----|---------------------------------------------------------------|-----------------|----------------|
| 1  | Quantity of goods sold                                        | _**0.097729**_  | 0.159233       |
| 2  | Cost of goods sold                                            | _**0.107194**_  | 0.184494       |
| 3  | Goods sold for the period                                     | _**0.113351**_  | 0.230045       |
| 4  | How much of product A was purchased in the shop B in period C | 0.104410        | _**0.003205**_ |
| 5  | Amount of product A purchased in all stores during period C   | 0.076460        | _**0.003130**_ |
| 6  | Total revenue of all stores during a specified period         | _**0.159580**_  | 0.287953       |
| 7  | Top 10 purchases of two products in period C                  | _**0.658389**_  | 5.637651       |
| 8  | Top 10 purchases of three products in period C                | _**3.583737**_  | 25.435097      |
| 9  | Top 10 purchases of four products in period C                 | _**32.751324**_ | 56.413401      |

## Columnstore Database:

- Particularly effective in handling complex queries that involve large-scale aggregations and multiple join
  operations (queries 7-9). Its architecture allows efficient querying over large datasets, making it suitable for
  analytical and reporting applications where such operations are common.
- Less efficient for simple, selective queries that retrieve small amounts of data or require rapid
  transactional processing (queries 1-6).

## Relational Database:

- Shows superior performance in transaction-oriented queries and those requiring precise data retrieval (queries 4 and
  5). It benefits significantly from index usage, which speeds up data access for queries that target specific rows or
  small datasets.
- When faced with complex analytical queries that involve extensive data scanning and aggregation across multiple
  tables, it tends to underperform compared to columnstore databases (queries 7-9).

## Conclusion

**Columnstore Databases** are recommended for analytical processes where complex queries involving massive data
aggregation and processing are common.

**Relational Databases** are suited for applications requiring high performance in transaction processing and
operational querying, especially where data access is indexed and focused on small, specific datasets.