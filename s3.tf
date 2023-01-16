resource "aws_s3_bucket" "seada-s3-task1" {
  bucket = "maczbucket1"
  tags = {
    Name = "seada-s3-task1"
  }
}

resource "aws_s3_bucket" "seada-s3-task2" {
  bucket = "seada-s3-task2"
  tags = {
    Name = "seada-s3-task2"
  }
}
