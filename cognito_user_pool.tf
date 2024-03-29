resource "aws_cognito_user_pool" "tfer--foodieflow" {
  account_recovery_setting {
    recovery_mechanism {
      name     = "admin_only"
      priority = "1"
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = "false"
  }

  alias_attributes    = ["email", "preferred_username"]
  deletion_protection = "INACTIVE"

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  lambda_config {
    create_auth_challenge          = "arn:aws:lambda:us-east-1:730335442495:function:create-auth-challenge"
    define_auth_challenge          = "arn:aws:lambda:us-east-1:730335442495:function:define-auth-challenge"
    pre_sign_up                    = "arn:aws:lambda:us-east-1:730335442495:function:pre-signup-new"
    verify_auth_challenge_response = "arn:aws:lambda:us-east-1:730335442495:function:verify-auth-challenge"
  }

  mfa_configuration = "OFF"
  name              = "foodieflow"

  password_policy {
    minimum_length                   = "8"
    require_lowercase                = "false"
    require_numbers                  = "false"
    require_symbols                  = "false"
    require_uppercase                = "false"
    temporary_password_validity_days = "7"
  }

  username_configuration {
    case_sensitive = "false"
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name                          = "foodieFlowClient"
  user_pool_id                  = aws_cognito_user_pool.tfer--foodieflow.id
  generate_secret               = false
  prevent_user_existence_errors = "ENABLED"
  refresh_token_validity        = 30
  enable_token_revocation       = false
}