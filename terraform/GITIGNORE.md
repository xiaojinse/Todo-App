# terraform/ 目录应添加的 .gitignore 内容

> **操作方式**：在 `terraform/` 目录下手动创建 `.gitignore` 文件，将以下内容复制进去。

```gitignore
# Terraform 状态文件（含敏感数据，绝对不能入库）
terraform.tfstate
terraform.tfstate.backup
*.tfstate
*.tfstate.*

# 含有真实值的变量文件
terraform.tfvars
*.auto.tfvars

# 本地工作目录
.terraform/
.terraform.lock.hcl

# 崩溃日志
crash.log
crash.*.log

# 覆盖文件
override.tf
override.tf.json
*_override.tf
*_override.tf.json
```
