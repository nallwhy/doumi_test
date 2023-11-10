# Used by "mix format"
locals_without_parens = [
  assert_same_values: 2,
  assert_same_fields: 3,
  assert_same_records: 2
]

[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  locals_without_parens: locals_without_parens,
  export: [locals_without_parens: locals_without_parens]
]
