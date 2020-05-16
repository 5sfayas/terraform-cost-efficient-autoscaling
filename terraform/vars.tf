variable"AWS_ACCESS_KEY"{}
variable"AWS_SECRET_KEY"{}
variable"AWS_REGION"{
default="eu-west-1"
}

variable AMIS{
type="map"
defualt= {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
	}
}

variable "PATH_TO_PRIVATE_KEY"{
default="tom"
}
variable "PATH_TO_PUBLIC_KEY"{
default="tom.pub"
}
variable "INSTANCE_NAME"{
default="ubuntu"
}

