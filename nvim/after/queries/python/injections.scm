;; extends

; function/method docstring
(function_definition
  body: (block .
    (expression_statement
      (string
        (string_content) @injection.content (#set! injection.language "rst")
      )
    )
  )
)

; module docstring
(module .
  (expression_statement
    (string
      (string_content) @injection.content (#set! injection.language "rst")
    )
  )
)
