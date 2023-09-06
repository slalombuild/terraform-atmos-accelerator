enabled        = true
namespace      = "test"
environment    = "kms"
stage          = "uw2"
label_key_case = "lower"
project_id     = "platlive-nonprod"
attributes     = []
tags           = {}

location           = "US"
create_default_key = true
keys               = []

## Must Pass the owners_iam when the set_owners_for_default_key = true or set_owners_for != []
set_owners_for_default_key = false
owners_iam                 = ["user:test@gmail.com"]
set_owners_for             = []

## Must Pass the encrypters_iam when the set_encrypters_for_default_key = true or set_encrypters_for != []
set_encrypters_for_default_key = false
encrypters_iam                 = ["group:test@gmail.com"]
set_encrypters_for             = []

## Must Pass the decrypters_iam when the set_decrypters_for_default_key = true or set_decrypters_for != []
set_decrypters_for_default_key = false
decrypters_iam                 = ["serviceaccount:test@gmail.com"]
set_decrypters_for             = []

