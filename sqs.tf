resource "aws_sqs_queue" "queue1" {
  name = "First-Queue"
  visibility_timeout_seconds = 15
    redrive_policy    = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount    = 5
  })
}

resource "aws_sqs_queue" "queue2" {
  name = "Secound-Queue"
  visibility_timeout_seconds = 300
}

resource "aws_sqs_queue" "dead_letter_queue" {
  name              = "Dead-Letter-Queue"
  visibility_timeout_seconds = 300
}

resource "aws_sqs_queue_policy" "policy" {
  queue_url = aws_sqs_queue.queue1.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.queue1.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.topic_sns.arn}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sns_topic_subscription" "sqs_target1" {
  topic_arn = aws_sns_topic.topic_sns.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.queue1.arn
}

resource "aws_sns_topic_subscription" "sqs_target2" {
  topic_arn = aws_sns_topic.topic_sns.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.queue2.arn
}
