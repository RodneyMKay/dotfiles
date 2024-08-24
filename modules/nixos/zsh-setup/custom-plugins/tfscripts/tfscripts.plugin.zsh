t() {
    if [ -f ./terragrunt.hcl ]; then
        terragrunt $@
    else
        terraform $@
    fi
}

alias ta="t apply"
alias tp="t plan"
