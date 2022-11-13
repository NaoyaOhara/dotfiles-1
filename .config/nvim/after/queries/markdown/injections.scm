;; extends

(fenced_code_block
  (info_string) @lang
  (code_fence_content) @content
  (#vim-match? @lang "^(sh|bash|shell)$")
  (#set! language "bash")
)

(fenced_code_block
  (info_string) @lang
  (code_fence_content) @content
  (#vim-match? @lang "^prompt$")
  (#set! language "bash")
)

(fenced_code_block
  (info_string) @lang
  (code_fence_content) @content
  (#vim-match? @lang "^(vim)(:.*)?$")
  (#set! language vim)
)

(fenced_code_block
  (info_string) @lang
  (code_fence_content) @content
  (#vim-match? @lang "^(lua)(:.*)?$")
  (#set! language lua)
)
