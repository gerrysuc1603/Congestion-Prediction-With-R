# Congestion Prediction Case
Pada repositori ini berisi aplikasi rshiny dan script untuk memprediksi data yang didapat dari api tomtom yang bisa didapat dari tomtom.com


## Instalasi
- Jalankan Rstudio
- Pilih new project
- Pilih version control
- Pilih Git
- Masukan repository url dan klik ok ( dibutuhkan git terinstal pada komputer )
- Instal beberapa _package_ yang dibutuhkan berikut:
  - XML 
  - dplyr
  - tidyr 
  - shiny 
  - ggmap
  - shinydashboard
  - RCurl

## _Troubleshoot_
Jika skrip `Read.r` mengalami problem, mungkin karena API sudah tidak dapat diakses makan api key dapat didapat pada https://developer.tomtom.com/

## Cara kerja
get api access -> tentukan box koordinat -> Jalankan script read.r untuk mendapatkan data -> jalankan LM.r untuk mendapatkan model -> jalankan shinyApps untuk menjalankan aplikasi
### Data Mining
Untuk mendapatkan data kemacetan sendiri ada beberapa tahap yang harus dilakukan yaitu:
- mendapatkan akses api dari website tomtom untuk mendapatkan data kemacetan
- batasi pencaharian kemacetan dengan mendapat koordinat box yang bisa didapatkan pada website http://bboxfinder.com/
- Setelah mendapatkan box koordinat masukan kedalam parameter url, masukin kan url tersebut kedalam variabel fileUrl yang terdapat pada script read.r`
- Setelah mendapatkan url maka jalankan script read.r untuk mendapatkan data yang dimana data ditarik setiap 2 menit sekali dan akan selesai selama 12 jam, banyaknya interval pengambilan dan lama pengambilan data dapat disesuikan dengan keinginan
- jika selesai data yang dihasilkan sendiri terdapat 2 jenis yaitu dataframe dan berbentuk file csv

### Pemodelan
Pada tahan ini terdapat 2 tahap yaitu :
- membuang data yang tidak diperlukan dan merapikan data
- pemodelan data
Proses membuang dan merapikan data terdiri dari
- mengambil data jalan yang spesifik untuk di prediksi contoh kemacetan dari Tangerang [18] sampai Karang Tengah [11], data kemacetan tersebut dimasukan kedalam data frame xy
- membuang data yang tidak diperlukan untuk melakukan pemodelan contohnya seperti id, longitude, latitude dan sebagainya
- membuang row yang tidak valid
- membuat data frame baru yang berisikan row terakhir dari data frame xy yang sudah dirapikan untuk nantinya akan dipredisik
- selanjutnya menghapus row terakhir pada data frame xy dihapus

Sementara proses pemodelan dilakukan dengan:
- Membuat model dengan menggunakan fungsi linier regresion lm(dl~.,data = xy) untuk menentukan prediksi kemacetan pada suatu waktu
  
- Melakukan prediksi dengan fungsi predict()
  - Fungsi predict(relation,a) sendiri berguna untuk untuk memprediksi dataframe a sesuai dengan model(relasi) yang telah dibuat
  - Hasil prediksi yang didapatkan berupa waktu delay berdasarkan data pada dataframe a
  - Data hasil prediksi dimasukan kedalam dataframe a
  
Setelah pemodelan selesai, data hasil prediksi digabungkan dengan data yang sudah rapi untuk ditampilkan dalam aplikasi Shiny


