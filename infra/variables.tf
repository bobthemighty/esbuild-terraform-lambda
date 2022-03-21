variable package_filename {
  type = string
}

variable lambda_function_name {
  type = string
  default = "say-hello"
}

variable lambda_handler {
  type = string
  default = "index.handler"
}

variable project_name {
  type = string
  default = "article-esbuild-terraform"
}
