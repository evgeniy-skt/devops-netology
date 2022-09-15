terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id  = "b1g6lo2rc5adodj725ug"
  folder_id = "b1g4m1l6jnuj36tuuih8"
  zone      = "ru-central1-a"
}
