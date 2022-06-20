resource "google_storage_bucket" "fun_bucket" { //criando um bucket no storage
  name = "fun_bucket_douglas"
}

resource "google_storage_bucket_object" "nasrccodeme" { //subindo o zip com o código para o bucket
  name = "files.zip"
  bucket = google_storage_bucket.fun_bucket.name
  source = "files.zip"
}

resource "google_cloudfunctions_function" "func_from_tf_dt" { //criando a function
  name = "fun-from-tf"
  runtime = "nodejs16"
  description = "minha primeira função pelo script terraform"

  available_memory_mb = 128
  source_archive_bucket = google_storage_bucket.fun_bucket.name
  source_archive_object = google_storage_bucket_object.nasrccodeme.name

  trigger_http = true
  entry_point = "helloWorldtf"
}

resource "google_cloudfunctions_function_iam_member" "allowAccess" { //esse resource é pra liberar o acesso da function para todos
  region = google_cloudfunctions_function.func_from_tf_dt.region
  cloud_function = google_cloudfunctions_function.func_from_tf_dt.name

  role = "roles/cloudfunctions.invoker"
  member = "allUsers"
}