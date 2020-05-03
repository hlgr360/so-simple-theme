---
layout: post
title: "Accessing AWS RDS from local shell"
categories: blog
excerpt: "How to access a AWS RDS instance from your local command line"
tags: [development, aws]
author: hlgr360
share: true
---

Another weekend, another gotcha. The task for today was to enable my son to connect his upcoming Firefox Theme manager to a MySQL database. After some frustrating attempts to install MySQL bloatware locally, I suggested he quickly spins up a RDS instance in our AWS account to test it. 

Well, if life would be just that easy. Getting the instance up and running was easy enough, but then we hit a wall by trying to connect to it locally. See, the default setting of AWS RDS is to create the DB instance in a lockdown state - without public internet access, sending an unsuspectING Developer on a goose chase around the documentation trying to figure out how to reconfigure it. And yes, I know its a good practice to create the database instance in lock-down state, but not everyone likes to chase down the config settings to run a quick experiment.

As it turns out there are two settings, you need to change to be able to connect to your RDS instance from your local system:

(1) When you create the RDS instance do not use the `Easy Create` option but stick to the `Standard Create`. Fill in the configuration parameters as you see fit but pay attention when you come to the `Connectivity` Settings panel. Unfold the `Additional Connectivity Settings` and set the `Public Accessible` to `Yes`. Then continue to create your database instance.

(2) After the database has been created, select the database instance in the AWS RDS Management console. Under `Connectivity & Security` select the `VPC Security Group` under the `Security` column. The `EC2 Management` page opens with the `Security Group` pre-selected. Select `Action / Edit Inbound Roules`. Add a new rule for your database (i.e. custom-tcp and port or MYSQL/Aurora in our case for MySQL). For `Source` use `My IP` to allow AWS to determine your local IP. Add the rule and you should be able to connect from your local CLI to the RDS instance.

Thats it - may the code be with you.

### Further reading
* <https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Troubleshooting.html#CHAP_Troubleshooting.Connecting>
* <https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SettingUp.html#CHAP_SettingUp.SecurityGroup>

