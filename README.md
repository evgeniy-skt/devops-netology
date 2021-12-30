# devops-netology
В дирректории `Terraform` будут проигнорированы
- Все директории `.terraform` на любом уровне вложенности
- Все файлы с расширением `.tfstate` (даже те, где эта строка будет встречаться не в конце имени файла)
- Все файлы с расширением `.tfvars`
- Файлы `override.tf`, `override.tf.json`, и все файлы с суффиксами `_override.tf`, `_override.tf.json`
- Файлы `.terraformrc`, `terraform.rc`