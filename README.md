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
![Database](https://github.com/winanjuar/kezbek-solution/blob/main/documentation/table-1.jpg?raw=true "Database")

![Database](https://github.com/winanjuar/kezbek-solution/blob/main/documentation/table-2.jpg?raw=true "Database")

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
