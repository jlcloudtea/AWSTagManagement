#!/bin/bash

PS3='Please enter your choice or press 3 to quit: '
options=("Create Tag Management Stack" "Delete Tag Management Stack" "Quit")
select opt in "${options[@]}"
do
  case $opt in
	"Create Tag Management Stack")
	  echo "you chose choice 1"
	  echo '-------------------------------------------------------------'
	  echo ' 	Please wait 2-5 mins until new prompt message...           '
	  echo '-------------------------------------------------------------'
	  aws cloudformation create-stack --stack-name TagMan --template-body "file://TagMan.json" >/dev/null 2>&1
	  aws cloudformation wait stack-create-complete --stack-name TagMan
 	  echo '-------------------------------------------------------------'
	  echo '	Setup Completed You can start the assessment tasks          '
	  echo '-------------------------------------------------------------'
	  echo "Below is the related information for your reference"
   	  aws cloudformation describe-stacks --stack-name TagMan --query "Stacks[*].Outputs[*].{OutputKey: OutputKey, OutputValue: OutputValue, Description: Description}" --output table
	  break
	  ;;
	"Delete Tag Management Stack")
	  aws cloudformation delete-stack --stack-name TagMan
	  echo '-------------------------------------------------------------'
	  echo '	Deleting Tag Management Stack may takes 2-5 mins    '
	  echo '-------------------------------------------------------------'
	  break
	  ;;
	"Quit")
	  break
	  ;;
   	*) echo "invalid option $REPLY";;
  esac
done
