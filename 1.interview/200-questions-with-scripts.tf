200 Terraform Interview Q&A
1. What is Terraform?
Terraform is an open-source infrastructure as code (IaC) tool developed by HashiCorp that allows
users to define and provision data center infrastructure using a high-level configuration language
called HCL (HashiCorp Configuration Language) or JSON.
Example:
provider "aws" {
region = "us-west-2"
}
resource "aws_instance" "example" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
}
2. What are the main features of Terraform?
Terraform's main features include Infrastructure as Code (IaC), execution plans, resource graphs,
change automation, and state management.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
3. What is the difference between Terraform and other IaC tools like
Ansible, Puppet, and Chef?
Terraform focuses on infrastructure provisioning, is declarative, and uses HCL. Tools like Ansible,
Puppet, and Chef focus on configuration management and are procedural.
Example:
resource "aws_instance" "example" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
}
4. What is a provider in Terraform?
A provider is a plugin that Terraform uses to manage an external API. Providers define the
resources and data sources available.
Example:
provider "aws" {
region = "us-west-2"
}
5. How does Terraform manage dependencies?
Terraform uses a dependency graph to manage dependencies between resources. It
automatically understands the order of operations needed based on resource dependencies.
Example:
resource "aws_instance" "web" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
subnet_id = aws_subnet.example.id
}
resource "aws_subnet" "example" {
vpc_id = aws_vpc.example.id
cidr_block = "10.0.1.0/24"
}
resource "aws_vpc" "example" {
cidr_block = "10.0.0.0/16"
}
6. What is a state file in Terraform?
A state file is a file that Terraform uses to keep track of the current state of the infrastructure. It
maps the resources defined in the configuration to the real-world resources.
Example:
terraform show
7. Why is it important to manage the state file in Terraform?
Managing the state file is crucial because it ensures consistency between the infrastructure's real
state and the configuration. It also enables features like change detection and planning.
Example:
terraform init
8. How can you secure the state file in Terraform?
State files can be secured by storing them in remote backends with proper access controls and
encryption, such as AWS S3 with server-side encryption and access control policies.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
encrypt = true
}
}
9. What are modules in Terraform?
Modules are reusable packages of Terraform configurations that can be shared and composed to
manage resources efficiently.
Example:
module "vpc" {
source = "./modules/vpc"
}
10. What is the purpose of the terraform init command?
terraform init initializes a working directory containing Terraform configuration files,
downloads the necessary provider plugins, and prepares the environment.
Example:
terraform init
11. What does the terraform plan command do?
terraform plan creates an execution plan, showing what actions Terraform will take to achieve
the desired state defined in the configuration.
Example:
terraform plan
12. What is the terraform apply command used for?
terraform apply applies the changes required to reach the desired state of the configuration.
It executes the plan created by terraform plan.
Example:
terraform apply
13. What is the purpose of the terraform destroy command?
terraform destroy is used to destroy the infrastructure managed by Terraform. It removes all
the resources defined in the configuration.
Example:
terraform destroy
14. How do you define and use variables in Terraform?
Variables in Terraform are defined using the variable block and can be used by referring to
them with var.<variable_name>.
Example:
variable "instance_type" {
description = "Type of EC2 instance"
default = "t2.micro"
}
resource "aws_instance" "example" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = var.instance_type
}
15. What are output values in Terraform and how are they used?
Output values are used to extract information from the resources and make it accessible after
the apply phase. They can be used to output resource attributes.
Example:
output "instance_id" {
value = aws_instance.example.id
}
16. How do you manage different environments (e.g., dev, prod) in
Terraform?
Different environments can be managed using workspaces or separate directories with different
variable files and state files.
Example:
terraform workspace new dev
terraform workspace new prod
17. What is remote state and how do you configure it in Terraform?
Remote state allows Terraform to store the state file in a remote storage backend, enabling team
collaboration and secure storage.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
18. How do you import existing resources into Terraform?
Existing resources can be imported using the terraform import command, which maps the
existing resource to a Terraform resource in the state file.
Example:
terraform import aws_instance.example i-1234567890abcdef0
19. What are data sources in Terraform?
Data sources allow Terraform to fetch data from existing infrastructure or services to use in
resource definitions.
Example:
data "aws_ami" "example" {
most_recent = true
owners = ["amazon"]
filter {
name = "name"
values = ["amzn-ami-hvm-*"]
}
}
20. What are provisioners in Terraform?
Provisioners are used to execute scripts or commands on a local or remote machine as part of
the resource lifecycle.
Example:
resource "aws_instance" "example" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
provisioner "local-exec" {
command = "echo ${self.public_ip} > ip_address.txt"
}
}
21. How do you handle secrets in Terraform?
Secrets can be managed using environment variables, secure secret management services (e.g.,
AWS Secrets Manager), or Terraform's sensitive attribute.
Example:
resource "aws_secretsmanager_secret" "example" {
name = "example"
description = "An example secret"
}
resource "aws_secretsmanager_secret_version" "example" {
secret_id = aws_secretsmanager_secret.example.id
secret_string = jsonencode({
username = "example_user"
password = "example_password"
})
}
22. What is a backend in Terraform?
A backend in Terraform defines where and how state is loaded and stored. It can be local or
remote (e.g., S3, Consul, etc.).
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
23. How do you use conditional expressions in Terraform?
Conditional expressions in Terraform are used to assign values based on conditions using the
ternary operator condition ? true_value : false_value.
Example:
variable "environment" {
default = "dev"
}
resource "aws_instance" "example" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = var.environment == "prod" ? "t2.large" : "t2.micro"
}
24. What is the purpose of the terraform validate command?
terraform validate is used to validate the syntax and configuration of the Terraform files
without creating any resources.
Example:
terraform validate
25. How can you format Terraform configuration files?
Terraform configuration files can be formatted using the terraform fmt command, which
formats the files according to the
Terraform style guide.
Example:
terraform fmt
26. What is the difference between count and for_each in Terraform?
count is used to create multiple instances of a resource, while for_each is used to iterate over a
map or set of values to create multiple instances.
Example (count):
resource "aws_instance" "example" {
count = 3
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
}
Example (for_each):
resource "aws_instance" "example" {
for_each = toset(["instance1", "instance2"])
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
tags = {
Name = each.key
}
}
27. How do you use loops in Terraform?
Loops in Terraform can be implemented using the count and for_each meta-arguments, as
well as the for expression in variable assignments.
Example:
variable "instance_names" {
type = list(string)
default = ["instance1", "instance2"]
}
resource "aws_instance" "example" {
for_each = toset(var.instance_names)
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
tags = {
Name = each.key
}
}
28. What are locals in Terraform and how do you use them?
Locals in Terraform are used to define local values that can be reused within a module. They help
avoid repetition and make configurations more readable.
Example:
locals {
instance_type = "t2.micro"
ami_id = "ami-0c55b159cbfafe1f0"
}
resource "aws_instance" "example" {
ami = local.ami_id
instance_type = local.instance_type
}
29. What is the purpose of the terraform taint command?
terraform taint marks a resource for recreation on the next terraform apply. It is useful
when a resource needs to be replaced due to a manual change or corruption.
Example:
terraform taint aws_instance.example
30. How do you manage module versioning in Terraform?
Module versioning in Terraform can be managed using the version argument in
the source attribute of a module block, typically in combination with a registry.
Example:
module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "2.0.0"
}
31. What is the Terraform Registry?
The Terraform Registry is a public repository of Terraform modules and providers that can be
used to discover and use pre-built modules and providers.
Example:
module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "2.0.0"
}
32. How do you perform a dry run in Terraform?
A dry run in Terraform can be performed using the terraform plan command, which shows
the execution plan without making any changes.
Example:
terraform plan
33. What is the terraform state command used for?
The terraform state command is used to manage and manipulate the state file. It provides
subcommands to move, remove, list, and inspect resources in the state file.
Example:
terraform state list
34. How do you rename a resource in the state file?
A resource can be renamed in the state file using the terraform state mv command, which
moves the state of a resource to a new address.
Example:
terraform state mv aws_instance.old_name aws_instance.new_name
35. What is the purpose of the terraform workspace command?
The terraform workspace command is used to manage multiple workspaces, allowing for
different states to be associated with the same configuration.
Example:
terraform workspace new dev
terraform workspace select dev
36. How do you debug Terraform configurations?
Debugging Terraform configurations can be done using the TF_LOG environment variable to set
the log level and the terraform console command to interact with the configuration.
Example:
export TF_LOG=DEBUG
terraform apply
37. What is the difference between local and remote backends in
Terraform?
Local backends store the state file on the local filesystem, while remote backends store the state
file in a remote storage service (e.g., S3, Consul).
Example (local backend):
terraform {
backend "local" {
path = "terraform.tfstate"
}
}
Example (remote backend):
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
38. How do you handle provider versioning in Terraform?
Provider versioning in Terraform is managed using the required_providers block in
the terraform block, specifying the version constraints.
Example:
terraform {
required_providers {
aws = {
source = "hashicorp/aws"
version = "~> 3.0"
}
}
}
39. What is the purpose of the terraform refresh command?
terraform refresh updates the state file with the current state of the infrastructure without
making any changes to the configuration.
Example:
terraform refresh
40. How do you generate and view a resource graph in Terraform?
A resource graph can be generated using the terraform graph command and can be viewed
using tools like Graphviz.
Example:
terraform graph | dot -Tpng > graph.png
41. What are lifecycle blocks in Terraform?
lifecycle blocks in Terraform are used to customize the lifecycle of a resource, such as creating
before destroying, ignoring changes, and preventing deletion.
Example:
resource "aws_instance" "example" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
lifecycle {
create_before_destroy = true
}
}
42. How do you ignore changes to a resource attribute in Terraform?
Changes to a resource attribute can be ignored using the ignore_changes argument in
a lifecycle block.
Example:
resource "aws_instance" "example" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
lifecycle {
ignore_changes = [ami]
}
}
43. What is the terraform import command used for?
terraform import is used to import existing infrastructure into Terraform's state file, mapping
it to resources defined in the configuration.
Example:
terraform import aws_instance.example i-1234567890abcdef0
44. How do you use output values across different modules in Terraform?
Output values from one module can be referenced in another module by using the module's
output attributes.
Example:
module "vpc" {
source = "./modules/vpc"
}
output "vpc_id" {
value = module.vpc.vpc_id
}
45. What is the difference between terraform output and output values in
configuration?
terraform output is a command that displays the output values of a Terraform configuration,
while output values in configuration are defined using the output block.
Example (command):
terraform output
Example (configuration):
output "instance_id" {
value = aws_instance.example.id
}
46. What are dynamic blocks in Terraform?
Dynamic blocks in Terraform are used to generate multiple nested blocks within a resource or
module based on dynamic content.
Example:
resource "aws_security_group" "example" {
name = "example-sg"
description = "Example security group"
dynamic "ingress" {
for_each = var.ingress_rules
content {
from_port = ingress.value.from_port
to_port = ingress.value.to_port
protocol = ingress.value.protocol
cidr_blocks = ingress.value.cidr_blocks
}
}
}
47. How do you define and use maps in Terraform?
Maps in Terraform are defined using the map type and can be used to store key-value pairs. They
are accessed using the key.
Example:
variable "ami_ids" {
type = map(string)
default = {
us-east-1 = "ami-0c55b159cbfafe1f0"
us-west-2 = "ami-0d5eff06f840b45e9"
}
}
resource "aws_instance" "example" {
ami = var.ami_ids[var.region]
instance_type = "t2.micro"
}
48. What is a count parameter in Terraform?
The
count parameter in Terraform is used to create multiple instances of a resource based on a
specified number.
Example:
resource "aws_instance" "example" {
count = 3
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
}
49. What are Terraform Cloud and Terraform Enterprise?
Terraform Cloud and Terraform Enterprise are commercial versions of Terraform that provide
collaboration, governance, and automation features.
Example:
terraform {
backend "remote" {
organization = "my-org"
workspaces {
name = "my-workspace"
}
}
}
50. How do you use a Terraform backend?
A backend is configured using the terraform block in the configuration file, specifying the
backend type and its configuration.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
51. What is the terraform fmt command used for?
terraform fmt formats the configuration files to follow the Terraform style guide, making the
code consistent and readable.
Example:
terraform fmt
52. How do you use a lock file in Terraform?
A lock file (.terraform.lock.hcl) is used to lock provider versions, ensuring consistency in
provider versions across different environments.
Example:
terraform init
53. What is the purpose of the terraform workspace command?
The terraform workspace command is used to create, select, and manage multiple
workspaces, allowing different states to be associated with the same configuration.
Example:
terraform workspace new dev
terraform workspace select dev
54. How do you manage secrets in Terraform?
Secrets can be managed using environment variables, secure secret management services (e.g.,
AWS Secrets Manager), or Terraform's sensitive attribute.
Example:
resource "aws_secretsmanager_secret" "example" {
name = "example"
description = "An example secret"
}
resource "aws_secretsmanager_secret_version" "example" {
secret_id = aws_secretsmanager_secret.example.id
secret_string = jsonencode({
username = "example_user"
password = "example_password"
})
}
55. What is the terraform console command used for?
terraform console opens an interactive console for evaluating expressions, testing
interpolation syntax, and debugging configurations.
Example:
terraform console
56. How do you reference data sources in Terraform?
Data sources are referenced using the data block and can be used to fetch information about
existing infrastructure or services.
Example:
data "aws_ami" "example" {
most_recent = true
owners = ["amazon"]
filter {
name = "name"
values = ["amzn-ami-hvm-*"]
}
}
resource "aws_instance" "example" {
ami = data.aws_ami.example.id
instance_type = "t2.micro"
}
57. What is the purpose of the terraform state mv command?
terraform state mv moves a resource in the state file to a new address, useful for renaming
resources without recreating them.
Example:
terraform state mv aws_instance.old_name aws_instance.new_name
58. How do you use conditional expressions in Terraform?
Conditional expressions in Terraform are used to assign values based on conditions using the
ternary operator condition ? true_value : false_value.
Example:
variable "environment" {
default = "dev"
}
resource "aws_instance" "example" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = var.environment == "prod" ? "t2.large" : "t2.micro"
}
59. What is the terraform taint command used for?
terraform taint marks a resource for recreation on the next terraform apply. It is useful
when a resource needs to be replaced due to a manual change or corruption.
Example:
terraform taint aws_instance.example
60. How do you define and use maps in Terraform?
Maps in Terraform are defined using the map type and can be used to store key-value pairs. They
are accessed using the key.
Example:
variable "ami_ids" {
type = map(string)
default = {
us-east-1 = "ami-0c55b159cbfafe1f0"
us-west-2 = "ami-0d5eff06f840b45e9"
}
}
resource "aws_instance" "example" {
ami = var.ami_ids[var.region]
instance_type = "t2.micro"
}
61. How do you handle provider versioning in Terraform?
Provider versioning in Terraform is managed using the required_providers block in
the terraform block, specifying the version constraints.
Example:
terraform {
required_providers {
aws = {
source = "hashicorp/aws"
version = "~> 3.0"
}
}
}
62. What is the purpose of the terraform refresh command?
terraform refresh updates the state file with the current state of the infrastructure without
making any changes to the configuration.
Example:
terraform refresh
63. What are lifecycle blocks in Terraform?
lifecycle blocks in Terraform are used to customize the lifecycle of a resource, such as creating
before destroying, ignoring changes, and preventing deletion.
Example:
resource "aws_instance" "example" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
lifecycle {
create_before_destroy = true
}
}
64. How do you use loops in Terraform?
Loops in Terraform can be implemented using the count and for_each meta-arguments, as
well as the for expression in variable assignments.
Example:
variable "instance_names" {
type = list(string)
default = ["instance1", "instance2"]
}
resource "aws_instance" "example" {
for_each = toset(var.instance_names)
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
tags = {
Name = each.key
}
}
65. What is the terraform import command used for?
terraform import is used to import existing infrastructure into Terraform's state file, mapping
it to resources defined in the configuration.
Example:
terraform import aws_instance.example i-1234567890abcdef0
66. How do you use output values across different modules in Terraform?
Output values from one module can be referenced in another module by using the module's
output attributes.
Example:
module "vpc" {
source = "./modules/vpc"
}
output "vpc_id" {
value = module.vpc.vpc_id
}
67. What is the difference between terraform output and output values in
configuration?
terraform output is a command that displays the output values of a Terraform configuration,
while output values in configuration are defined using the output block.
Example (command):
terraform output
Example (configuration):
output "instance_id" {
value = aws_instance.example.id
}
68. What are dynamic blocks in Terraform?
Dynamic blocks in Terraform are used to generate multiple nested blocks within a resource or
module based on dynamic content.
Example:
resource "aws_security_group" "example" {
name = "example-sg"
description = "Example security group"
dynamic "ingress" {
for_each = var.ingress_rules
content {
from_port = ingress.value.from_port
to_port = ingress.value.to_port
protocol = ingress.value.protocol
cidr_blocks = ingress.value.cidr_blocks
}
}
}
69. How do you manage different environments (e.g., dev, prod) in
Terraform?
Different environments can be managed using workspaces or separate directories with different
variable files and state files.
Example:
terraform workspace new dev
terraform workspace new prod
70. How do you handle secrets in Terraform?
Secrets can be managed using environment variables, secure secret management services (e.g.,
AWS Secrets Manager), or Terraform's sensitive attribute.
Example:
resource "aws_secretsmanager_secret" "example" {
name = "example"
description = "An example secret"
}
resource "aws_secretsmanager_secret_version" "example" {
secret_id = aws_secretsmanager_secret.example.id
secret_string = jsonencode({
username = "example_user"
password = "example_password"
})
}
71. What is the terraform console command used for?
terraform console opens an interactive console for evaluating expressions, testing
interpolation syntax, and debugging
configurations.
Example:
terraform console
72. How do you reference data sources in Terraform?
Data sources are referenced using the data block and can be used to fetch information about
existing infrastructure or services.
Example:
data "aws_ami" "example" {
most_recent = true
owners = ["amazon"]
filter {
name = "name"
values = ["amzn-ami-hvm-*"]
}
}
resource "aws_instance" "example" {
ami = data.aws_ami.example.id
instance_type = "t2.micro"
}
73. What is the purpose of the terraform state mv command?
terraform state mv moves a resource in the state file to a new address, useful for renaming
resources without recreating them.
Example:
terraform state mv aws_instance.old_name aws_instance.new_name
74. What is a backend in Terraform?
A backend in Terraform defines where and how state is loaded and stored. It can be local or
remote (e.g., S3, Consul, etc.).
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
75. How do you secure the state file in Terraform?
State files can be secured by storing them in remote backends with proper access controls and
encryption, such as AWS S3 with server-side encryption and access control policies.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
encrypt = true
}
}
76. What is the difference between local and remote backends in
Terraform?
Local backends store the state file on the local filesystem, while remote backends store the state
file in a remote storage service (e.g., S3, Consul).
Example (local backend):
terraform {
backend "local" {
path = "terraform.tfstate"
}
}
Example (remote backend):
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
77. How do you manage module versioning in Terraform?
Module versioning in Terraform can be managed using the version argument in
the source attribute of a module block, typically in combination with a registry.
Example:
module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "2.0.0"
}
78. What is the Terraform Registry?
The Terraform Registry is a public repository of Terraform modules and providers that can be
used to discover and use pre-built modules and providers.
Example:
module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "2.0.0"
}
79. How do you generate and view a resource graph in Terraform?
A resource graph can be generated using the terraform graph command and can be viewed
using tools like Graphviz.
Example:
terraform graph | dot -Tpng > graph.png
80. What is the purpose of the terraform validate command?
terraform validate is used to validate the syntax and configuration of the Terraform files
without creating any resources.
Example:
terraform validate
81. What is the terraform fmt command used for?
terraform fmt formats the configuration files to follow the Terraform style guide, making the
code consistent and readable.
Example:
terraform fmt
82. What are locals in Terraform and how do you use them?
Locals in Terraform are used to define local values that can be reused within a module. They help
avoid repetition and make configurations more readable.
Example:
locals {
instance_type = "t2.micro"
ami_id = "ami-0c55b159cbfafe1f0"
}
resource "aws_instance" "example" {
ami = local.ami_id
instance_type = local.instance_type
}
83. How do you handle provider dependencies in Terraform?
Provider dependencies in Terraform are managed using the required_providers block in
the terraform block, specifying the version constraints.
Example:
terraform {
required_providers {
aws = {
source = "hashicorp/aws"
version = "~> 3.0"
}
}
}
84. What is the terraform apply command used for?
terraform apply applies the changes required to reach the desired state of the configuration.
It executes the plan created by terraform plan.
Example:
terraform apply
85. What is the terraform destroy command used for?
terraform destroy is used to destroy the infrastructure managed by Terraform. It removes all
the resources defined in the configuration.
Example:
terraform destroy
86. What are output values in Terraform and how are they used?
Output values are used to extract information from the resources and make it accessible after
the apply phase. They can be used to output resource attributes.
Example:
output "instance_id" {
value = aws_instance.example.id
}
87. How do you manage different environments (e.g., dev, prod) in
Terraform?
Different environments can be managed using workspaces or separate directories with different
variable files and state files.
Example:
terraform workspace new dev
terraform workspace new prod
88. What is the difference between count and for_each in Terraform?
count is used to create multiple instances of a resource, while for_each is used to iterate over a
map or set of values to create multiple instances.
Example (count):
resource "aws_instance" "example" {
count = 3
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
}
Example (for_each):
resource "aws_instance" "example" {
for_each = toset(["instance1", "instance2"])
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
tags = {
Name = each.key
}
}
89. How do you use loops in Terraform?
Loops in Terraform can be implemented using the count and for_each meta-arguments, as
well as the for expression in variable assignments.
Example:
variable "instance_names" {
type = list(string)
default = ["instance1", "instance2"]
}
resource "aws_instance" "example" {
for_each = toset(var.instance_names)
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
tags = {
Name = each.key
}
}
90. What is a count parameter in Terraform?
The count parameter in Terraform is used to create multiple instances of a resource based on a
specified number.
Example:
resource "aws_instance" "example" {
count = 3
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
}
91. What are Terraform Cloud and Terraform Enterprise?
Terraform Cloud and Terraform Enterprise are commercial versions of Terraform that provide
collaboration, governance, and automation features.
Example:
terraform {
backend "remote" {
organization = "my-org"
workspaces {
name = "my-workspace"
}
}
}
92. How do you use a Terraform backend?
A backend is configured using the terraform block in the configuration file, specifying the
backend type and its configuration.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
93. What is the terraform fmt command used for?
terraform fmt formats the configuration files to follow the Terraform style guide, making the
code consistent and readable.
Example:
terraform fmt
94. How do you use a lock file in Terraform?
A lock file (.terraform.lock.hcl) is used to lock provider versions, ensuring consistency in
provider versions across different environments.
Example:
terraform init
95. What is the purpose of the terraform workspace command?
The terraform workspace command is used to create, select, and manage multiple
workspaces, allowing different states to be associated with the same configuration.
Example:
terraform workspace new dev
terraform workspace select dev
96. **How do you manage secrets
in Terraform?**
Secrets can be managed using environment variables, secure secret management services (e.g.,
AWS Secrets Manager), or Terraform's sensitive attribute.
Example:
resource "aws_secretsmanager_secret" "example" {
name = "example"
description = "An example secret"
}
resource "aws_secretsmanager_secret_version" "example" {
secret_id = aws_secretsmanager_secret.example.id
secret_string = jsonencode({
username = "example_user"
password = "example_password"
})
}
97. What is the terraform console command used for?
terraform console opens an interactive console for evaluating expressions, testing
interpolation syntax, and debugging configurations.
Example:
terraform console
98. How do you reference data sources in Terraform?
Data sources are referenced using the data block and can be used to fetch information about
existing infrastructure or services.
Example:
data "aws_ami" "example" {
most_recent = true
owners = ["amazon"]
filter {
name = "name"
values = ["amzn-ami-hvm-*"]
}
}
resource "aws_instance" "example" {
ami = data.aws_ami.example.id
instance_type = "t2.micro"
}
99. What is the purpose of the terraform state mv command?
terraform state mv moves a resource in the state file to a new address, useful for renaming
resources without recreating them.
Example:
terraform state mv aws_instance.old_name aws_instance.new_name
100. What is a backend in Terraform?
A backend in Terraform defines where and how state is loaded and stored. It can be local or
remote (e.g., S3, Consul, etc.).
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
101. How do you secure the state file in Terraform?
State files can be secured by storing them in remote backends with proper access controls and
encryption, such as AWS S3 with server-side encryption and access control policies.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
encrypt = true
}
}
102. What is the difference between local and remote backends in
Terraform?
Local backends store the state file on the local filesystem, while remote backends store the state
file in a remote storage service (e.g., S3, Consul).
Example (local backend):
terraform {
backend "local" {
path = "terraform.tfstate"
}
}
Example (remote backend):
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
103. How do you manage module versioning in Terraform?
Module versioning in Terraform can be managed using the version argument in
the source attribute of a module block, typically in combination with a registry.
Example:
module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "2.0.0"
}
104. What is the Terraform Registry?
The Terraform Registry is a public repository of Terraform modules and providers that can be
used to discover and use pre-built modules and providers.
Example:
module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "2.0.0"
}
105. How do you generate and view a resource graph in Terraform?
A resource graph can be generated using the terraform graph command and can be viewed
using tools like Graphviz.
Example:
terraform graph | dot -Tpng > graph.png
106. What is the purpose of the terraform validate command?
terraform validate is used to validate the syntax and configuration of the Terraform files
without creating any resources.
Example:
terraform validate
107. What is the terraform fmt command used for?
terraform fmt formats the configuration files to follow the Terraform style guide, making the
code consistent and readable.
Example:
terraform fmt
108. What are locals in Terraform and how do you use them?
Locals in Terraform are used to define local values that can be reused within a module. They help
avoid repetition and make configurations more readable.
Example:
locals {
instance_type = "t2.micro"
ami_id = "ami-0c55b159cbfafe1f0"
}
resource "aws_instance" "example" {
ami = local.ami_id
instance_type = local.instance_type
}
109. How do you handle provider dependencies in Terraform?
Provider dependencies in Terraform are managed using the required_providers block in
the terraform block, specifying the version constraints.
Example:
terraform {
required_providers {
aws = {
source = "hashicorp/aws"
version = "~> 3.0"
}
}
}
110. What is the terraform apply command used for?
terraform apply applies the changes required to reach the desired state of the configuration.
It executes the plan created by terraform plan.
Example:
terraform apply
111. What is the terraform destroy command used for?
terraform destroy is used to destroy the infrastructure managed by Terraform. It removes all
the resources defined in the configuration.
Example:
terraform destroy
112. What are output values in Terraform and how are they used?
Output values are used to extract information from the resources and make it accessible after
the apply phase. They can be used to output resource attributes.
Example:
output "instance_id" {
value = aws_instance.example.id
}
113. How do you manage different environments (e.g., dev, prod) in
Terraform?
Different environments can be managed using workspaces or separate directories with different
variable files and state files.
Example:
terraform workspace new dev
terraform workspace new prod
114. What is the difference between count and for_each in Terraform?
count is used to create multiple instances of a resource, while for_each is used to iterate over a
map or set of values to create multiple instances.
Example (count):
resource "aws_instance" "example" {
count = 3
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
}
Example (for_each):
resource "aws_instance" "example" {
for_each = toset(["instance1", "instance2"])
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
tags = {
Name = each.key
}
}
115. How do you use loops in Terraform?
Loops in Terraform can be implemented using the count and for_each meta-arguments, as
well as the for expression in variable assignments.
Example:
variable "instance_names" {
type = list(string)
default = ["instance1", "instance2"]
}
resource "aws_instance" "example" {
for_each = toset(var.instance_names)
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
tags = {
Name = each.key
}
}
116. What is a count parameter in Terraform?
The count parameter in Terraform is used to create multiple instances of a resource based on a
specified number.
Example:
resource "aws_instance" "example" {
count = 3
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
}
117. What are Terraform Cloud and Terraform Enterprise?
Terraform Cloud and Terraform Enterprise are commercial versions of Terraform that provide
collaboration, governance, and automation features.
Example:
terraform {
backend "remote" {
organization = "my-org"
workspaces {
name = "my-workspace"
}
}
}
118. How do you use a Terraform backend?
A backend is configured using the terraform block in the configuration file, specifying the
backend type and its configuration.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
119. What is the terraform fmt command used for?
terraform fmt formats the configuration files
to follow the Terraform style guide, making the code consistent and readable.
Example:
terraform fmt
120. How do you use a lock file in Terraform?
A lock file (.terraform.lock.hcl) is used to lock provider versions, ensuring consistency in
provider versions across different environments.
Example:
terraform init
121. What is the purpose of the terraform workspace command?
The terraform workspace command is used to create, select, and manage multiple
workspaces, allowing different states to be associated with the same configuration.
Example:
terraform workspace new dev
terraform workspace select dev
122. How do you manage secrets in Terraform?
Secrets can be managed using environment variables, secure secret management services (e.g.,
AWS Secrets Manager), or Terraform's sensitive attribute.
Example:
resource "aws_secretsmanager_secret" "example" {
name = "example"
description = "An example secret"
}
resource "aws_secretsmanager_secret_version" "example" {
secret_id = aws_secretsmanager_secret.example.id
secret_string = jsonencode({
username = "example_user"
password = "example_password"
})
}
123. What is the terraform console command used for?
terraform console opens an interactive console for evaluating expressions, testing
interpolation syntax, and debugging configurations.
Example:
terraform console
124. How do you reference data sources in Terraform?
Data sources are referenced using the data block and can be used to fetch information about
existing infrastructure or services.
Example:
data "aws_ami" "example" {
most_recent = true
owners = ["amazon"]
filter {
name = "name"
values = ["amzn-ami-hvm-*"]
}
}
resource "aws_instance" "example" {
ami = data.aws_ami.example.id
instance_type = "t2.micro"
}
125. What is the purpose of the terraform state mv command?
terraform state mv moves a resource in the state file to a new address, useful for renaming
resources without recreating them.
Example:
terraform state mv aws_instance.old_name aws_instance.new_name
126. What is a backend in Terraform?
A backend in Terraform defines where and how state is loaded and stored. It can be local or
remote (e.g., S3, Consul, etc.).
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
127. How do you secure the state file in Terraform?
State files can be secured by storing them in remote backends with proper access controls and
encryption, such as AWS S3 with server-side encryption and access control policies.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
encrypt = true
}
}
128. What is the difference between local and remote backends in
Terraform?
Local backends store the state file on the local filesystem, while remote backends store the state
file in a remote storage service (e.g., S3, Consul).
Example (local backend):
terraform {
backend "local" {
path = "terraform.tfstate"
}
}
Example (remote backend):
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
129. How do you manage module versioning in Terraform?
Module versioning in Terraform can be managed using the version argument in
the source attribute of a module block, typically in combination with a registry.
Example:
module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "2.0.0"
}
130. What is the Terraform Registry?
The Terraform Registry is a public repository of Terraform modules and providers that can be
used to discover and use pre-built modules and providers.
Example:
module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "2.0.0"
}
131. How do you generate and view a resource graph in Terraform?
A resource graph can be generated using the terraform graph command and can be viewed
using tools like Graphviz.
Example:
terraform graph | dot -Tpng > graph.png
132. What is the purpose of the terraform validate command?
terraform validate is used to validate the syntax and configuration of the Terraform files
without creating any resources.
Example:
terraform validate
133. What is the terraform fmt command used for?
terraform fmt formats the configuration files to follow the Terraform style guide, making the
code consistent and readable.
Example:
terraform fmt
134. What are locals in Terraform and how do you use them?
Locals in Terraform are used to define local values that can be reused within a module. They help
avoid repetition and make configurations more readable.
Example:
locals {
instance_type = "t2.micro"
ami_id = "ami-0c55b159cbfafe1f0"
}
resource "aws_instance" "example" {
ami = local.ami_id
instance_type = local.instance_type
}
135. How do you handle provider dependencies in Terraform?
Provider dependencies in Terraform are managed using the required_providers block in
the terraform block, specifying the version constraints.
Example:
terraform {
required_providers {
aws = {
source = "hashicorp/aws"
version = "~> 3.0"
}
}
}
136. What is the terraform apply command used for?
terraform apply applies the changes required to reach the desired state of the configuration.
It executes the plan created by terraform plan.
Example:
terraform apply
137. What is the terraform destroy command used for?
terraform destroy is used to destroy the infrastructure managed by Terraform. It removes all
the resources defined in the configuration.
Example:
terraform destroy
138. What are output values in Terraform and how are they used?
Output values are used to extract information from the resources and make it accessible after
the apply phase. They can be used to output resource attributes.
Example:
output "instance_id" {
value = aws_instance.example.id
}
139. How do you manage different environments (e.g., dev, prod) in
Terraform?
Different environments can be managed using workspaces or separate directories with different
variable files and state files.
Example:
terraform workspace new dev
terraform workspace new prod
140. What is the difference between count and for_each in Terraform?
count is used to create multiple instances of a resource, while for_each is used to iterate over a
map or set of values to create multiple instances.
Example (count):
resource "aws_instance" "example" {
count = 3
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
}
Example (for_each):
resource "aws_instance" "example" {
for_each = toset(["instance1", "instance2"])
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
tags = {
Name = each.key
}
}
143. What are Terraform Cloud and Terraform Enterprise?
Terraform Cloud and Terraform Enterprise are commercial versions of Terraform that provide
collaboration, governance, and automation features.
Example:
terraform {
backend "remote" {
organization = "my-org"
workspaces {
name = "my-workspace"
}
}
}
144. How do you use a Terraform backend?
A backend is configured using the terraform block in the configuration file, specifying the
backend type and its configuration.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
145. What is the terraform fmt command used for?
terraform fmt formats the configuration files to follow the Terraform style guide, making the
code consistent and readable.
Example:
terraform fmt
146. How do you use a lock file in Terraform?
A lock file (.terraform.lock.hcl) is used to lock provider versions, ensuring consistency in
provider versions across different environments.
Example:
terraform init
147. What is the purpose of the terraform workspace command?
The terraform workspace command is used to create, select, and manage multiple
workspaces, allowing different states to be associated with the same configuration.
Example:
terraform workspace new dev
terraform workspace select dev
148. How do you manage secrets in Terraform?
Secrets can be managed using environment variables, secure secret management services (e.g.,
AWS Secrets Manager), or Terraform's sensitive attribute.
Example:
resource "aws_secretsmanager_secret" "example" {
name = "example"
description = "An example secret"
}
resource "aws_secretsmanager_secret_version" "example" {
secret_id = aws_secretsmanager_secret.example.id
secret_string = jsonencode({
username = "example_user"
password = "example_password"
})
}
149. What is the terraform console command used for?
terraform console opens an interactive console for evaluating expressions, testing
interpolation syntax, and debugging configurations.
Example:
terraform console
150. How do you reference data sources in Terraform?
Data sources are referenced using the data block and can be used to fetch information about
existing infrastructure or services.
Example:
data "aws_ami" "example" {
most_recent = true
owners = ["amazon"]
filter {
name = "name"
values = ["amzn-ami-hvm-*"]
}
}
resource "aws_instance" "example" {
ami = data.aws_ami.example.id
instance_type = "t2.micro"
}
151. What is the purpose of the terraform state mv command?
terraform state mv moves a resource in the state file to a new address, useful for renaming
resources without recreating them.
Example:
terraform state mv aws_instance.old_name aws_instance.new_name
152. What is a backend in Terraform?
A backend in Terraform defines where and how state is loaded and stored. It can be local or
remote (e.g., S3, Consul, etc.).
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
153. How do you secure the state file in Terraform?
State files can be secured by storing them in remote backends with proper access controls and
encryption, such as AWS S3 with server-side encryption and access control policies.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
encrypt = true
}
}
154. What is the difference between local and remote backends in
Terraform?
Local backends store the state file on the local filesystem, while remote backends store the state
file in a remote storage service (e.g., S3, Consul).
Example (local backend):
terraform {
backend "local" {
path = "terraform.tfstate"
}
}
Example (remote backend):
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
155. How do you manage module versioning in Terraform?
Module versioning in Terraform can be managed using the version argument in
the source attribute of a module block, typically in combination with a registry.
Example:
module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "2.0.0"
}
156. What is the Terraform Registry?
The Terraform Registry is a public repository of Terraform modules and providers that can be
used to discover and use pre-built modules and providers.
Example:
module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "2.0.0"
}
157. How do you generate and view a resource graph in Terraform?
A resource graph can be generated using the terraform graph command and can be viewed
using tools like Graphviz.
Example:
terraform graph | dot -Tpng > graph.png
158. What is the purpose of the terraform validate command?
terraform validate is used to validate the syntax and configuration of the Terraform files
without creating any resources.
Example:
terraform validate
159. What is the terraform fmt command used for?
terraform fmt formats the configuration files to follow the Terraform style guide, making the
code consistent and readable.
Example:
terraform fmt
160. What are locals in Terraform and how do you use them?
Locals in Terraform are used to define local values that can be reused within a module. They help
avoid repetition and make configurations more readable.
Example:
locals {
instance_type = "t2.micro"
ami_id = "ami-0c55b159cbfafe1f0"
}
resource "aws_instance" "example" {
ami = local.ami_id
instance_type = local.instance_type
}
161. How do you handle provider dependencies in Terraform?
Provider dependencies in Terraform are managed using the required_providers block in
the terraform block, specifying the version constraints.
Example:
terraform {
required_providers {
aws = {
source = "hashicorp/aws"
version = "~> 3.0"
}
}
}
162. What is the terraform apply command used for?
terraform apply applies the changes required to reach the desired state of the configuration.
It executes the plan created by terraform plan.
Example:
terraform apply
163. What is the terraform destroy command used for?
terraform destroy is used to destroy the infrastructure managed by Terraform. It removes all
the resources defined in the configuration.
Example:
terraform destroy
164. What are output values in Terraform and how are they used?
Output values are used to extract information from the resources and make it accessible after
the apply phase. They can be used to output resource attributes.
Example:
output "instance_id" {
value = aws_instance.example.id
}
165. How do you manage different environments (e.g., dev, prod) in
Terraform?
Different environments can be managed using workspaces or separate directories with different
variable files and state files.
Example:
terraform workspace new dev
terraform workspace new prod
166. What is the difference between count and for_each in Terraform?
count is used to create multiple instances of a resource, while for_each is used to iterate over a
map or set of values to create multiple instances.
Example (count):
resource "aws_instance" "example" {
count = 3
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
}
Example (for_each):
resource "aws_instance" "example" {
for_each = toset(["instance1", "instance2"])
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
tags = {
Name = each.key
}
}
167. How do you use loops in Terraform?
Loops in Terraform can be implemented using the count and for_each meta-arguments, as
well as the for expression in variable assignments.
Example:
variable "instance_names" {
type = list(string)
default = ["instance1", "instance2"]
}
resource "
aws_instance" "example" {
for_each = toset(var.instance_names)
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
tags = {
Name = each.key
}
}
168. What is a count parameter in Terraform?
The count parameter in Terraform is used to create multiple instances of a resource based on a
specified number.
Example:
resource "aws_instance" "example" {
count = 3
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
}
169. What are Terraform Cloud and Terraform Enterprise?
Terraform Cloud and Terraform Enterprise are commercial versions of Terraform that provide
collaboration, governance, and automation features.
Example:
terraform {
backend "remote" {
organization = "my-org"
workspaces {
name = "my-workspace"
}
}
}
170. How do you use a Terraform backend?
A backend is configured using the terraform block in the configuration file, specifying the
backend type and its configuration.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
171. What is the terraform fmt command used for?
terraform fmt formats the configuration files to follow the Terraform style guide, making the
code consistent and readable.
Example:
terraform fmt
172. How do you use a lock file in Terraform?
A lock file (.terraform.lock.hcl) is used to lock provider versions, ensuring consistency in
provider versions across different environments.
Example:
terraform init
173. What is the purpose of the terraform workspace command?
The terraform workspace command is used to create, select, and manage multiple
workspaces, allowing different states to be associated with the same configuration.
Example:
terraform workspace new dev
terraform workspace select dev
174. How do you manage secrets in Terraform?
Secrets can be managed using environment variables, secure secret management services (e.g.,
AWS Secrets Manager), or Terraform's sensitive attribute.
Example:
resource "aws_secretsmanager_secret" "example" {
name = "example"
description = "An example secret"
}
resource "aws_secretsmanager_secret_version" "example" {
secret_id = aws_secretsmanager_secret.example.id
secret_string = jsonencode({
username = "example_user"
password = "example_password"
})
}
175. What is the terraform console command used for?
terraform console opens an interactive console for evaluating expressions, testing
interpolation syntax, and debugging configurations.
Example:
terraform console
176. How do you reference data sources in Terraform?
Data sources are referenced using the data block and can be used to fetch information about
existing infrastructure or services.
Example:
data "aws_ami" "example" {
most_recent = true
owners = ["amazon"]
filter {
name = "name"
values = ["amzn-ami-hvm-*"]
}
}
resource "aws_instance" "example" {
ami = data.aws_ami.example.id
instance_type = "t2.micro"
}
177. What is the purpose of the terraform state mv command?
terraform state mv moves a resource in the state file to a new address, useful for renaming
resources without recreating them.
Example:
terraform state mv aws_instance.old_name aws_instance.new_name
178. What is a backend in Terraform?
A backend in Terraform defines where and how state is loaded and stored. It can be local or
remote (e.g., S3, Consul, etc.).
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
179. How do you secure the state file in Terraform?
State files can be secured by storing them in remote backends with proper access controls and
encryption, such as AWS S3 with server-side encryption and access control policies.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
encrypt = true
}
}
180. What is the difference between local and remote backends in
Terraform?
Local backends store the state file on the local filesystem, while remote backends store the state
file in a remote storage service (e.g., S3, Consul).
Example (local backend):
terraform {
backend "local" {
path = "terraform.tfstate"
}
}
Example (remote backend):
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
181. How do you manage module versioning in Terraform?
Module versioning in Terraform can be managed using the version argument in
the source attribute of a module block, typically in combination with a registry.
Example:
module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "2.0.0"
}
182. What is the Terraform Registry?
The Terraform Registry is a public repository of Terraform modules and providers that can be
used to discover and use pre-built modules and providers.
Example:
module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "2.0.0"
}
183. How do you generate and view a resource graph in Terraform?
A resource graph can be generated using the terraform graph command and can be viewed
using tools like Graphviz.
Example:
terraform graph | dot -Tpng > graph.png
184. What is the purpose of the terraform validate command?
terraform validate is used to validate the syntax and configuration of the Terraform files
without creating any resources.
Example:
terraform validate
185. What is the terraform fmt command used for?
terraform fmt formats the configuration files to follow the Terraform style guide, making the
code consistent and readable.
Example:
terraform fmt
186. What are locals in Terraform and how do you use them?
Locals in Terraform are used to define local values that can be reused within a module. They help
avoid repetition and make configurations more readable.
Example:
locals {
instance_type = "t2.micro"
ami_id = "ami-0c55b159cbfafe1f0"
}
resource "aws_instance" "example" {
ami = local.ami_id
instance_type = local.instance_type
}
187. How do you handle provider dependencies in Terraform?
Provider dependencies in Terraform are managed using the required_providers block in
the terraform block, specifying the version constraints.
Example:
terraform {
required_providers {
aws = {
source = "hashicorp/aws"
version = "~> 3.0"
}
}
}
188. What is the terraform apply command used for?
terraform apply applies the changes required to reach the desired state of the configuration.
It executes the plan created by terraform plan.
Example:
terraform apply
189. What is the terraform destroy command used for?
terraform destroy is used to destroy the infrastructure managed by Terraform. It removes all
the resources defined in the configuration.
Example:
terraform destroy
190. What are output values in Terraform and how are they used?
Output values are used to extract information from the resources and make it accessible after
the apply phase. They can be used to output resource attributes.
Example:
output "instance_id" {
value = aws_instance.example.id
}
191. How do you manage different environments (e.g., dev, prod) in
Terraform?
Different environments can be managed using workspaces or separate directories with different
variable files and state files.
Example:
terraform workspace new dev
terraform workspace new prod
192. What is the difference between count and for_each in Terraform?
count is used to create multiple instances of a resource, while for_each is used to iterate over a
map or set of values to create multiple instances.
Example (count):
resource "aws_instance" "example" {
count = 3
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
}
Example (for
_each):
resource "aws_instance" "example" {
for_each = toset(["instance1", "instance2"])
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
tags = {
Name = each.key
}
}
193. How do you use loops in Terraform?
Loops in Terraform can be implemented using the count and for_each meta-arguments, as
well as the for expression in variable assignments.
Example:
variable "instance_names" {
type = list(string)
default = ["instance1", "instance2"]
}
resource "aws_instance" "example" {
for_each = toset(var.instance_names)
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
tags = {
Name = each.key
}
}
194. What is a count parameter in Terraform?
The count parameter in Terraform is used to create multiple instances of a resource based on a
specified number.
Example:
resource "aws_instance" "example" {
count = 3
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
}
195. What are Terraform Cloud and Terraform Enterprise?
Terraform Cloud and Terraform Enterprise are commercial versions of Terraform that provide
collaboration, governance, and automation features.
Example:
terraform {
backend "remote" {
organization = "my-org"
workspaces {
name = "my-workspace"
}
}
}
196. How do you use a Terraform backend?
A backend is configured using the terraform block in the configuration file, specifying the
backend type and its configuration.
Example:
terraform {
backend "s3" {
bucket = "my-terraform-state"
key = "global/s3/terraform.tfstate"
region = "us-west-2"
}
}
197. What is the terraform fmt command used for?
terraform fmt formats the configuration files to follow the Terraform style guide, making the
code consistent and readable.
Example:
terraform fmt
198. How do you use a lock file in Terraform?
A lock file (.terraform.lock.hcl) is used to lock provider versions, ensuring consistency in
provider versions across different environments.
Example:
terraform init
199. What is the purpose of the terraform workspace command?
The terraform workspace command is used to create, select, and manage multiple
workspaces, allowing different states to be associated with the same configuration.
Example:
terraform workspace new dev
terraform workspace select dev
200. How do you manage secrets in Terraform?
Secrets can be managed using environment variables, secure secret management services (e.g.,
AWS Secrets Manager), or Terraform's sensitive attribute.
Example:
resource "aws_secretsmanager_secret" "example" {
name = "example"
description = "An example secret"
}
resource "aws_secretsmanager_secret_version" "example" {
secret_id = aws_secretsmanager_secret.example.id
secret_string = jsonencode({
username = "example_user"
password = "example_password"
})
}