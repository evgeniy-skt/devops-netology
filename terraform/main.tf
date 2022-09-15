data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_vpc_network" "net" {
  name = "net"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet"
  network_id     = resource.yandex_vpc_network.net.id
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
}

resource "yandex_compute_instance" "node01" {
  name                      = "node01"
  zone                      = "ru-central1-a"
  hostname                  = "node01.netology.cloud"
  allow_stopping_for_update = true
  count = local.news_instance_count[terraform.workspace]
  # instance_type = terraform.workspace == "prod"
  #                 ? "m4.large"
  #                 : "t2.micro"
  lifecycle {
    create_before_destroy = true
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = data.yandex_compute_image.ubuntu.id
      name        = "root-node01"
      type        = "network-nvme"
      size        = "50"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }
}

  resource "yandex_compute_instance" "node02" {
    name                      = "node02"
    zone                      = "ru-central1-a"
    hostname                  = "node02.netology.cloud"
    for_each      = var.instances

    resources {
      cores  = 2
      memory = 2
    }

    boot_disk {
      initialize_params {
        image_id    = data.yandex_compute_image.ubuntu.id
        name        = "root-node02"
        type        = "network-nvme"
        size        = "50"
      }
    }

    network_interface {
      subnet_id = yandex_vpc_subnet.subnet.id
      nat       = true
    }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

locals{
  news_instance_count = {
  default = 1
  stage = 1
  prod = 2
}
}

variable "instances" {
  type        = map
  default     = {
    node_1 = {
      name                    = "foreach_node_1"
    },
    node_2 = {
      name                    = "foreach_node_2"
    }
  }
}
