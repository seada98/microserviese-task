import boto3
s3 = boto3.resource('s3')
s3.meta.client.upload_file('/home/mohamed/microserviese-task/file.txt', 'seada-s3-task1', 'file.txt')
print ("File Upload Successfully .. !!")
