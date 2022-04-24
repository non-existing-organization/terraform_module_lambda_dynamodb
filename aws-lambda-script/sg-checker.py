import boto3
import os

table_name = os.environ['table_name']
attribute_name = os.environ['attribute_name']


def put_dynamo_item(tableName, securityGroup, attributeName, list_items):
    dynamo_client = boto3.client("dynamodb")
    if securityGroup not in list_items:
        print("adding sg {} to the dynamodb table".format(securityGroup))
        response = dynamo_client.put_item(TableName=tableName, Item={
            attributeName: {
                'S': securityGroup
            }
        })
        return response


def delete_unnecessary_sg(tableName, attributeName, sg_list, list_items):
    dynamo_client = boto3.client("dynamodb")
    for sg in list_items:
        if sg not in sg_list:
            print("sg {} from dynamodb table does not exist in list retrieved from the ec2 API or the sg rules were remediated, removing from table....".format(sg))
            response = dynamo_client.delete_item(TableName=tableName, Key={attribute_name: {'S': sg}})
            print(response)


def scan_security_groups():
    list = []
    ec2_client = boto3.client("ec2")
    response = ec2_client.describe_security_groups()
    for sg in response["SecurityGroups"]:
        for ippermissions in sg["IpPermissions"]:
            for range in ippermissions["IpRanges"]:
                if range["CidrIp"] == "0.0.0.0/0":
                    if not sg["GroupId"] in list:
                        list.append(sg["GroupId"])
    return list


def scan_dynamo_table_items(tableName):
    list = []
    dynamo_client = boto3.client("dynamodb")
    response = dynamo_client.scan(TableName=tableName)
    for item in response["Items"]:
        list.append(item["SecurityGroupId"]["S"])
    return list


def handler(event, context):
    sg_list = scan_security_groups()
    list_items = scan_dynamo_table_items(table_name)
    print("SGs retrieved from Ec2 security groups --> {} \n SGs retrieved from DynamoDB table --> {}".format(sg_list, list_items))

    for sg in sg_list:
        put_dynamo_item(table_name, sg, attribute_name, list_items)
    delete_unnecessary_sg(table_name, attribute_name, sg_list, list_items)
