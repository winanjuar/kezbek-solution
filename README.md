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
- Setup env variables untuk setiap submodule repo sesuai dengan contoh file `compose.env` yang sudah disiapkan.
- Jalankan perintah `docker-compose up`
- Setelah semua service up, dapat langsung dicoba.
- Untuk setiap service terdapat documentasi menggunakan swagger, contoh service authenticator: http://localhost:8001/apidoc. Untuk detail port yang digunakan adalah sebagai berikut:
1. [Service Authenticator](http://localhost:8001/apidoc/)
2. [Service Customer](http://localhost:8002/apidoc/)
3. [Service Loyalty](http://localhost:8003/apidoc/)
4. [Service Mailer](http://localhost:8004/apidoc/)
5. [Service Partner](http://localhost:8005/apidoc/)
6. [Service Promo](http://localhost:8006/apidoc/)
7. [Service Transaction](http://localhost:8007/apidoc/)
8. [Service Wallet](http://localhost:8008/apidoc/)


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
