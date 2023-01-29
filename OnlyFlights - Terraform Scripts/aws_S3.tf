# // S3 bucker for hosting static website
# resource "aws_s3_bucket" "onlyflights_static-web" {
#   bucket = "www.onlyflights.net"
#   acl    = "public-read"
#   policy = <<EOF
#     {
#         "Version": "2012-10-17",
#         "Statement": [
#             {
#                 "Sid": "PublicReadGetObject",
#                 "Effect": "Allow",
#                 "Principal": "*",
#                 "Action": "s3:GetObject",
#                 "Resource": "arn:aws:s3:::www.onlyflights.net/*"
#             }
#         ]
#     }
#     EOF

#   server_side_encryption_configuration {
#     rule{
#         apply_server_side_encryption_by_default {
#           sse_algorithm = "AES256"
#         }
#     }
#   }

#   versioning {
#     enabled = true
#   }

#   website {
#     index_document = "index.html"
#   }
# }

# // Import static website file to the bucket
# resource "aws_s3_bucket_object" "upload-index-file" {
#   key = "index.html"
#   bucket = "${aws_s3_bucket.onlyflights_static-web.id}"
#   source = "static-website/index.html"
# }