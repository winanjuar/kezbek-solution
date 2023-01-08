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

## Referensi

[Creating separate monorepo CI/CD pipelines with GitHub Actions](https://blog.logrocket.com/creating-separate-monorepo-ci-cd-pipelines-github-actions/)

[Monorepo, Manyrepo, Metarepo](https://notes.burke.libbey.me/metarepo/)

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](http://www.gnu.org/licenses/agpl-3.0)
