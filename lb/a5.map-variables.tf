variable "dasauto" {
  description = "das auto manufacture car"
  type        = map(string)
  #in map string if you want to provide defauly value it need to be provider
  #in key value format
  default = {
    "bentley" = "vwg",
    "audi"    = "vwg"
  }
}