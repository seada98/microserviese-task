resource "aws_sns_topic" "topic_sns" {
  name = "s3-notification"

  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": { "Service": "s3.amazonaws.com" },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:s3-notification",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.seada-s3-task1.arn}"}
        }
    }]
}
POLICY
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.seada-s3-task1.id
  topic {
    topic_arn = aws_sns_topic.topic_sns.arn
    events    = ["s3:ObjectCreated:*"]
  }
}


resource "aws_sns_topic_subscription" "email-target2" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = "mohamedseada1998@hotmail.com"
}
