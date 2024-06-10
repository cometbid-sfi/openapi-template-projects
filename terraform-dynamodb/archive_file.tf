data "archive_file" "notes_api" {
  type             = "zip"
  source_dir       = "${path.module}/lambdas"
  output_file_mode = "0666"
  output_path      = "${path.module}/tmp/notes-api.zip"
}