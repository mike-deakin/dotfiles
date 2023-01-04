((template_string) @graphql
  (#match? @graphql "\s*(query|mutation).*")
  (#offset! @graphql 0 1 0 -1))
