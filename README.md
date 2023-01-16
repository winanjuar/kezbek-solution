# KezBek Solution
## Deskripsi
KezBek Solution merupakan salah satu start up yang memberikan keuntungan kepada pelanggan berupa uang kembalian _(cashback)_ ketika pelanggan melakukan transaksi di merchant yang terdaftar.

Penentuan besarnya _cashback_ yang akan diterima oleh pelanggan mempertimbangkan 2 faktor, yaitu transaksi dan loyalti. 

Secara sistem, KezBek Solution merupakan keseluruhan sistem yang saling terintegrasi satu sama lain dengan mengimplementasikan arsitektur metarepo microservices.

![Metarepo Approach](https://github.com/winanjuar/kezbek-solution/blob/main/documentation/metarepo.jpg?raw=true "Metarepo Approach")

Setiap services memungkinkan untuk menggunakan tech stack yang berbeda. Seperti Service authenticator menggunakan AWS Cognito, service mailer menggunakan AWS SES, service transaction menggunakan PostgreSQL sementara service customer menggunakan MySQL.

![System Architecture](https://github.com/winanjuar/kezbek-solution/blob/main/documentation/arsitektur.jpg?raw=true "System Architecture")

Meskipun tech stack yang digunakan berbeda, namun secara keseluruhan service services ini dapat saling berkomunikasi satu dengan lainnya menggunakan tranport RabbitMQ sehingga dapat menjawab kebutuhan KezBek Solution.

![Communication Strategy](https://github.com/winanjuar/kezbek-solution/blob/main/documentation/communication.jpg?raw=true "Communication Strategy")

Berikut adalah rancangan DB yang ada di KezBek Solution.


```mermaid
erDiagram
LoyaltyTierMaster {
    string id PK
    string name
    int level
    int max_trx
}

LoyaltyTierJourney {
    string current_tier FK
    string next_1
    string prev_1
    string prev_2
}

LoyaltyTierMaster ||--|| LoyaltyTierJourney : has

LoyaltyPointConfig {
    string id PK
    int at_trx
    int point
    string tier_id FK
}

LoyaltyTierMaster ||--o{ LoyaltyPointConfig : has

LoyaltyCustomerActual {
    string customer_id PK
    string transaction_id
    datetime transaction_time
    int point
    int total_trx
    string remark
    string tier_id FK
}

LoyaltyTierMaster ||--o{ LoyaltyCustomerActual : actuals

LoyaltyCustomerHistory {
    string transaction_id PK
    datetime transaction_time
    string customer_id
    int point
    int total_trx
    string remark
    string tier_id FK
}

LoyaltyTierMaster ||--o{ LoyaltyCustomerHistory : histories

PromoProgram {
    string id PK
    string code_key
    int quota
    datetime period_start
    datetime period_end
}

PromoConfig {
    string id PK
    int quantity
    int min_trx
    int max_trx
    decimal prosentase
    string program_id FK
}

PromoProgram ||--o{ PromoConfig : has
```
```mermaid
erDiagram
Customer {
  string id PK
  string cognito_id
  string name
  string username
  string email
  string phone
}

Partner {
  string id PK
  string name
  string api_key
  string api_secret
  string pic_email
  string pic_phone
}

TransactionDetails {
  string transaction_id PK
  string transaction_origin_id
  datetime transaction_time
  string customer_id
  string customer_name
  string customer_email
  string customer_phone
  string tier
  string remark
  int total_trx
  string partner_id
  string partner_api_key
  string partner_name
  int quantity
  int act_trx
  string promo_code
  decimal prosentase
  int point_transaction
  int point_loyalty
  int point_total
}

WalletTransaction {
  string transaction_id PK
  string customer_id
  datetime transaction_time
  string transaction_type
  string transaction_description
  int amount
}

WalletBalanceActual {
  string customer_id PK
  string last_transaction_id
  datetime last_transaction_time
  int current_balance
}

WalletBalanceHistory {
  string transaction_id PK
  datetime transaction_time 
  string customer_id
  int current_balance
}
```


## Running di local
- Karena menggunakan metarepo, lakukan `git clone` pada metareponya kezbek-solution.
- Gunakan `git submodule update --init --recursive` untuk update/fetch submodules.
- Lakukan `npm install` di setiap submodule yang ada atau jika menggunakan linux/macos, dapat langsung running file `setup.sh` yang sudah disiapkan.
- Pada docker compose, environment variable menggunakan file `compose.env` yang sudah disiapkan atau dapat diatur sendiri sesuai kebutuhan di local.
- Jalankan perintah `docker-compose up -d --build`
- Setelah semua service up, dapat langsung dicoba, tentu dengan melakukan loading data terlebih dahulu dengan perintah berikut di folder `sql`

`docker exec -i mysql mysql -uroot -pS3cret db_customer < customer.sql`

`docker exec -i mysql mysql -uroot -pS3cret db_partner < partner.sql`

`docker exec -i mysql mysql -uroot -pS3cret db_promo < promo.sql`

`docker exec -i postgresql psql -U postgres db_loyalty < loyalty.sql`

- Untuk setiap service terdapat documentasi menggunakan swagger, contoh service authenticator: http://localhost:8000/authenticator/apidoc. Untuk detail port yang digunakan adalah sebagai berikut:
1. [Service Authenticator](http://localhost:8000/authenticator/apidoc)
2. [Service Customer](http://localhost:8000/customer/apidoc)
3. [Service Loyalty](http://localhost:8000/loyalty/apidoc)
4. [Service Mailer](http://localhost:8000/mailer/apidoc)
5. [Service Partner](http://localhost:8000/partner/apidoc)
6. [Service Promo](http://localhost:8000/promo/apidoc)
7. [Service Transaction](http://localhost:8000/transaction/apidoc)
8. [Service Wallet](http://localhost:8000/wallet/apidoc)

Contoh container yang sedang running

![Container Running](https://github.com/winanjuar/kezbek-solution/blob/main/documentation/container.jpg?raw=true "Container Running")

## Asumsi
1. Proses transaksi dilakukan di partner
2. Data yang dikirim ke KezBek Solution adalah data transaksi yang sudah complete dari partner. KezBek Solutin menghandle proses perhitungan cashback, transfer balance wallet dan send email notifikasi.

## Referensi

[Creating separate monorepo CI/CD pipelines with GitHub Actions](https://blog.logrocket.com/creating-separate-monorepo-ci-cd-pipelines-github-actions/)

[Monorepo, Manyrepo, Metarepo](https://notes.burke.libbey.me/metarepo/)

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](http://www.gnu.org/licenses/agpl-3.0)
