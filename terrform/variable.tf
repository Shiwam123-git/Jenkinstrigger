variable "region" {
  description = "The AWS region to create resources in"
  type        = string

}

variable "instance" {
  description = "EC2 instances configuration"
  type = map(object({
    ami_type      = string
    instance_type = string

    root_volume = object({
      volume_size = number
      volume_type = string
    })
  }))
}