metabase-backup-download:
	scp dwcc-reports:/home/app/metabase/metabase.db.mv.db ~/Downloads

s3-backup-open:
	open https://s3.console.aws.amazon.com/s3/buckets/metabase-backup-files?region=ap-south-1&tab=objects