---
terraform
- arguments
- objects
-


# what is packer and it's advantages?
# we can get data from one resource to another resource by using "reference attribute".
- ${radnod._pet.my_pet.id}  # like this we call one recourse form other resource

# what is interpolation , it suse
# by using resource dependency we can  manage  other resources.
# what is terraform refresh?
	- terraform plan --refresh=false #  it dows not  create resource every time, it just refresh and by pass theraform plan command 
# terraform fmt: terraform format command: 
	- terraform show
	- terraform show -json
	-terraform provider mirror <dir path? # to move provider configuration to other folder 
#
-  terraform output  # to see all outputs
- terraform output -<perticular_resource_name> # to see only one output

# terafrom refresh : this command refresh the state file
- it just not crate any infra but just update  state file

#
- terraform graph 
- terraform install graphviz -y # to see terraform resources in graph in visual format
- 

# configuration drift: and mutable infrastructure:
- some times while updating any packages some dependencies mismatch, the upgrade version is not complete in one of the server, then while updating it by terraform apply, then we might face terraform drift.
- this time , insted  of updating that one server, we delete that one server and create  new instance by the update configuration
- this process is called mutable infrastructure

# immutableinsrastructure  inplace of upating new server, it just automatically delete that failed server and intact with the old one server with its configuration itself. 


# instead of deleteing resource first, and then creating new resource by tf , i wnat to crate first and delte old one, then we can achieve by lifecycle rules.

# life cycles rules
- create _before_destory=true
- prevent_destroy=true
-ignore_changes attribute : it ignore changes of resoureces  attributes
- 

# data soruces 
- to read data of any file, we use as data resource block

# meta arguments
-count meta argumnet: 
- length: instad of we using count meta argument, we use  length argument, so terraform automaticallly detect number of objects. so that it identify dynmaicaly size of varibalbe. in this rewsorces are crared in  form of list.
- for_each argument: while using   for_each , we use each argument for applying values, for-each isused for looping objects.  for each argument works with only 'map" "set" type. 
- if i want to use "list" as type , then i can use "toset" which is convert list to set.
- by this for_each, we can bypass issues when we use count, i.e index problems we can avoid.
- for_each create resourrces in form of map, while count crates resources inform of list.


#  version constraints
- in the 


# policy: it gives persmison to access resourcres

# role: to interact one service to other service we use role.

#IAM
-aws iam create-user --user-name ashok
- 


# function
-insted we write entire iam policy in mian.tf , we write another file in same dir of main.tf and  to read policy.json file we use  file function.
-


# s3
- max s3 bucket  size 
-bucket poliices given at bucket level
- acees control  list is given at object level
- 


# dynamodb
- it is no sql database solution provided by aws, .it means ( no sql ) it stored data in form of key and value format.
- it is highly scalable database which can handle million requests from applications
- fully managed by aws, so no need to managed any servers for this
- all database upgradatuion process is manged by aws itself

# 





